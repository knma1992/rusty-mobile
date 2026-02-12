package de.knma.rustydroid


object JniManager {

    const val LIB_NAME = "jni_bridge"

    @Suppress("FunctionName")
    external fun jni_add(left: Int, right: Int): Int
}