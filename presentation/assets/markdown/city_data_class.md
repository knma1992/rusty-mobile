```kotlin
data class City(
    val name: String,
    val population: Int,
    val area: Float,
    @get:JvmName("is_capital") val isCapital: Boolean,
    @get:JvmName("district_populations") val districtPopulations: IntArray,
    @get:JvmName("district_areas") val districtAreas: FloatArray
) {

    companion object {
        @JvmStatic
        @Suppress("FunctionName")
        external fun get_karlsruhe(): City
    }
}
```
