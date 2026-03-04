import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'frb_data.freezed.dart';

enum ServiceState {
  terrain,
  audio,
  idle,
  loading;

  bool get terrainRunning => this == ServiceState.terrain;
  bool get audioRunnning => this == ServiceState.audio;
  bool get isLoading => this == ServiceState.loading;
  bool get isIdle => this == ServiceState.idle;
}

@freezed
abstract class FrbData with _$FrbData {
  const factory FrbData({
    required ui.Image? image,
    required ServiceState serviceState,
    required Float32List audio,
  }) = _FrbData;
}
