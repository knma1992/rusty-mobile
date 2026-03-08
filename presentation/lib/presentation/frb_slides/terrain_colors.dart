import 'package:iron_bird_call/iron_bird_call.dart' as rust_api;

final terrainColors = rust_api.TerrainColors(
  thresholds: [
    rust_api.TerrainThreshold(
      threshold: -0.3,
      r: 30,
      g: 60,
      b: 120,
    ), // deep water
    rust_api.TerrainThreshold(
      threshold: -0.1,
      r: 50,
      g: 100,
      b: 180,
    ), // shallow water
    rust_api.TerrainThreshold(threshold: 0.0, r: 210, g: 200, b: 150), // sand
    rust_api.TerrainThreshold(
      threshold: 0.15,
      r: 34,
      g: 85,
      b: 34,
    ), // dark green
    rust_api.TerrainThreshold(threshold: 0.3, r: 50, g: 150, b: 50), // grass
    rust_api.TerrainThreshold(
      threshold: 0.45,
      r: 30,
      g: 30,
      b: 20,
    ), // dark spots
    rust_api.TerrainThreshold(threshold: 0.6, r: 100, g: 100, b: 80), // rock
  ],
  fallback: (240, 240, 250),
);
