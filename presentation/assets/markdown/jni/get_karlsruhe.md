```rust
#[jni_fn("de.knma.rustydroid.data.City")] // fully qualified class name Kotlin data class
pub fn get_karlsruhe(mut env: JNIEnv, class: JClass) -> jobject {
    //...
    env.new_object( // ask the JVM to construct an object
        &class,     // of this class
        "(Ljava/lang/String;IFZ[I[F)V", // constructor signature in JVM bytecode notation
        &[
            // data wrapped in JValue so all values fit in the same array
            JValue::Object(&jni_name),
            JValue::Int(karlsruhe.population),
            JValue::Float(karlsruhe.area),
            JValue::Bool(jboolean::from(karlsruhe.is_capital)),
            JValue::from(&jni_populations),
            JValue::from(&jni_district_areas),
        ],
    )
    .expect("Failed to create Karlruhe")
    .into_raw() // unwrap safe JObject wrapper into a raw jobject
}
```
