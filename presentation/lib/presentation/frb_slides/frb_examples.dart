import 'package:flutter/material.dart';
import 'package:presentation/presentation/frb_slides/frb_slides.dart';
import 'package:presentation/slide_show/widgets/bullet_list.dart';
import 'package:presentation/slide_show/widgets/markdown_widget_block.dart';

const frbExampleSlides = [FrbEnumRust(), FrbEnumDart(), FrbStream()];

class FrbEnumRust extends StatelessWidget {
  const FrbEnumRust({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        frbHeadline,
        BulletItem("Auto generates enum to sealed classes using freezed."),
        MarkdownWidgetBlock(assetPath: 'assets/markdown/frb/enum_rust.md'),
      ],
    );
  }
}

class FrbEnumDart extends StatelessWidget {
  const FrbEnumDart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        frbHeadline,
        BulletItem("Dart bindings."),
        MarkdownWidgetBlock(assetPath: 'assets/markdown/frb/enum_dart.md'),
      ],
    );
  }
}

class FrbStream extends StatelessWidget {
  const FrbStream({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        frbHeadline,
        BulletItem("Dart streams are supported."),
        MarkdownWidgetBlock(
          assetPath: 'assets/markdown/frb/stream_example_rust.md',
        ),
        MarkdownWidgetBlock(
          assetPath: 'assets/markdown/frb/stream_example_dart.md',
        ),
      ],
    );
  }
}
