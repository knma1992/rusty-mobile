import 'package:flutter/material.dart';
import 'package:presentation/presentation/additional_widgets/headline.dart';

class TitleSlide extends StatelessWidget {
  const TitleSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Headline(
          highlight: 'Rust on Mobile',
          rest: ': Comparing JNI, UniFFI, and Flutter Rust Bridge',
        ),
        SizedBox(height: 30),
        Padding(
          padding: const .all(16.0),
          child: Row(
            spacing: 16,
            children: [
              Image.asset(
                'assets/markus_profile_pic.png',
                height: 120,
                fit: BoxFit.fitHeight,
              ),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text("Markus Knoch"),
                  Text("markus.knoch@kenbun.de"),
                  Text("ML/Mobile Developer"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
