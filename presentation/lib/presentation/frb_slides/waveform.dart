import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/presentation/frb_slides/frb_notifier.dart';
import 'package:presentation/util/context_extensions.dart';

class WaveformScreen extends ConsumerWidget {
  const WaveformScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceState = ref.watch(
      frbProvider.select((state) => state.serviceState),
    );

    return Column(
      spacing: 10,
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        if (serviceState.audioRunnning)
          const Expanded(child: Center(child: WaveFormVisualizer())),
        Row(
          mainAxisAlignment: .center,
          children: [
            if (serviceState.isIdle) ...[
              TextButton(
                onPressed: () {
                  ref.read(frbProvider.notifier).startWavefromStream();
                },
                child: Text("Start", style: context.textTheme.titleLarge),
              ),
            ] else ...[
              TextButton(
                onPressed: () {
                  ref.read(frbProvider.notifier).stop();
                },
                child: Text("Stop", style: context.textTheme.titleLarge),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class WaveFormVisualizer extends ConsumerStatefulWidget {
  const WaveFormVisualizer({super.key});

  @override
  ConsumerState<WaveFormVisualizer> createState() => _WaveFormVisualizerState();
}

class _WaveFormVisualizerState extends ConsumerState<WaveFormVisualizer> {
  FrbNotifier? audioNotifier;
  final _notifier = ValueNotifier<Float32List>(Float32List.fromList([]));

  @override
  void initState() {
    super.initState();
    audioNotifier = ref.read(frbProvider.notifier);
    ref.listenManual(
      frbProvider.select((s) => s.audio),
      (_, next) => _notifier.value = next,
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    debugPrint("DISPOSE");

    Future.microtask(() => audioNotifier?.stop());
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Runs once, never rebuilds for frames
    final colors = context.colorScheme;
    return RepaintBoundary(
      child: CustomPaint(
        painter: WaveformPainter(
          _notifier,
          primaryColor: colors.primary,
          secondaryColor: colors.secondary,
          tertiaryColor: colors.tertiary,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final ValueNotifier<Float32List?> samples;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  WaveformPainter(
    this.samples, {
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  }) : super(repaint: samples);

  @override
  void paint(Canvas canvas, Size size) {
    final data = samples.value;
    if (data == null || data.length < 2) return;

    final mid = size.height / 2;
    final pairs = data.length ~/ 2;
    final step = size.width / pairs;

    final paint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(0, mid - data[1].clamp(-1.0, 1.0) * mid);

    for (var i = 1; i < pairs; i++) {
      final max = data[i * 2 + 1].clamp(-1.0, 1.0);
      path.lineTo(i * step, mid - max * mid);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WaveformPainter old) => false;
}
