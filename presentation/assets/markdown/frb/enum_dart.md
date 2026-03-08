```dart
@freezed
sealed class WorldEvent with _$WorldEvent {
  const WorldEvent._();

  const factory WorldEvent.terrainGenerated({
    required int x,
    required int y,
    required int width,
    required int height,
    required BigInt seed,
  }) = WorldEvent_TerrainGenerated;

  const factory WorldEvent.weatherChanged({
    required double temperature,
    required double humidity,
    required double windSpeed,
    required String description,
  }) = WorldEvent_WeatherChanged;

  const factory WorldEvent.regionEntered({
    required String regionName,
    required int population,
    required bool hostile,
  }) = WorldEvent_RegionEntered;
}
```
