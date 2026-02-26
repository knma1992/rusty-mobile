use jni::{JNIEnv, objects::JString, sys::jstring};

pub fn jstring_to_rust_string(env: &mut JNIEnv, jstring: &JString) -> String {
    env.get_string(jstring)
        .expect("Couldn't convert JString to Rust String.")
        .into()
}

pub fn rust_string_to_jstring(env: &mut JNIEnv, rust_string: &str) -> jstring {
    env.new_string(rust_string)
        .expect("Couldn't create Java String.")
        .into_raw()
}
