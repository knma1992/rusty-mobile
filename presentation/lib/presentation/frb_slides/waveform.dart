import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/presentation/additional_widgets/enum_dropdown_widget.dart';
import 'package:presentation/presentation/additional_widgets/int_input_panel.dart';
import 'package:presentation/presentation/additional_widgets/list/bullet_list.dart';
import 'package:presentation/presentation/frb_slides/frb_notifier.dart';
import 'package:presentation/presentation/frb_slides/frb_slides.dart';
import 'package:presentation/util/context_extensions.dart';

enum WaveformStyle { normal, dots, bars, spiral }

class WaveformScreen extends ConsumerWidget {
  const WaveformScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (serviceState, waveformStyle, turns) = ref.watch(
      frbProvider.select(
        (state) => (state.serviceState, state.waveformStyle, state.turns),
      ),
    );

    return Column(
      spacing: 10,
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        const Align(alignment: .centerLeft, child: frbHeadline),
        const BulletItem("Audio-Visualizer"),
        if (serviceState.audioRunnning)
          Expanded(
            child: Center(
              child: WaveFormVisualizer(
                waveformStyle: waveformStyle,
                turns: turns,
              ),
            ),
          )
        else ...[
          const Spacer(),
          Center(
            child: Image.asset(
              'assets/images/flutter_meme.jpg',
              height: 450,
              fit: BoxFit.fitHeight,
            ),
          ),
          const Spacer(),
        ],
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
        Row(
          spacing: 16,
          mainAxisAlignment: .center,
          children: [
            EnumDropdownMenu<WaveformStyle>(
              initialSelection: waveformStyle,
              dropdownElementWidth: 300,
              onSelected: (waveformStyle) => ref
                  .read(frbProvider.notifier)
                  .changeWavefromStyle(waveformStyle),
              enums: WaveformStyle.values,
            ),
            if (waveformStyle == WaveformStyle.spiral)
              NumberInputPanel(
                onChanged: (v) =>
                    ref.read(frbProvider.notifier).setTurns(v.toDouble()),
              ),
          ],
        ),
      ],
    );
  }
}

class WaveFormVisualizer extends ConsumerStatefulWidget {
  final WaveformStyle waveformStyle;
  final double turns;
  const WaveFormVisualizer({
    super.key,
    required this.waveformStyle,
    required this.turns,
  });

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
        painter: switch (widget.waveformStyle) {
          WaveformStyle.normal => WaveformPainter(
            _notifier,
            primaryColor: colors.primary,
            secondaryColor: colors.secondary,
            tertiaryColor: colors.tertiary,
          ),
          WaveformStyle.dots => WaveformDotPainter(
            _notifier,
            primaryColor: colors.primary,
            secondaryColor: colors.secondary,
            tertiaryColor: colors.tertiary,
          ),
          WaveformStyle.bars => WaveformBarPainter(
            _notifier,
            primaryColor: colors.primary,
            secondaryColor: colors.secondary,
            tertiaryColor: colors.tertiary,
          ),
          WaveformStyle.spiral => SpiralWaveformPainter(
            _notifier,
            primaryColor: colors.primary,
            secondaryColor: colors.secondary,
            tertiaryColor: colors.tertiary,
            turns: widget.turns,
          ),
        },
        child: const SizedBox.expand(),
      ),
    );
  }
}

class SpiralWaveformPainter extends CustomPainter {
  final ValueNotifier<Float32List?> samples;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;

  /// How many full rotations the spiral makes
  final double turns;

  SpiralWaveformPainter(
    this.samples, {
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    this.turns = 3.0,
  }) : super(repaint: samples);

  @override
  void paint(Canvas canvas, Size size) {
    final data = samples.value;
    if (data == null || data.length < 2) return;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.shortestSide / 2 * 0.9;
    final minRadius = maxRadius * 0.08;

    final pairs = data.length ~/ 2;

    // --- Paints ---
    final wavePaint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path();
    final glowPath = Path();

    for (var i = 0; i < pairs; i++) {
      final t = i / (pairs - 1); // 0.0 (oldest) → 1.0 (newest)

      final amplitude = data[i * 2 + 1].clamp(-1.0, 1.0);

      // Spiral base radius grows from center outward as samples get newer
      final baseRadius = lerpDouble(minRadius, maxRadius, t)!;

      // Waveform displacement scales with radius so inner rings stay tight
      final maxDisplace = baseRadius * 0.35;
      final r = baseRadius + amplitude * maxDisplace;

      final angle = t * turns * 2 * pi - pi / 2;

      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
        glowPath.moveTo(x, y);
      } else {
        path.lineTo(x, y);
        glowPath.lineTo(x, y);
      }
    }

    // Draw glow (tertiary, blurred)
    glowPaint.color = tertiaryColor.withValues(alpha: 0.3);
    canvas.drawPath(glowPath, glowPaint);

