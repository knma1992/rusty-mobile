```rust
#[jni_fn("de.knma.rustydroid.JniManager")]
pub fn jni_add(
    _env: JNIEnv, _: JClass, left: jint, right: jint
) -> jint {
    left + right
}
```
