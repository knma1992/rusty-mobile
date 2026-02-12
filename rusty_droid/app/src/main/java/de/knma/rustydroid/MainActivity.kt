package de.knma.rustydroid

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import de.knma.rustydroid.presentation.MainScreen
import de.knma.rustydroid.ui.theme.RustyDroidTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        try {
            System.loadLibrary(JniManager.LIB_NAME)
        } catch (e: UnsatisfiedLinkError) {
            Log.e("MainActivity", "Cant find ${JniManager.LIB_NAME} jni lib")
        }

        enableEdgeToEdge()
        setContent {
            RustyDroidTheme {
                MainScreen()
            }
        }
    }
}