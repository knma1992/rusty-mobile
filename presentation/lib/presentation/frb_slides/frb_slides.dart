import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/presentation/additional_widgets/alert_text.dart';
import 'package:presentation/presentation/additional_widgets/bullet_list.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/presentation/additional_widgets/markdown_block.dart';
import 'package:presentation/presentation/frb_slides/frb_notifier.dart';
import 'package:presentation/presentation/frb_slides/waveform.dart';
import 'package:presentation/util/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

const frbHeadline = Headline(highlight: "FRB", rest: ': Flutter Rust Bridge');

const frbSlides = [
  FrbHint(),
  TerrainScreen(),
  FrbOverview(),
  FrbSetup(),
  WaveformScreen(),
];

class FrbHint extends StatelessWidget {
  const FrbHint({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Row(
          mainAxisAlignment: .center,
          children: [HighlightText("Maybe there is a even better way?")],
        ),
      ],
    );
  }
}

class FrbOverview extends StatelessWidget {
  const FrbOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        frbHeadline,
        const BulletList(
          items: [
            "Why fight the JVM when you can just use Flutter.",
            "No more JNI/JNA Flutter and Rust play nicely with the FFI.",
            "Rust is cross platform and so is Flutter.",
            "Rust runs in a seperated Thread and does not block the ui thread.",
            "Auto generates bindings.",
            "Structs get translated in to data classes and enum to sealed classes.",
          ],
        ),

        GestureDetector(
          onTap: () async {
            launchUrl(
              Uri.parse('https://github.com/fzyzcjy/flutter_rust_bridge'),
            );
          },
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 400,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}

class FrbSetup extends StatelessWidget {
  const FrbSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        frbHeadline,
        BulletItem("Install Flutter Rust Bridge Codegen."),
        MarkdownWidget(assetPath: 'assets/markdown/frb/install.md'),
        BulletItem("Create the app and your ready to go."),
        MarkdownWidget(assetPath: 'assets/markdown/frb/setup.md'),
      ],
    );
  }
}

class TerrainScreen extends ConsumerWidget {
  const TerrainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    final serviceState = ref.watch(
      frbProvider.select((state) => state.serviceState),
    );

    return Column(
      spacing: 10,
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        if (serviceState.terrainRunning) ...[
          frbHeadline,
          const Expanded(
            child: Center(
              child: AspectRatio(aspectRatio: 1, child: TerrainImage()),
            ),
          ),
        ],

        Row(
          mainAxisAlignment: .center,
          children: [
            if (serviceState.terrainRunning)
              TextButton(
                onPressed: () {
                  ref.read(frbProvider.notifier).stop();
                },
                child: Text("Stop", style: context.textTheme.titleLarge),
              ),

            if (serviceState.isIdle)
              TextButton(
                onPressed: () {
                  ref.read(frbProvider.notifier).startTerrainStream();
                },
                child: Text("Start", style: context.textTheme.titleLarge),
              ),
          ],
        ),
      ],
    );
  }
}

class TerrainImage extends ConsumerStatefulWidget {
  const TerrainImage({super.key});

  @override
  ConsumerState<TerrainImage> createState() => _TerrainImageState();
}

class _TerrainImageState extends ConsumerState<TerrainImage> {
  FrbNotifier? frbNotifier;
  final _imageNotifier = ValueNotifier<ui.Image?>(null);

  @override
  void initState() {
    super.initState();
    frbNotifier = ref.read(frbProvider.notifier);
    // Bridge Riverpod → ValueNotifier
    ref.listenManual(
      frbProvider.select((s) => s.image),
      (_, next) => _imageNotifier.value = next,
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    Future.microtask(() => frbNotifier?.stop());
    _imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Runs once, never rebuilds for frames
    return GestureDetector(
      onTapDown: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final widgetSize = renderBox.size;

        final px = (details.localPosition.dx / widgetSize.width * width)
            .toInt();
        final py = (details.localPosition.dy / widgetSize.height * height)
            .toInt();

        debugPrint("x: $px, y: $py");
      },
      child: RepaintBoundary(
        child: CustomPaint(
          painter: TerrainPainter(_imageNotifier),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class TerrainPainter extends CustomPainter {
  final ValueNotifier<ui.Image?> imageNotifier;

  TerrainPainter(this.imageNotifier) : super(repaint: imageNotifier);

  @override
  void paint(Canvas canvas, Size size) {
    final image = imageNotifier.value;
    if (image == null) return;
    paintImage(
      canvas: canvas,
      rect: Offset.zero & size,
      image: image,
      fit: BoxFit.fill,
      filterQuality: FilterQuality.none,
    );
  }

  @override
  bool shouldRepaint(TerrainPainter old) => false;
}
