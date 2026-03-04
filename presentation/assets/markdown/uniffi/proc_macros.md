```rust
uniffi::setup_scaffolding!();

#[uniffi::export]
pub fn uniffi_add(left: i32, right: i32) -> i32 {
    left + right
}
```
