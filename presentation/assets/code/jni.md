```rust
#[no_mangle]
pub extern "system" fn Java_de_knma_rustydroid_JniManager_jniAdd(
    _env: JNIEnv, _: JClass, left: jint, right: jint,
) -> jint {
    left + right
}    
```


```rust
#[jni_fn("de.knma.rustydroid.JniManager")]
pub fn jni_add(
    _env: JNIEnv, _: JClass, left: jint, right: jint
) -> jint {
    left + right
}
```
