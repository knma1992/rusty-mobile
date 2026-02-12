package de.knma.rustydroid

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import de.knma.rustydroid.presentation.MainScreen
import de.knma.rustydroid.ui.theme.RustyDroidTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            RustyDroidTheme {
                MainScreen()
            }
        }
    }
}