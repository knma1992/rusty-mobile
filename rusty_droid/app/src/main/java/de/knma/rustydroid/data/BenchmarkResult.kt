package de.knma.rustydroid.data

import java.text.DecimalFormat

data class BenchmarkResult(
    val name: String,
    val mean: Long,
    val min: Long,
    val max: Long,
)

fun List<Long>.toBenchmarkResult(name: String): BenchmarkResult {

    return BenchmarkResult(
        name = name,
        mean = this.mean(),
        min = this.min(),
        max = this.max(),
    )
}

fun List<Long>.mean(): Long {
    if (this.isEmpty()) return 0
    return this.sum() / this.size
}
fun List<Long>.min(): Long {
    return this.minOrNull() ?: 0
}
fun List<Long>.max(): Long {
    return this.maxOrNull() ?: 0
}

fun Number.format(): String {
    val formatter = DecimalFormat("#,###")
    return formatter.format(this)
}