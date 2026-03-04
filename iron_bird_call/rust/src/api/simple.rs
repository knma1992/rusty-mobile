use anyhow::Result;
use noise::{Fbm, MultiFractal, NoiseFn, SuperSimplex};
use rayon::iter::{IntoParallelIterator, ParallelIterator};
use std::time::{Duration, Instant};

use crate::frb_generated::StreamSink;

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

pub fn terrain_stream(image_size: Size, sink: StreamSink<Vec<u8>>) -> Result<()> {
    let width = image_size.width as usize;
    let height = image_size.height as usize;

    let fbm = Fbm::<SuperSimplex>::new(0)
        .set_octaves(6)
        .set_frequency(1.5);

    let mut offset_z: f64 = 0.0;
    let target_frame_time = Duration::from_millis(16);

    loop {
        let frame_start = Instant::now();
        offset_z += 0.01; // Animate by sliding through 3rd dimension

        let pixels: Vec<u8> = (0..height)
            .into_par_iter()
            .flat_map(|y| {
                let mut row = Vec::with_capacity(width * 4);
                for x in 0..width {
                    let nx = x as f64 / width as f64 * 4.0;
                    let ny = y as f64 / height as f64 * 4.0;
                    let val = fbm.get([nx, ny, offset_z]); // -1..1
                    let (r, g, b) = terrain_color(val);
                    row.extend_from_slice(&[r, g, b, 255]);
                }
                row
            })
            .collect();

        if sink.add(pixels).is_err() {
            break;
        }

        let elapsed = frame_start.elapsed();
        if elapsed < target_frame_time {
            std::thread::sleep(target_frame_time - elapsed);
        }
    }
    Ok(())
}

fn terrain_color(v: f64) -> (u8, u8, u8) {
    match v {
        v if v < -0.3 => (30, 60, 120),  // deep water
        v if v < -0.1 => (50, 100, 180), // shallow water
        v if v < 0.0 => (210, 200, 150), // sand
        v if v < 0.3 => (50, 150, 50),   // grass
        v if v < 0.6 => (100, 100, 80),  // rock
        _ => (240, 240, 250),            // snow
    }
}

#[derive(Debug, Clone)]
pub struct Size {
    pub width: i32,
    pub height: i32,
}

#[derive(Debug, Clone)]
pub struct Point {
    pub x: f64,
    pub y: f64,
}
