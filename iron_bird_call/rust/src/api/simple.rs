use flutter_rust_bridge::frb;

#[frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[frb(unignore)]
pub enum WorldEvent {
    /// A new terrain chunk was generated
    TerrainGenerated {
        x: i32,
        y: i32,
        width: u32,
        height: u32,
        seed: u64,
    },

    /// A weather system changed
    WeatherChanged {
        temperature: f32,
        humidity: f32,
        wind_speed: f32,
        description: String,
    },

    /// The player moved to a new region
    RegionEntered {
        region_name: String,
        population: u32,
        hostile: bool,
    },
}
