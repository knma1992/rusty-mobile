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

const List<Widget> slides = [TitleSlide(), WhyRustSlide(), ...jniSlides];

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
            final designSize = Size((1920 / scale), (1080 / scale));

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
