```bash
cargo ndk -t arm64-v8a \
  -o app/src/main/jniLibs \
  build --lib --release

cargo run --bin uniffi-bindgen generate \
  --library target/.../libuniffi_bridge.so \
  --language kotlin \
  --out-dir app/src/main/java/
```
