import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scale_notifier.g.dart';

@Riverpod(keepAlive: true)
class ScaleNotifier extends _$ScaleNotifier {
  @override
  double build() {
    return 1.0;
  }

  void increase() {
    state = (state + 0.04).clamp(0.5, 2.0);
  }

  void decrease() {
    state = (state - 0.04).clamp(0.5, 2.0);
  }
}
