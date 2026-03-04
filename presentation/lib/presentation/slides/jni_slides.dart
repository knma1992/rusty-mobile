import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation/additional_widgets/alert_text.dart';
import 'package:presentation/presentation/additional_widgets/bullet_list.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/presentation/additional_widgets/labeled_list.dart';
import 'package:presentation/presentation/additional_widgets/markdown_block.dart';
import 'package:url_launcher/url_launcher.dart';

// constants/headlines.dart
const jniHeadline = Headline(highlight: "JNI", rest: ': Java Native Interface');

const jniSlides = [
  JniOverview(),
  WhichMeans(),
  JniFootGun(),
  JniFootGunBefore(),
  JniSetupProjectFirst(),
  JniSetupProjectSecond(),
  JniDetail(),
  JniFunction(),
  JniLoad(),
  JniNSA(),
  JniRustAwesome(),
  JniObjects(),
  JniObjectSecond(),
  JniObjectThird(),
  JniKotlinDataClass(),
  JniRecap(),
];

class JniOverview extends StatelessWidget {
  const JniOverview({super.key});

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
            "Primitive types (int, float...) are copied directly.",
            "Receiving reference types: Get a handle, ask the JVM to copy the data into native memory.",
            "That native copy lives outside the JVM where the garbage collector can't see it.",
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
        JniOverview(),
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

class JniFootGunBefore extends StatelessWidget {
  const JniFootGunBefore({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 60,
      crossAxisAlignment: .start,
      children: [
        JniFootGun(),
        SizedBox(height: 50),
        Center(
          child: HighlightText(
            "But before we get in to that! Let's set up a Rust library.",
          ),
        ),
      ],
    );
  }
}

class JniSetupProjectFirst extends StatelessWidget {
  const JniSetupProjectFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletItem(
          "Install Rust and set up a Rust library near your Android porject.",
        ),
        MarkdownWidget(assetPath: 'assets/markdown/jni/cargo_init.md'),
        BulletItem(
          "Add crate-type for creating a C-compatible dynamic library and ndk compile targets.",
        ),
        MarkdownWidget(assetPath: 'assets/markdown/jni/cargo_toml.md'),
        BulletItem("Install Rust compile targets"),
        MarkdownWidget(assetPath: 'assets/markdown/jni/rustup_install.md'),
      ],
    );
  }
}

class JniSetupProjectSecond extends StatelessWidget {
  const JniSetupProjectSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletItem(
          "Install Rust NDK for easier Android environment configuration.",
        ),
        MarkdownWidget(assetPath: 'assets/markdown/jni/cargo_ndk.md'),
        BulletItem("Create a build cli in your favourite scripting language."),
        MarkdownWidget(assetPath: 'assets/markdown/jni/build_jni.md'),
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
        MarkdownWidget(assetPath: 'assets/markdown/jni/jni.md'),
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

class JniNSA extends StatelessWidget {
  const JniNSA({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 30,
      children: [
        jniHeadline,
        const Center(child: AlertText("Remember the footgun?")),
        const Center(
          child: HighlightText(
            "Let's take a look in to the binary using our favourite tool from the NSA.",
          ),
        ),
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
        MarkdownWidget(assetPath: 'assets/markdown/jni/ghidra.md'),
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
        MarkdownWidget(assetPath: 'assets/markdown/jni/jni.md'),
        BulletList(
          items: [
            "With the jni_fn annotation the function signature is simplified.",
          ],
        ),
        MarkdownWidget(assetPath: 'assets/markdown/jni/jni_fn.md'),
      ],
    );
  }
}

class JniLoad extends StatelessWidget {
  const JniLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletItem("Load in the dynamic library."),
        MarkdownWidget(assetPath: 'assets/markdown/jni/system_load.md'),
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
        MarkdownWidget(assetPath: 'assets/markdown/jni/city.md'),

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
        MarkdownWidget(assetPath: 'assets/markdown/jni/jni_types.md'),
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
        MarkdownWidget(assetPath: 'assets/markdown/jni/get_karlsruhe.md'),
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
        MarkdownWidget(assetPath: 'assets/markdown/jni/city_data_class.md'),
      ],
    );
  }
}

class JniRecap extends StatelessWidget {
  const JniRecap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        jniHeadline,
        BulletList(
          items: [
            "JNI bridges Java/Kotlin and native Rust code via a shared library (.so).",
            "But sending objects is overly complicated and error prone.",
            "It could be circumvented by sending JSON.",
          ],
        ),
        SizedBox(height: 90),
        Center(child: HighlightText("Maybe there is a better way?")),
      ],
    );
  }
}
