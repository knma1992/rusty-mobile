import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation/additional_widgets/bullet_list.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';

// constants/headlines.dart
const uniffiHeadline = Headline(
  highlight: "UniFFI",
  rest: ': Universal Foreign Function Interface',
);

const uniffiSlides = [UniffiOverview()];

class UniffiOverview extends StatelessWidget {
  const UniffiOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        uniffiHeadline,
        BulletList(
          items: [
            "Generates cross-language bindings from a single Rust library.",
            "Supports multiple languages like Kotlin, Swift, Python, and Ruby out of the box.",
            "Uses a UDL interface definition or proc macros to describe your API.",
          ],
        ),
      ],
    );
  }
}
