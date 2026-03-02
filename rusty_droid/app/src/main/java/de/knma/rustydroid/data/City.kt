package de.knma.rustydroid.data

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

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as City

        if (population != other.population) return false
        if (area != other.area) return false
        if (isCapital != other.isCapital) return false
        if (name != other.name) return false
        if (!districtPopulations.contentEquals(other.districtPopulations)) return false
        if (!districtAreas.contentEquals(other.districtAreas)) return false

        return true
    }

    override fun hashCode(): Int {
        var result = population
        result = 31 * result + area.hashCode()
        result = 31 * result + isCapital.hashCode()
        result = 31 * result + name.hashCode()
        result = 31 * result + districtPopulations.contentHashCode()
        result = 31 * result + districtAreas.contentHashCode()
        return result
    }
}