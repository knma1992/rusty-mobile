```kotlin
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        System.loadLibrary(JniManager.LIB_NAME)

        enableEdgeToEdge()
        setContent {
            RustyDroidTheme {
                MainScreen()
            }
        }
    }
}
```

```kotlin
object JniManager {

    const val LIB_NAME = "jni_bridge"

    @Suppress("FunctionName")
    external fun jni_add(left: Int, right: Int): Int    
}
```
