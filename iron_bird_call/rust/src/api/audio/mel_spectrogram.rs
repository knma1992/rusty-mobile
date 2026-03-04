use std::sync::mpsc::Receiver;

use anyhow::Result;
use non_empty_slice::NonEmptyVec;

use flutter_rust_bridge::frb;
use spectrograms::{
    nzu, Decibels, LogParams, MelParams, SpectrogramParams, SpectrogramPlanner, StftParams,
    WindowType,
};

use crate::{
    api::{audio::rust_audio_recorder::RustAudioRecorder, simple::Size},
    frb_generated::StreamSink,
};

#[frb(opaque)]
pub struct InferencePipeline {
    rust_audio_recorder: RustAudioRecorder,
    pub image_size: Size,
}

impl InferencePipeline {
    pub fn new(image_size: Size) -> Result<Self> {
        Ok(InferencePipeline {
            rust_audio_recorder: RustAudioRecorder::new()?,
            image_size,
        })
    }

    pub fn start(&mut self, sink: StreamSink<Vec<u8>>) -> Result<()> {
        let width = self.image_size.width as usize;
        let height = self.image_size.height as usize;

        let sample_rate = self.rust_audio_recorder.sample_rate as f64;

        let rx = self.rust_audio_recorder.start();

        std::thread::spawn(move || {
            fn run_stream(
                rx: Receiver<Vec<f32>>,
                sample_rate: f64,
                width: usize,
                height: usize,
                sink: StreamSink<Vec<u8>>,
            ) -> Result<()> {
                let stft = StftParams::new(
                    nzu!(2048), // FFT size
                    nzu!(512),  // hop size
                    WindowType::Hanning,
                    true, // centre frames
                )?;
                let params = SpectrogramParams::new(stft, sample_rate)?;

                let mel = MelParams::new(
                    nzu!(128),         // mel bins → maps nicely to pixel height
                    0.0,               // f_min
                    sample_rate / 2.0, // f_max
                )?;

                let db = LogParams::new(-80.0)?;

                let planner = SpectrogramPlanner::new();
                let mut plan = planner.mel_plan::<Decibels>(&params, &mel, Some(&db))?;

                while let Ok(audio) = rx.recv() {
                    let samples_f64: Vec<f64> = audio.iter().map(|&s| s as f64).collect();
                    let samples = NonEmptyVec::new(samples_f64).unwrap();
                    let spec = plan.compute(&samples)?;

                    let data = spec.data(); // Array2<f64>, shape [n_bins, n_frames]
                    let (n_bins, n_frames) = data.dim();

                    // RGBA pixels: rows = freq bins (low freq at bottom), cols = time frames
                    let pixels: Vec<u8> = (0..n_bins)
                        .rev()
                        .flat_map(|bin| {
                            (0..n_frames).flat_map(move |frame| db_to_rgba(data[[bin, frame]]))
                        })
                        .collect();

                    sink.add(pixels);
                }

                Ok(())
            }

            if let Err(err) = run_stream(rx, sample_rate, width, height, sink) {}
        });

        Ok(())
    }

    pub fn stop(&mut self) -> Result<()> {
        self.rust_audio_recorder.stop()?;

        Ok(())
    }
}

/// Maps a dB value in [-80, 0] to an RGBA pixel using a "hot" colormap:
/// black → red → yellow → white
fn db_to_rgba(db: f64) -> [u8; 4] {
    let t = ((db + 80.0) / 80.0).clamp(0.0, 1.0) as f32;
    let r = (t * 3.0).clamp(0.0, 1.0);
    let g = (t * 3.0 - 1.0).clamp(0.0, 1.0);
    let b = (t * 3.0 - 2.0).clamp(0.0, 1.0);
    [(r * 255.0) as u8, (g * 255.0) as u8, (b * 255.0) as u8, 255]
}
