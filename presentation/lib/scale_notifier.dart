import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaleNotifier extends Notifier<double> {
  @override
  double build() => 1.0;

  void increase() {
    state = (state + 0.04).clamp(0.5, 2.0);
  }

  void decrease() {
    state = (state - 0.04).clamp(0.5, 2.0);
  }

  void reset() {
    state = 1.0;
  }
}

final scaleProvider = NotifierProvider<ScaleNotifier, double>(
  ScaleNotifier.new,
);
