import 'package:flutter/material.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/presentation/additional_widgets/list/bullet_list.dart';

class WhyRustSlide extends StatelessWidget {
  const WhyRustSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        Headline(highlight: 'Reasons to use Rust', rest: ''),
        BulletList(
          items: [
            'Speed: Native speed with zero garbage collector pauses',
            'Ecosystem: Access to Cargo\'s vast ecosystem of libraries',
            'Code Sharing: Write core logic once, share across platforms',
            'No more C++',
          ],
          style: TextStyle(fontSize: 55),
        ),
      ],
    );
  }
}
