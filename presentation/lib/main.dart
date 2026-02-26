import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presentation/presentation/additional_widgets/presentation_scaffold.dart';
import 'package:presentation/presentation/slides/jni_slides.dart';
import 'package:presentation/presentation/slides/title.dart';
import 'package:presentation/presentation/slides/why_rust_slide.dart';
import 'package:presentation/scale_notifier.dart';
import 'package:presentation/theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  await Future.wait([
    rootBundle.loadString('assets/code/drop_example.md'),
    rootBundle.loadString('assets/text/ghidra.md'),
    rootBundle.loadString('assets/code/jni.md'),
  ]);

  WindowOptions windowOptions = const WindowOptions(
    title: '',
    titleBarStyle: TitleBarStyle.normal,
    minimumSize: Size(800, 600),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(ProviderScope(child: PresentationApp()));
}

final List<Widget> slides = [TitleSlide(), WhyRustSlide(), ...jniSlides];

final GoRouter router = GoRouter(
  initialLocation: '/slide/0',
  routes: List.generate(
    slides.length,
    (index) => GoRoute(
      path: '/slide/$index',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: slides[index],
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            BlankCanvas(body: child),
      ),
    ),
  ),
);

class PresentationApp extends ConsumerWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(scaleProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: MaterialTheme(GoogleFonts.googleSansCodeTextTheme()).dark(),
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final designSize = Size(
              (constraints.maxWidth / scale).clamp(800, double.infinity),
              (constraints.maxHeight / scale).clamp(600, double.infinity),
            );

            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: .center,
                child: ClipRect(
                  child: SizedBox(
                    width: designSize.width,
                    height: designSize.height,
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
