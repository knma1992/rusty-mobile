import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:iron_bird_call/iron_bird_call.dart' as rust_api;
import 'package:presentation/presentation/frb_slides/frb_data.dart';
import 'package:presentation/presentation/frb_slides/terrain_colors.dart';
import 'package:presentation/presentation/frb_slides/waveform.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'frb_notifier.g.dart';

const width = 300;
const height = 300;

@riverpod
class FrbNotifier extends _$FrbNotifier {
  StreamSubscription? _subscription;
  rust_api.RustAudioRecorder? recorder;
  @override
  FrbData build() {
    ref.onDispose(() async {
      recorder?.stop();
      _subscription?.cancel();
    });

    return FrbData(
      image: null,
      serviceState: ServiceState.idle,
      audio: Float32List.fromList([]),
      waveformStyle: WaveformStyle.normal,
    );
  }

  Future<void> startWavefromStream() async {
    state = state.copyWith(serviceState: ServiceState.audio);
    recorder = rust_api.RustAudioRecorder();

    debugPrint(
      "recorder sampleRate: ${recorder?.sampleRate}, bufferSize: ${recorder?.bufferSize}, channels: ${recorder?.channels}",
    );

    recorder
        ?.startStreamWaveform(
          bufferSize: BigInt.from(32000),
          samplesPerPixel: BigInt.from(2),
        )
        .listen(
          (audio) {
            // debugPrint("audio: ${audio.length}");
            state = state.copyWith(audio: audio);
          },
          onDone: () {
            debugPrint("onDone");
            state = state.copyWith(
              serviceState: ServiceState.idle,
              audio: Float32List.fromList([]),
            );
          },
        );
  }

  Future<void> startTerrainStream() async {
    state = state.copyWith(serviceState: ServiceState.terrain);

    final stream = rust_api.terrainStream(
      imageSize: const rust_api.Size(width: width, height: height),
      colors: terrainColors,
    );

    bool _decoding = false;
    _subscription = stream.listen(
      (bytes) {
        if (_decoding) return;
        _decoding = true;

        ui.decodeImageFromPixels(
          bytes,
          width,
          height,
          ui.PixelFormat.rgba8888,
          (image) {
            final oldImage = state.image;
            state = state.copyWith(image: image);
            oldImage?.dispose();
            _decoding = false;
          },
        );
      },
      onDone: () {
        state = state.copyWith(serviceState: ServiceState.idle);
      },
    );
  }

  Future<void> stop() async {
    state = state.copyWith(serviceState: ServiceState.loading);
    await _subscription?.cancel();
    await recorder?.stop();
    _subscription = null;
    state = state.copyWith(serviceState: ServiceState.idle, image: null);
  }

  void changeWavefromStyle(WaveformStyle waveformStyle) {
    state = state.copyWith(waveformStyle: waveformStyle);
  }
}
