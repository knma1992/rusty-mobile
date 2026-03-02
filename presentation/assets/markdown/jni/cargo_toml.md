```toml
[package]
name = "jni_bridge"
version = "0.1.0"
edition = "2024"

[package.metadata]
cargo-ndk = { targets = ["i686-linux-android", "aarch64-linux-android"]}

[lib]
crate-type = ["cdylib"]

[dependencies]
```
