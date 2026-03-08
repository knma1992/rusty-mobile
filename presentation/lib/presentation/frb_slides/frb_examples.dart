import 'package:flutter/material.dart';
import 'package:presentation/presentation/additional_widgets/list/bullet_list.dart';
import 'package:presentation/presentation/additional_widgets/markdown/markdown_block.dart';
import 'package:presentation/presentation/frb_slides/frb_slides.dart';

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
        MarkdownWidget(assetPath: 'assets/markdown/frb/enum_rust.md'),
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
        MarkdownWidget(assetPath: 'assets/markdown/frb/enum_dart.md'),
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
        MarkdownWidget(assetPath: 'assets/markdown/frb/stream_example_rust.md'),
        MarkdownWidget(assetPath: 'assets/markdown/frb/stream_example_dart.md'),
      ],
    );
  }
}
