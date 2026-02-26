```rust
#[jni_fn("de.knma.rustydroid.JniManager")]
pub fn string_function(mut env: JNIEnv, _: JClass, input_string: JString) -> jint {
    let _s: String = env.get_string(&input_string).unwrap().into();
    1
}
```
    
    0011a324 e1 0f 40 f9     ldr        x1,[sp, #local_88[0]]
    0011a328 81 00 00 b4     cbz        x1,LAB_0011a338
    0011a32c e0 13 40 f9     ldr        x0,[sp, #local_88[8]]
    0011a330 22 00 80 52     mov        w2,#0x1
    0011a334 5e 03 00 94     bl         <EXTERNAL>::free                                 void free(void * __ptr)
                          LAB_0011a338                                    XREF[1]:     0011a328(j)  
    0011a338 20 00 80 52     mov        w0,#0x1
    0011a33c fd 7b 49 a9     ldp        x29=>local_10,x30,[sp, #0x90]
    0011a340 ff 83 02 91     add        sp,sp,#0xa0
    0011a344 c0 03 5f d6     ret
