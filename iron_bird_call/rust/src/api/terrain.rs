use anyhow::Result;
use flutter_rust_bridge::frb;
use noise::{Fbm, MultiFractal, NoiseFn, SuperSimplex};
use rayon::iter::{IntoParallelIterator, ParallelIterator};
use std::time::{Duration, Instant};

use crate::frb_generated::StreamSink;

#[frb]
pub struct TerrainThreshold {
    pub threshold: f64,
    pub r: u8,
    pub g: u8,
    pub b: u8,
}

#[frb]
pub struct TerrainColors {
    pub thresholds: Vec<TerrainThreshold>, // sorted low→high
    pub fallback: (u8, u8, u8),            // color above all thresholds
}

impl TerrainColors {
    pub fn default() -> Self {
        Self {
            thresholds: vec![
                TerrainThreshold {
                    threshold: -0.3,
                    r: 30,
                    g: 60,
                    b: 120,
                }, // deep water
                TerrainThreshold {
                    threshold: -0.1,
                    r: 50,
                    g: 100,
                    b: 180,
                }, // shallow water
                TerrainThreshold {
                    threshold: 0.0,
                    r: 210,
                    g: 200,
                    b: 150,
                }, // sand
                TerrainThreshold {
                    threshold: 0.3,
                    r: 50,
                    g: 150,
                    b: 50,
                }, // grass
                TerrainThreshold {
                    threshold: 0.6,
                    r: 100,
                    g: 100,
                    b: 80,
                }, // rock
            ],
            fallback: (240, 240, 250), // snow
        }
    }
}

#[derive(Debug, Clone)]
pub struct Size {
    pub width: i32,
    pub height: i32,
}

pub fn terrain_stream(
    image_size: Size,
    colors: TerrainColors,
    sink: StreamSink<Vec<u8>>,
) -> Result<()> {
    let width = image_size.width as usize;
    let height = image_size.height as usize;

    let fbm = Fbm::<SuperSimplex>::new(0)
        .set_octaves(6)
        .set_frequency(1.5);

    let mut offset_z: f64 = 0.0;
    let target_frame_time = Duration::from_millis(16);

    loop {
        let frame_start = Instant::now();
        offset_z += 0.01;

        let pixels: Vec<u8> = (0..height)
            .into_par_iter()
            .flat_map(|y| {
                let mut row = Vec::with_capacity(width * 4);
                for x in 0..width {
                    let nx = x as f64 / width as f64 * 4.0;
                    let ny = y as f64 / height as f64 * 4.0;
                    let val = fbm.get([nx, ny, offset_z]); // -1..1
                    let (r, g, b) = terrain_color(val, &colors);
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

fn terrain_color(v: f64, colors: &TerrainColors) -> (u8, u8, u8) {
    for t in &colors.thresholds {
        if v < t.threshold {
            return (t.r, t.g, t.b);
        }
    }
    colors.fallback
}
