package de.knma.rustydroid.presentation

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.safeDrawing
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import de.knma.rustydroid.presentation.additional.BenchmarkDisplay
import de.knma.rustydroid.presentation.additional.EnumDropdownMenu

@Composable
fun MainScreen() {

    val viewModel: MainScreenViewModel = viewModel()

    val benchmarkResults by viewModel.benchmarkResults.collectAsState()

    val method by viewModel.method.collectAsState()

    val scrollState = rememberScrollState()

    Scaffold(
        contentWindowInsets = WindowInsets.safeDrawing,
        modifier = Modifier.fillMaxSize(),
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(start = 16.dp, top = 0.dp, end = 16.dp, bottom = 16.dp)
                .verticalScroll(scrollState),
            verticalArrangement = Arrangement.Top,
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {

            Text(
                modifier = Modifier.padding(10.dp),
                text = "Rusty Droid",
                style = MaterialTheme.typography.titleLarge
            )

            Text(
                modifier = Modifier.padding(10.dp),
                text = "Choose a function using the dropdown menu and see which implementation is the fastest."
            )

            EnumDropdownMenu(viewModel.methods, method, viewModel::setMethod)

            BenchmarkDisplay(
                viewModel::benchmark,
                viewModel.limitTextFieldState,
                viewModel.iterationsTextFieldState,
                benchmarkResults,
                method
            )

        }

    }


}


