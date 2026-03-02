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
