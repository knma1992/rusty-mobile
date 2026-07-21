import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_bird_call/iron_bird_call.dart' as rust_api;
import 'package:presentation/presentation/frb_slides/frb_slides.dart';
import 'package:presentation/presentation/slides/jni_slides.dart';
import 'package:presentation/presentation/slides/title.dart';
import 'package:presentation/presentation/slides/uniffi_slides.dart';
import 'package:presentation/presentation/slides/why_rust_slide.dart';
import 'package:presentation/slyde/slyde.dart';

void main() async {
  await rust_api.RustLib.init();

  await initSlideShowWindow();

  runApp(const ProviderScope(child: PresentationApp()));
}

const List<Widget> slides = [
  TitleSlide(),
  WhyRustSlide(),
  ...jniSlides,
  ...uniffiSlides,
  ...frbSlides,
];

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SlideShow(slides: slides),
      theme: SlydeTheme(GoogleFonts.googleSansCodeTextTheme()).dark(),
    );
  }
}
