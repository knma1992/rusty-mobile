import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation/additional_widgets/alert_text.dart';
import 'package:presentation/presentation/additional_widgets/bullet_list.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/presentation/additional_widgets/markdown_block.dart';

// constants/headlines.dart
const uniffiHeadline = Headline(
  highlight: "UniFFI",
  rest: ': Universal Foreign Function Interface',
);

const uniffiSlides = [
  UniffiOverview(),
  UniffiHowTo(),
  UniffiHowToSecond(),
  UniffiBuild(),
  UniffiGenerated(),
  UniffiBenchmark(),
];

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
            "Supports multiple languages like Kotlin, Swift, and Python, with third party extensions for other languages like C#.",
            "Uses a UDL interface definition or proc macros to describe your API.",
            "Official crate from mozilla.",
          ],
        ),
      ],
    );
  }
}

class UniffiHowTo extends StatelessWidget {
  const UniffiHowTo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        uniffiHeadline,
        BulletItem("Create a Rust library."),
        MarkdownWidget(assetPath: 'assets/markdown/uniffi/cargo_init.md'),
        BulletItem("Add uniffi as dependency and build-dependency."),
        MarkdownWidget(assetPath: 'assets/markdown/uniffi/cargo_toml.md'),
      ],
    );
  }
}

class UniffiHowToSecond extends StatelessWidget {
  const UniffiHowToSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        uniffiHeadline,
        BulletItem(
          "Add Rust build file, this ensures it uses the same version defined in cargo.toml.",
        ),
        MarkdownWidget(assetPath: 'assets/markdown/uniffi/uniffi_bindgen.md'),
        //--
        BulletItem(
          "Either define the Schema in an UDL file or use proc macros.",
        ),
        MarkdownWidget(assetPath: 'assets/markdown/uniffi/proc_macros.md'),
        Center(
          child: Padding(
            padding: .symmetric(vertical: 10.0),
            child: HighlightText("Look, no more ugly JNI types."),
          ),
        ),
      ],
    );
  }
}

class UniffiBuild extends StatelessWidget {
  const UniffiBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        uniffiHeadline,
        BulletItem(
          "Now implement the cli commands in your favorite scripting language.",
        ),
        MarkdownWidget(assetPath: 'assets/markdown/uniffi/build_uniffi.md'),
        Center(
          child: Padding(
            padding: .symmetric(vertical: 10.0),
            child: HighlightText(
              "Now let's take a look into the generated bindings!",
            ),
          ),
        ),
      ],
    );
  }
}

class UniffiGenerated extends StatelessWidget {
  const UniffiGenerated({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        uniffiHeadline,
        BulletItem(
          "It's all there, 1137 lines of generated blob for two functions and a data class.",
        ),
        MarkdownWidget(assetPath: 'assets/markdown/uniffi/uniffi_garbage.md'),
        Center(
          child: Padding(
            padding: .symmetric(vertical: 10.0),
            child: HighlightText("Let's run some benchmarks!"),
          ),
        ),
      ],
    );
  }
}

class UniffiBenchmark extends StatelessWidget {
  const UniffiBenchmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        uniffiHeadline,
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(width: 30),
            Image.asset(
              'assets/images/benchmark.png',
              width: 600,
              fit: BoxFit.fitHeight,
            ),
            const Expanded(
              child: BulletList(
                items: [
                  "UniFFI trades raw performance for developer ergonomics.",
                  "UniFFI adds serialization overhead.",
                  "UniFFI uses JNA Java Native Access.",
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
