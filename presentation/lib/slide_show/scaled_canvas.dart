import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/slide_show/scale_notifier.dart';

class ScaledCanvas extends ConsumerWidget {
  const ScaledCanvas({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(scaleProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final designWidth = 1920 / scale;
        final aspectRatio = constraints.maxWidth / constraints.maxHeight;
        // On 16:9 this equals 1080/scale; on taller screens it grows
        final designHeight = (designWidth / aspectRatio).clamp(
          1080 / scale,
          double.infinity,
        );

        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: .center,
            child: ClipRect(
              child: SizedBox(
                width: designWidth,
                height: designHeight,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
