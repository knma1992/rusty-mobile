use jni::JNIEnv;
use jni::objects::{JClass, JObject, JString, JValue};
use jni::sys::{jboolean, jint, jobject, jstring};

use jni_fn::jni_fn;

use crate::city::City;
use crate::jni_utils::{jstring_to_rust_string, rust_string_to_jstring};

pub mod city;
pub mod jni_utils;

// "system" tells Rust to use the system calling convention according to its ABI, so in this case use the android arm64 calling conventions
#[unsafe(no_mangle)] //Stop the compiler from renaming this function
pub extern "system" fn Java_de_knma_rustydroid_JniManager_jniSub(
    _env: JNIEnv,   // Pointer/reference to the JVM, used to call Kotlin from Rust
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

#[jni_fn("de.knma.rustydroid.data.City")]
pub fn get_karlsruhe(mut env: JNIEnv, class: JClass) -> jobject {
    let karlsruhe = City {
        name: String::from("Karlsruhe"),
        population: 308436,
        area: 173.46,
        is_capital: false,
        district_populations: vec![21000, 18500, 15200, 32000, 28700, 19800, 24500, 17300],
        district_areas: vec![12.3, 8.7, 15.1, 22.4, 18.9, 11.2, 9.8, 14.6],
    };

    let jni_name = env.new_string(&karlsruhe.name).unwrap();

    let jni_populations = env
        .new_int_array(karlsruhe.district_populations.len() as i32)
        .unwrap();

    env.set_int_array_region(&jni_populations, 0, &karlsruhe.district_populations)
        .unwrap();

    let jni_district_areas = env
        .new_float_array(karlsruhe.district_areas.len() as i32)
        .unwrap();

    env.set_float_array_region(&jni_district_areas, 0, &karlsruhe.district_areas)
        .unwrap();

    env.new_object(
        &class,
        "(Ljava/lang/String;IFZ[I[F)V",
        &[
            JValue::Object(&jni_name),
            JValue::Int(karlsruhe.population),
            JValue::Float(karlsruhe.area),
            JValue::Bool(jboolean::from(karlsruhe.is_capital)),
            JValue::from(&jni_populations),
            JValue::from(&jni_district_areas),
        ],
    )
    .expect("Failed to create User object")
    .into_raw()
}
