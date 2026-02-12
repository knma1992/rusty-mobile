use jni::JNIEnv;
use jni::objects::JClass;
use jni::sys::jint;

use jni_fn::jni_fn;

#[jni_fn("de.knma.rustydroid.JniManager")]
pub fn jni_add(_env: JNIEnv, _: JClass, left: jint, right: jint) -> jint {
    left + right
}
