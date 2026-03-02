import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation/additional_widgets/alert_text.dart';
import 'package:presentation/presentation/additional_widgets/bullet_list.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/presentation/additional_widgets/labeled_list.dart';
import 'package:presentation/presentation/additional_widgets/markdown_block.dart';
import 'package:presentation/util/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

// constants/headlines.dart
const jniHeadline = Headline(highlight: "JNI", rest: ': Java Native Interface');

const jniSlides = [
  JniTypes(),
  JniBorder(),
  WhichMeans(),
  JniFootGun(),
  JniNSA(),
  JniRustAwesome(),
  JniDetail(),
  JniFunction(),
  JniObjects(),
  JniObjectSecond(),
  JniObjectThird(),
  JniKotlinDataClass(),
  // JniKotlinDataClassConfusion(),
];

class JniTypes extends StatelessWidget {
  const JniTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(
          items: [
            "JNI allows Java/Kotlin code running inside the JVM to call native code written in languages like C, C++, or Rust.",
            "The JVM loads a shared library (.so) into the process and instructs the OS to execute the native code directly, with no interpretation needed.",
          ],
        ),
        MarkdownWidget(assetPath: 'assets/markdown/system_load.md'),
      ],
    );
  }
}

class JniBorder extends StatelessWidget {
  const JniBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(
          items: [
            "Primitive types (int, float...) are copied directly.",
            "Receiving reference types: Get a handle, ask the JVM to copy the data into native memory.",
            "That native copy lives outside the JVM — the garbage collector can't see it.",
            "Sending reference types: Ask the JVM to construct a new object on its heap and pass the values in.",
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
    return const Column(
      crossAxisAlignment: .start,
      children: [
        JniBorder(),
        SizedBox(height: 60),
        Center(child: AlertText("Which Means?")),
      ],
    );
  }
}

class JniFootGun extends StatelessWidget {
  const JniFootGun({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 60,
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        Center(
          child: Image.asset(
            'assets/images/footgun.webp',
            height: 300,
            fit: BoxFit.fitHeight,
          ),
        ),
        const Center(
          child: SizedBox(
            width: 1200,
            child: AlertText("Someone needs to release the goddamn memory!"),
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
        jniHeadline,
        const Center(
          child: HighlightText(
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
              'assets/images/GHIDRA_3.png',
              height: 100,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: Image.asset(
            'assets/images/nsa.gif',
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
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(items: ["Rust handles that for us by implementing drop."]),
        MarkdownWidget(assetPath: 'assets/markdown/ghidra.md'),
      ],
    );
  }
}

class JniDetail extends StatelessWidget {
  const JniDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(items: ["Breaking down the JNI function signature."]),
        MarkdownWidget(assetPath: 'assets/markdown/jni.md'),
        LabeledList(
          items: [
            (
              header: "#[no_mangle]",
              body: "Stop the compiler from renaming this function.",
            ),
            (
              header: 'extern "system"',
              body:
                  'Marks the function as callable from outside Rust and tells the compiler to use the platform system ABI, so the JVM can call it correctly.',
            ),
            (
              header: 'JNIEnv',
              body:
                  'A handle to the JVM environment, used to call JNI functions and interact with Java/Kotlin objects.',
            ),
            (
              header: 'JClass',
              body:
                  'A local reference to the Java class this function belongs to, managed by the JVM.',
            ),
            (header: "jint", body: "Java int corresponds to Rust's i32."),
          ],
        ),
      ],
    );
  }
}

class JniFunction extends StatelessWidget {
  const JniFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(items: ["Reducing boilerplate with jni_fn."]),
        MarkdownWidget(assetPath: 'assets/markdown/jni.md'),
        BulletList(
          items: [
            "With the jni_fn annotation the function signature is simplified.",
          ],
        ),
        MarkdownWidget(assetPath: 'assets/markdown/jni_fn.md'),
      ],
    );
  }
}

class JniObjects extends StatelessWidget {
  const JniObjects({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(
          items: [
            "What about objects? Let's define a generic struct and instantiate an object.",
          ],
        ),
        MarkdownWidget(assetPath: 'assets/markdown/city.md'),

        Center(
          child: HighlightText(
            "Remember: All non primitive types can't cross the border easily! We must ask the JVM nicely to allocate an object on its heap and then pass data into it.",
          ),
        ),
      ],
    );
  }
}

class JniObjectSecond extends StatelessWidget {
  const JniObjectSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(
          items: [
            "Strings can be allocated and passed in one single call.",
            "Arrays must first be allocated and then the data can be copied in.",
          ],
        ),
        MarkdownWidget(assetPath: 'assets/markdown/jni_types.md'),
      ],
    );
  }
}

class JniObjectThird extends StatelessWidget {
  const JniObjectThird({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(items: ["Now to the fun part!"]),
        MarkdownWidget(assetPath: 'assets/markdown/get_karlsruhe.md'),
      ],
    );
  }
}

class JniKotlinDataClass extends StatelessWidget {
  const JniKotlinDataClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(items: ["Kotlin City Data Class"]),
        MarkdownWidget(assetPath: 'assets/markdown/city_data_class.md'),
      ],
    );
  }
}
