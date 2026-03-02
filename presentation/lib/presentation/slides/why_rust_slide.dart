import 'package:flutter/material.dart';
import 'package:presentation/presentation/additional_widgets/bullet_list.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/util/context_extensions.dart';

class WhyRustSlide extends StatelessWidget {
  const WhyRustSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Speed: Native speed with zero garbage collector pauses',
      'Ecosystem: Access to Cargo\'s vast ecosystem of libraries',
      'Code Sharing: Write core logic once, share across platforms',
      'Modern NDK: No more C++',
    ];

    return Column(
      crossAxisAlignment: .start,
      children: [
        const Headline(highlight: 'Why', rest: ': Reasons to use Rust'),
        BulletList(items: items, style: context.textTheme.displayMedium),
      ],
    );
  }
}