    // Draw main wave with gradient from secondary (old) → primary (new)
    // Flutter's drawPath doesn't support per-point color, so we draw
    // segmented chunks with lerped color
    final int segments = 6;
    final segmentSize = pairs ~/ segments;

    for (var s = 0; s < segments; s++) {
      final segT = s / (segments - 1);
      final color = Color.lerp(secondaryColor, primaryColor, segT)!;

      final segPath = Path();
      final start = s * segmentSize;
      final end = (s == segments - 1) ? pairs : start + segmentSize + 1;

      for (var i = start; i < end; i++) {
        final t = i / (pairs - 1);
        final amplitude = data[i * 2 + 1].clamp(-1.0, 1.0);
        final baseRadius = lerpDouble(minRadius, maxRadius, t)!;
        final r = baseRadius + amplitude * baseRadius * 0.35;
        final angle = t * turns * 2 * pi - pi / 2;
        final x = center.dx + r * cos(angle);
        final y = center.dy + r * sin(angle);
        i == start ? segPath.moveTo(x, y) : segPath.lineTo(x, y);
      }

      wavePaint.color = color.withValues(alpha: 0.4 + 0.6 * (s / segments));
      canvas.drawPath(segPath, wavePaint);
    }
  }

  @override
  bool shouldRepaint(SpiralWaveformPainter old) => false;
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

class WaveformDotPainter extends CustomPainter {
  final ValueNotifier<Float32List?> samples;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;

  WaveformDotPainter(
    this.samples, {
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  }) : super(repaint: samples);

  Color _colorForAmplitude(double amplitude) {
    // amplitude is 0.0 (silence) → 1.0 (peak)
    final stops = [
      (0.0, const Color(0xFF4488FF)), // blue       - silence
      (0.3, const Color(0xFF00CCAA)), // cyan       - low
      (0.5, const Color(0xFF44FF44)), // green      - mid
      (0.7, const Color(0xFFAAFF00)), // yellow-green
      (0.85, const Color(0xFFFF8800)), // orange     - loud
      (1.0, const Color(0xFFFF2200)), // red        - peak
    ];

    for (var i = 0; i < stops.length - 1; i++) {
      final (t0, c0) = stops[i];
      final (t1, c1) = stops[i + 1];
      if (amplitude <= t1) {
        final t = (amplitude - t0) / (t1 - t0);
        return Color.lerp(c0, c1, t)!;
      }
    }
    return stops.last.$2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final data = samples.value;
    if (data == null || data.length < 2) return;

    final mid = size.height / 2;
    final pairs = data.length ~/ 2;
    final step = size.width / pairs;

    for (var i = 0; i < pairs; i++) {
      final max = data[i * 2 + 1].clamp(-1.0, 1.0);
      final amplitude = max.abs();
      final y = mid - max * mid;
      final x = i * step;

      final paint = Paint()
        ..color = _colorForAmplitude(amplitude)
        ..strokeWidth = 0
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), 3.0, paint);
    }
  }

  @override
  bool shouldRepaint(WaveformDotPainter old) => false;
}

class WaveformBarPainter extends CustomPainter {
  final ValueNotifier<Float32List?> samples;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;

  WaveformBarPainter(
    this.samples, {
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  }) : super(repaint: samples);

  Color _colorForHeight(double t) {
    // t is 0.0 (bottom) → 1.0 (top/peak)
    const stops = [
      (0.0, Color(0xFF0088FF)), // blue        - floor
      (0.2, Color(0xFF00CCFF)), // cyan
      (0.4, Color(0xFF00FF88)), // cyan-green
      (0.6, Color(0xFF88FF00)), // yellow-green
      (0.75, Color(0xFFFFFF00)), // yellow
      (0.88, Color(0xFFFF8800)), // orange
      (1.0, Color(0xFFFF0000)), // red         - peak
    ];

    for (var i = 0; i < stops.length - 1; i++) {
      final (t0, c0) = stops[i];
      final (t1, c1) = stops[i + 1];
      if (t <= t1) {
        final blend = (t - t0) / (t1 - t0);
        return Color.lerp(c0, c1, blend)!;
      }
    }
    return stops.last.$2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final data = samples.value;
    if (data == null || data.length < 2) return;

    final pairs = data.length ~/ 2;
    final colWidth = size.width / pairs;

    for (var i = 0; i < pairs; i++) {
      final max = data[i * 2 + 1].clamp(0.0, 1.0);
      final x = i * colWidth;
      final top = size.height - (max * size.height);

      final rect = Rect.fromLTWH(x, top, colWidth + 0.5, size.height - top);

      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _colorForHeight(max), // peak color at top
            const Color(0xFF0088FF), // blue at bottom
          ],
        ).createShader(rect);

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(WaveformBarPainter old) => false;
}
