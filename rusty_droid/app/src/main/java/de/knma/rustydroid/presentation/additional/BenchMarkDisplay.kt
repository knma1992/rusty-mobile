package de.knma.rustydroid.presentation.additional

import android.util.Log
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.sizeIn
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.text.input.InputTransformation
import androidx.compose.foundation.text.input.OutputTransformation
import androidx.compose.foundation.text.input.TextFieldLineLimits
import androidx.compose.foundation.text.input.TextFieldState
import androidx.compose.foundation.text.input.maxLength
import androidx.compose.foundation.text.input.then
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.core.text.isDigitsOnly
import de.knma.rustydroid.data.BenchmarkResult
import de.knma.rustydroid.data.Method
import de.knma.rustydroid.data.format
import kotlin.collections.forEach

@Composable
fun BenchmarkDisplay(
    benchmark: () -> Unit,
    limitTextFieldState: TextFieldState,
    iterationsTextFieldState: TextFieldState,
    metricData: List<BenchmarkResult>,
    method: Method
) {

    Card(
        modifier = Modifier
            .padding(horizontal = 4.dp)
            .sizeIn(
                minHeight = 300.dp,
            )
    ) {

        Column(
            verticalArrangement = Arrangement.SpaceEvenly,
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {

            Row(
                Modifier.padding(10.dp),
                horizontalArrangement = Arrangement.Center,
                verticalAlignment = Alignment.Top
            ) {

                if (method != Method.REVERSE_STRING) {

                    OutlinedTextField(
                        state = limitTextFieldState,
                        modifier = Modifier.weight(1f),
                        lineLimits = TextFieldLineLimits.SingleLine,
                        keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Number),
                        inputTransformation = InputTransformation.maxLength(10).then {
                            if (!asCharSequence().isDigitsOnly()) {
                                revertAllChanges()
                            }
                            Log.d("MainScreenViewModel", "input: ${limitTextFieldState.text}")
                        },
                        outputTransformation = OutputTransformation {
                            Log.d("MainScreenViewModel", "output: ${limitTextFieldState.text}")
                        },
                        label = { Text("Fibonacci Limit") })


                    Spacer(modifier = Modifier.weight(0.1f))
                }

                OutlinedTextField(
                    state = iterationsTextFieldState,
                    modifier = Modifier.weight(1f),
                    lineLimits = TextFieldLineLimits.SingleLine,
                    keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Number),
                    inputTransformation = InputTransformation.maxLength(10).then {
                        if (!asCharSequence().isDigitsOnly()) {
                            revertAllChanges()
                        }
                        Log.d("MainScreenViewModel", "input: ${iterationsTextFieldState.text}")
                    },
                    outputTransformation = OutputTransformation {
                        Log.d("MainScreenViewModel", "output: ${iterationsTextFieldState.text}")
                    },
                    label = { Text("Iterations") })
            }


            Button(onClick = {
                Log.i("MainScreen", "Clicked On Button")
                benchmark()
            }) {
                Text("Benchmark")
            }

            metricData.forEach {
                BenchmarkCard(it)
            }


        }


    }
}

@Composable
fun BenchmarkCard(data: BenchmarkResult) {

    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 8.dp),
        elevation = CardDefaults.cardElevation(0.dp)
    ) {
        Column(
            modifier = Modifier
                .padding(16.dp)
                .fillMaxWidth()
        ) {
            Text(
                text = data.name,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(bottom = 8.dp)
            )

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {

                BenchmarkItem(
                    label = "Mean", value = data.mean.format(), unit = "ns"
                )

                Spacer(Modifier.width(16.dp))

                BenchmarkItem(
                    label = "Min", value = data.min.format(), unit = "ns"
                )

                Spacer(Modifier.width(16.dp))

                BenchmarkItem(
                    label = "Max", value = data.max.format(), unit = "ns"
                )
            }
        }
    }
}

@Composable
private fun RowScope.BenchmarkItem(
    label: String, value: String, unit: String
) {
    Column(
        modifier = Modifier.weight(1f), horizontalAlignment = Alignment.Start
    ) {

        Text(
            text = label,
            style = MaterialTheme.typography.labelSmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant.copy(alpha = 0.7f)
        )

        val annotatedString = buildAnnotatedString {
            append(value)
            withStyle(style = MaterialTheme.typography.bodyLarge.toSpanStyle()) {
                append(" $unit")
            }
        }

        Text(
            text = annotatedString,
            style = MaterialTheme.typography.bodyLarge,
            fontWeight = FontWeight.SemiBold
        )
    }
}