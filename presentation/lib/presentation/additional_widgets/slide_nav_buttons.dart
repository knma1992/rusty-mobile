// slide_nav_buttons.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/main.dart';
import 'package:presentation/util/context_extensions.dart';

class SlideNavButtons extends ConsumerStatefulWidget {
  const SlideNavButtons({super.key});

  @override
  ConsumerState<SlideNavButtons> createState() => _SlideNavButtonsState();
}

class _SlideNavButtonsState extends ConsumerState<SlideNavButtons> {
  bool _visible = false;
  Timer? _hideTimer;

  void _onHoverEnter() {
    _hideTimer?.cancel();
    setState(() => _visible = true);
  }

  void _onHoverExit() {
    _hideTimer = Timer(const Duration(seconds: 1), () {
      setState(() => _visible = false);
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        MouseRegion(
          onEnter: (_) => _onHoverEnter(),
          onExit: (_) => _onHoverExit(),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _visible ? 1.0 : 0.0,
            child: IgnorePointer(
              ignoring: !_visible,
              child: Padding(
                padding: const .symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  spacing: 16,
                  mainAxisAlignment: .center,
                  children: [
                    IconButton.filled(
                      onPressed: context.isFirstSlide
                          ? null
                          : context.previousSlide,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      '${(context.currentSlideIndex ?? 0) + 1} / ${slides.length}',
                      style: context.textTheme.bodyLarge,
                    ),
                    IconButton.filled(
                      onPressed: context.isLastSlide ? null : context.nextSlide,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          right: 24,
          child: Text(
            "${context.currentSlideIndex}",
            style: context.textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
