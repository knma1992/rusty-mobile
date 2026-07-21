import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/main.dart';

class SlideIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  bool get isFirst => state == 0;
  bool get isLast => state == slides.length - 1;

  void next() {
    if (!isLast) state = state + 1;
  }

  void previous() {
    if (!isFirst) state = state - 1;
  }

  void goTo(int index) {
    if (index < 0 || index >= slides.length) return;
    state = index;
  }
}

final slideIndexProvider = NotifierProvider<SlideIndexNotifier, int>(
  SlideIndexNotifier.new,
);
