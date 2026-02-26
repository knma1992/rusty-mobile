use jni::JNIEnv;
use jni::objects::{JClass, JString};
use jni::sys::{jint, jstring};

use jni_fn::jni_fn;

use crate::jni_utils::{jstring_to_rust_string, rust_string_to_jstring};

pub mod jni_utils;

// "system" tells Rust to use the system calling convention according to its ABI, so in this case use the android arm64 calling conventions
#[unsafe(no_mangle)] //Stop the compiler from renaming this function
pub extern "system" fn Java_de_knma_rustydroid_JniManager_jniSub(
    _env: JNIEnv,   // Pointer to the JVM, used to call Kotlin from Rust
    _class: JClass, // Pointer to the method instance it is linked to
    left: jint,
    right: jint,
) -> jint {
    left - right
}

#[jni_fn("de.knma.rustydroid.JniManager")]
pub fn jni_add(_env: JNIEnv, _: JClass, left: jint, right: jint) -> jint {
    left + right
}

#[jni_fn("de.knma.rustydroid.JniManager")]
pub fn string_function(mut env: JNIEnv, _: JClass, input_string: JString) -> jint {
    let _s: String = env.get_string(&input_string).unwrap().into();
    1
}

#[jni_fn("de.knma.rustydroid.JniManager")]
pub fn reverse_string(mut env: JNIEnv, _: JClass, input_string: JString) -> jstring {
    let rust_string: String = jstring_to_rust_string(&mut env, &input_string);

    let reversed_string: String = rust_string.chars().rev().collect();

    rust_string_to_jstring(&mut env, &reversed_string)
}
