```rust
#[unsafe(no_mangle)]
pub extern "system" fn Java_de_knma_rustydroid_JniManager_jniAdd(
    _env: JNIEnv, _jclass: JClass, left: jint, right: jint,
) -> jint {
    left + right
}    
```
