use anyhow::{Context, Result};
use flutter_rust_bridge::frb;

use cpal::traits::DeviceTrait;

#[derive(Clone)]
#[frb(json_serializable, dart_metadata=("freezed", "immutable"))]
pub struct AudioConfig {
    pub device_name: String,
    pub channels: u16,
    pub sample_rate: u32,
    pub buffer_size: Option<u32>,
}

#[flutter_rust_bridge::frb(ignore)]
pub fn downmix_to_mono(input: &[f32], channels: usize) -> Vec<f32> {
    input
        .chunks_exact(channels)
        .map(|frame| frame.iter().sum::<f32>() / channels as f32)
        .collect()
}

/// Checks if 16kHz is available for f32 encoding on the device.
/// If available, returns 16000. Otherwise, returns the next best in order of preference.
/// Preference order: 16kHz → 32kHz → 48kHz → 24kHz → 44.1kHz  → 22.05kHz → 8kHz
#[flutter_rust_bridge::frb(ignore)]
pub fn get_best_sample_rate(device: &cpal::Device) -> Result<u32> {
    const PREFERRED_RATES: &[u32] = &[16000, 32000, 24000, 48000, 44100, 22050, 8000];
    let configs: Vec<_> = device.supported_input_configs()?.collect();
    for &rate in PREFERRED_RATES {
        for config in &configs {
            if config.sample_format() == cpal::SampleFormat::F32 {
                let min = config.min_sample_rate();
                let max = config.max_sample_rate();
                if rate >= min && rate <= max {
                    return Ok(rate);
                }
            }
        }
    }
    Err(anyhow::anyhow!("No suitable sample rate found"))
}

/// Selects the best buffer size for the device, targeting 100ms of audio.
/// Falls back to the closest supported size if 100ms is not available.
#[flutter_rust_bridge::frb(ignore)]
pub fn get_best_buffer_size(device: &cpal::Device, sample_rate: u32) -> Result<(Option<u32>, u16)> {
    // Target 100ms buffer: sample_rate * 0.1
    let target_buffer_size = (sample_rate as f32 * 0.1) as u32;

    // Get the supported buffer size range for this device
    let supported_configs = device
        .supported_input_configs()
        .context("Failed to query supported input configs")?;

    let mut min_buffer = u32::MAX;
    let mut max_buffer = 0u32;
    let mut channel_configuration: Vec<u16> = Vec::new();

    let mut found_range = false;

    for config in supported_configs {
        if config.sample_format() != cpal::SampleFormat::F32 {
            continue;
        }

        // Check if this config supports our sample rate
        if sample_rate >= config.min_sample_rate() && sample_rate <= config.max_sample_rate() {
            channel_configuration.push(config.channels());
            // Update min/max based on buffer size info
            match config.buffer_size() {
                cpal::SupportedBufferSize::Range { min, max } => {
                    min_buffer = min_buffer.min(*min);
                    max_buffer = max_buffer.max(*max);
                    found_range = true;
                }
                cpal::SupportedBufferSize::Unknown => {}
            }
        }
    }

    if !found_range && !channel_configuration.is_empty() {
        // Only F32 configs with Unknown buffer size exist — use target directly
        min_buffer = target_buffer_size;
        max_buffer = target_buffer_size;
    }

    let channel = channel_configuration
        .iter()
        .min()
        .expect("No channels found");

    if min_buffer == u32::MAX || max_buffer == 0 {
        // No buffer size info found, use a safe default
        return Ok((None, *channel));
    }

    // Clamp target to supported range
    let buffer_size = target_buffer_size.clamp(min_buffer, max_buffer);

    Ok((Some(buffer_size), *channel))
}

#[frb(json_serializable, dart_metadata=("freezed", "immutable"))]
pub struct StreamConfigInfo {
    pub device_name: String,
    pub channels: u16,
    pub min_sample_rate: u32,
    pub max_sample_rate: u32,
    pub sample_format: String,
    pub supported_buffer_size: Option<SupportedBufferSize>,
}

#[frb(json_serializable, dart_metadata=("freezed", "immutable"))]
pub struct SupportedBufferSize {
    pub min: u32,
    pub max: u32,
}

#[flutter_rust_bridge::frb(ignore)]
pub fn downsample_minmax(samples: &[f32], chunk_size: usize) -> Vec<f32> {
    samples
        .chunks_exact(chunk_size)
        .flat_map(|chunk| {
            let mut min = chunk[0];
            let mut max = chunk[0];
            for &s in &chunk[1..] {
                if s < min {
                    min = s;
                }
                if s > max {
                    max = s;
                }
            }
            [min, max]
        })
        .collect()
}
