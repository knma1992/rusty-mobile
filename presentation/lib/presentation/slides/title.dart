import 'package:flutter/material.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';
import 'package:presentation/presentation/additional_widgets/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';

class TitleSlide extends StatelessWidget {
  const TitleSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(32.0, 0, 32.0, 16.0),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          const Headline(
            highlight: 'Rust on Mobile',
            rest: ': Comparing JNI, UniFFI, and Flutter Rust Bridge',
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const .all(16.0),
            child: Row(
              spacing: 16,
              children: [
                Image.asset(
                  'assets/images/markus_profile_pic.png',
                  height: 250,
                  fit: .fitHeight,
                ),
                const Column(
                  crossAxisAlignment: .start,
                  children: [
                    SmallText("Markus Knoch"),
                    SmallText("markus.knoch@kenbun.de"),
                    SmallText("ML/Mobile Developer"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
          Center(
            child: GestureDetector(
              onTap: () async {
                launchUrl(Uri.parse('https://www.kenbun.de'));
              },
              child: Image.asset(
                'assets/images/kenbun_web_app_bar.png',
                height: 100,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
