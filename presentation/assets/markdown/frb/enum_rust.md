```rust
pub enum WorldEvent {
    TerrainGenerated {
        x: i32,
        y: i32,
        width: u32,
        height: u32,
        seed: u64,
    },

    WeatherChanged {
        temperature: f32,
        humidity: f32,
        wind_speed: f32,
        description: String,
    },

    RegionEntered {
        region_name: String,
        population: u32,
        hostile: bool,
    },
}
```
