```toml
[package]
name = "uniffi_bridge"
version = "0.1.0"
edition = "2024"

[lib]
name = "uniffi_bridge"
crate-type = ["cdylib"]

[dependencies]
uniffi = { version = "0.31.0", features = [ "cli" ]  }

[build-dependencies]
uniffi = { version = "0.31.0", features = [ "build" ] }

[[bin]]
name = "uniffi-bindgen"
path = "uniffi-bindgen.rs"
```
