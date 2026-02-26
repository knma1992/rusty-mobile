import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation/additional_widgets/alert_text.dart';
import 'package:presentation/presentation/additional_widgets/bullet_list.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/presentation/additional_widgets/markdown_block.dart';
import 'package:url_launcher/url_launcher.dart';

const jniSlides = [
  JniOverview(),
  JniTypes(),
  WhichMeans(),
  JniFootGun(),
  JniNSA(),
  JniRustAwesome(),
  JniRustAwesomeAnswer(),
];

class JniOverview extends StatelessWidget {
  const JniOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Headline(highlight: "JNI", rest: ': Java Native Interface'),
        SizedBox(height: 30),
        BulletList(
          items: [
            "The JNI allows Java code running inside the JVM to interoperate with applications and libraries written in other programming languages, such as C, C++, and assembly.",
            "By loading a shared library (.so file) into the same process memory, the JVM can instruct the OS to execute native code directly — without the JVM needing to understand or interpret it.",
          ],
        ),
      ],
    );
  }
}

class JniTypes extends StatelessWidget {
  const JniTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Headline(highlight: "JNI", rest: ': Java Native Interface'),
        SizedBox(height: 30),
        BulletList(
          items: [
            "Primitive types are passed by value, with no conversion overhead.",
            "Reference types (Strings, Objects, arrays) cannot be passed directly because they live on the JVM's managed heap. Instead, the JVM passes a handle (reference) and the native code must call back into the JVM to extract the underlying data as a usable copy.",
            "The JVM ensures the handle remains valid for the lifetime of the native call, preventing the garbage collector from collecting the underlying object while native code still holds a reference to it.",
          ],
        ),
      ],
    );
  }
}

class WhichMeans extends StatelessWidget {
  const WhichMeans({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        JniTypes(),
        const SizedBox(height: 60),
        Center(child: AlertText(text: "Which Means?")),
      ],
    );
  }
}

class JniFootGun extends StatelessWidget {
  const JniFootGun({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Headline(highlight: "JNI", rest: ': Java Native Interface'),
        const SizedBox(height: 120),
        Center(
          child: Image.asset(
            'assets/footgun.webp',
            height: 300,
            fit: BoxFit.fitHeight,
          ),
        ),
        Center(
          child: AlertText(
            text: "Someone needs to release the goddamn memory!",
          ),
        ),
      ],
    );
  }
}

class JniNSA extends StatelessWidget {
  const JniNSA({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Headline(highlight: "JNI", rest: ': Java Native Interface'),
        const SizedBox(height: 30),
        Center(
          child: QuestionText(
            text:
                "Let's take a look in to the binary using our favourite tool from the NSA.",
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: GestureDetector(
            onTap: () async {
              launchUrl(
                Uri.parse('https://github.com/NationalSecurityAgency/ghidra'),
              );
            },
            child: Image.asset(
              'assets/GHIDRA_3.png',
              height: 100,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: Image.asset(
            'assets/nsa.gif',
            height: 400,
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }
}

class JniRustAwesome extends StatelessWidget {
  const JniRustAwesome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Headline(highlight: "JNI", rest: ': Java Native Interface'),
        const SizedBox(height: 30),
        BulletList(items: ["Rust handles that for us by implementing drop."]),
        MarkDownBlock(assetPath: 'assets/text/ghidra.md'),
        Center(child: QuestionText(text: "Who can spot the fancy jump?")),
      ],
    );
  }
}

class JniRustAwesomeAnswer extends StatelessWidget {
  const JniRustAwesomeAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const JniRustAwesome(),
        Center(child: QuestionText(text: "CBZ: Compare and Branch if Zero")),
      ],
    );
  }
}

class JniFunction extends StatelessWidget {
  const JniFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Headline(highlight: "How", rest: ': JNI'),
        MarkDownBlock(assetPath: 'assets/code/jni.md'),
      ],
    );
  }
}
