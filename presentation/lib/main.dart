import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_bird_call/iron_bird_call.dart' as rust_api;
import 'package:presentation/presentation/default/blank_canvas.dart';
import 'package:presentation/presentation/frb_slides/frb_slides.dart';
import 'package:presentation/presentation/slides/jni_slides.dart';
import 'package:presentation/presentation/slides/title.dart';
import 'package:presentation/presentation/slides/uniffi_slides.dart';
import 'package:presentation/presentation/slides/why_rust_slide.dart';
import 'package:presentation/scale_notifier.dart';
import 'package:presentation/theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  await rust_api.RustLib.init();
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    title: '',
    titleBarStyle: TitleBarStyle.normal,
    minimumSize: Size(800, 600),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: PresentationApp()));
}

const List<Widget> slides = [
  TitleSlide(),
  WhyRustSlide(),
  ...jniSlides,
  ...uniffiSlides,
  ...frbSlides,
];

class PresentationApp extends ConsumerWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(scaleProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BlankCanvas(),
      theme: MaterialTheme(GoogleFonts.googleSansCodeTextTheme()).dark(),
      builder: (context, child) {
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
      },
    );
  }
}
