import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/main.dart';

// slide_navigation.dart
extension SlideNavigation on BuildContext {
  int get _slideCount => slides.length;

  int? get currentSlideIndex {
    final location = GoRouterState.of(this).uri.toString();
    final match = RegExp(r'/slide/(\d+)').firstMatch(location);
    return match != null ? int.tryParse(match.group(1)!) : null;
  }

  void nextSlide() {
    if (isLastSlide) return;
    final index = currentSlideIndex;
    if (index == null || index >= _slideCount - 1) return; // already at last
    go('/slide/${index + 1}');
  }

  void previousSlide() {
    if (isFirstSlide) return;
    final index = currentSlideIndex;
    if (index == null || index <= 0) return; // already at first
    go('/slide/${index - 1}');
  }

  void goToSlide(int index) {
    if (index < 0 || index >= _slideCount) return; // out of bounds
    go('/slide/$index');
  }

  bool get isFirstSlide => currentSlideIndex == 0;
  bool get isLastSlide => currentSlideIndex == _slideCount - 1;
}

extension ColorSchemeExtensions on ColorScheme {
  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;
}

extension ContextExtensions on BuildContext {
  Orientation get orientation => MediaQuery.of(this).orientation;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
}

extension KeyDownEventExtensions on KeyEvent {
  bool get isHKey =>
      (this is KeyDownEvent) && logicalKey == LogicalKeyboardKey.keyH;
  bool get isLeftArrow =>
      (this is KeyDownEvent) && logicalKey == LogicalKeyboardKey.arrowLeft;
  bool get isRightArrow =>
      (this is KeyDownEvent) && logicalKey == LogicalKeyboardKey.arrowRight;

  bool get isCharAdd => character == "+";
  bool get isChardMinus => character == "-";
}
