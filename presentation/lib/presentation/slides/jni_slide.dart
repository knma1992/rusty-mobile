import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/presentation/additional_widgets/markdown_block.dart';

class JniySlide extends StatelessWidget {
  const JniySlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Headline(highlight: "How", rest: ': JNI'),
        Padding(
          padding: const .all(8.0),
          child: MarkDownBlock(assetPath: 'assets/code/jni.md'),
        ),
      ],
    );
  }
}
