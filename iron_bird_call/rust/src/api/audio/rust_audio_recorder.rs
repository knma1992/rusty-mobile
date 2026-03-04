use anyhow::Result;
use cpal::{
    traits::{DeviceTrait, HostTrait, StreamTrait},
    BufferSize, Device, StreamConfig,
};

use std::sync::Mutex;
use std::{
    collections::VecDeque,
    sync::mpsc::{channel, Receiver, Sender},
};

use flutter_rust_bridge::frb;

use crate::{api::audio::audio_util::downsample_minmax, frb_generated::StreamSink};

use crate::api::audio::audio_util::{downmix_to_mono, get_best_buffer_size, get_best_sample_rate};

#[frb(ignore)]
enum StreamCommand {
    Stop,
}

#[frb(opaque)]
pub struct RustAudioRecorder {
    pub _buffer_size: Option<u32>,
    pub channels: u16,
    _cpal_buffer_size: BufferSize,
    pub sample_rate: u32,
    device: Device,
    stream_config: StreamConfig,
    control_tx: Mutex<Option<Sender<StreamCommand>>>,
}

impl RustAudioRecorder {
    #[flutter_rust_bridge::frb(sync)]
    pub fn new() -> Result<Self> {
        let host = cpal::default_host();

        let device = host
            .default_input_device()
            .expect("No inpout device available");

        let sample_rate = get_best_sample_rate(&device)?;

        let (buffer_size, channels) = get_best_buffer_size(&device, sample_rate)?;

        let (buffer_size, cpal_buffer_size) = match buffer_size {
            Some(buffer_size) => (Some(buffer_size), cpal::BufferSize::Fixed(buffer_size)),
            None => (None, cpal::BufferSize::Default),
        };

        Ok(RustAudioRecorder {
            _buffer_size: buffer_size,
            channels,
            _cpal_buffer_size: cpal_buffer_size,
            device,
            sample_rate,
            stream_config: cpal::StreamConfig {
                channels,
                sample_rate: sample_rate,
                buffer_size: cpal_buffer_size,
            },
            control_tx: Mutex::new(None),
        })
    }

    pub fn start_stream(&self, sink: StreamSink<Vec<f32>>) -> Result<()> {
        let rx = self.start();

        while let Ok(audio) = rx.recv() {
            match sink.add(audio) {
                Ok(_) => {}
                Err(_) => {
                    break;
                }
            }
        }

        Ok(())
    }

    pub fn start_stream_waveform(
        &self,
        buffer_size: usize,
        samples_per_pixel: usize,
        sink: StreamSink<Vec<f32>>,
    ) -> Result<()> {
        let rx = self.start();

        let mut ring = VecDeque::with_capacity(buffer_size);

        while let Ok(audio) = rx.recv() {
            ring.extend(downsample_minmax(&audio, samples_per_pixel));

            // Drain any extra chunks to avoid latency buildup
            while let Ok(extra) = rx.try_recv() {
                ring.extend(&extra);
            }

            if ring.len() > buffer_size {
                ring.drain(..ring.len() - buffer_size);
            }

            if sink.add(ring.make_contiguous().to_vec()).is_err() {
                break;
            }
        }

        Ok(())
    }

    #[frb(ignore)]
    pub fn start(&self) -> Receiver<Vec<f32>> {
        let (audio_tx, audio_rx) = channel::<Vec<f32>>();
        let (stream_tx, stream_rx) = channel::<StreamCommand>();

        let device = self.device.clone();
        let config = self.stream_config.clone();

        //--------------

        std::thread::spawn(move || {
            fn run_stream(
                device: cpal::Device,
                config: StreamConfig,
                stream_rx: Receiver<StreamCommand>,
                audio_tx: Sender<Vec<f32>>,
            ) -> Result<()> {
                let channels = config.channels as usize;

                let stream = device.build_input_stream(
                    &config,
                    move |data: &[f32], _| {
                        let audio = if channels == 1 {
                            data.to_vec()
                        } else {
                            downmix_to_mono(data, channels)
                        };

                        if audio_tx.send(audio).is_err() {
                            return;
                        }
                    },
                    |err| {},
                    None,
                )?;

                stream.play()?;

                while let Ok(cmd) = stream_rx.recv() {
                    match cmd {
                        StreamCommand::Stop => {
                            drop(stream);
                            break;
                        }
                    }
                }
                Ok(())
            }

            if let Err(err) = run_stream(device, config, stream_rx, audio_tx) {}
        });

        *self.control_tx.lock().unwrap() = Some(stream_tx);
        audio_rx
    }

    pub fn stop(&self) -> Result<()> {
        if let Some(tx) = self.control_tx.lock().unwrap().take() {
            match tx.send(StreamCommand::Stop) {
                Ok(_) => {}
                Err(e) => {}
            }
        } else {
        }
        Ok(())
    }
}
