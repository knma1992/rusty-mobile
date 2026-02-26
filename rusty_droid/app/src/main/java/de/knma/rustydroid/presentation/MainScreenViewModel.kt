package de.knma.rustydroid.presentation

import android.util.Log
import androidx.compose.foundation.text.input.TextFieldState
import androidx.lifecycle.ViewModel
import de.knma.rustydroid.JniManager
import de.knma.rustydroid.data.BenchmarkResult
import de.knma.rustydroid.data.Method
import de.knma.rustydroid.data.toBenchmarkResult
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import uniffi.uniffi_bridge.uniffiAdd


class MainScreenViewModel : ViewModel() {

    val methods: Array<Method> = Method.entries.toTypedArray()
    private val _method = MutableStateFlow(methods.first())
    val method: StateFlow<Method> = _method.asStateFlow()

    fun setMethod(newMethod: Method) {
        _method.value = newMethod
    }

    private val _benchmarkResults = MutableStateFlow(listOf<BenchmarkResult>())
    val benchmarkResults: StateFlow<List<BenchmarkResult>> = _benchmarkResults.asStateFlow()

    val limitTextFieldState = TextFieldState("10")
    val iterationsTextFieldState = TextFieldState("20")


    fun benchmark() {

        val iterations = iterationsTextFieldState.text.toString().toIntOrNull() ?: run {
            Log.d("MainScreenViewModel", "Iterations field was empty")
            return
        }

        val tempBenchmarkResults = mutableListOf<BenchmarkResult>()

        when (method.value) {
            Method.ADD -> {

                tempBenchmarkResults.addAll(
                    testAllImplementations(
                        functions = listOf(
                            TestObject("uniffi") {
                                uniffiAdd(it, it)
                            },
                            TestObject("kotlin") {
                                it + it
                            },
                            TestObject("jni") {
                                JniManager.jni_add(it, it)
                            }
                        ), input = 1, iterations = iterations
                    )
                )

            }
            Method.SUB -> {

                val a = JniManager.jniSub(1, 1)

            }

            else -> {


            }
        }

        _benchmarkResults.value = tempBenchmarkResults

    }

    fun <T> testAllImplementations(
        functions: List<TestObject<T>>, input: T, iterations: Int
    ): List<BenchmarkResult> {

        val metricDataList = mutableListOf<BenchmarkResult>()

        functions.forEach {
            metricDataList.add(
                testMultiple(it.function, input, iterations).toBenchmarkResult(it.name)
            )

        }


        return metricDataList
    }

    fun <T, G> testMultiple(temp: (T) -> G, input: T, iterations: Int): List<Long> {

        val timings = mutableListOf<Long>()

        val ignore = temp(input) // warm up

        repeat(iterations) {
            timings.add(testSingle(temp, input))
        }

        return timings
    }

    fun <T, G> testSingle(temp: (T) -> G, input: T): Long {
        val tic = System.nanoTime()
        val ignore = temp(input)
        val toc = System.nanoTime()
        return toc - tic
    }

}

class TestObject<T>(
    val name: String, val function: (T) -> Any
)