import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:presentation/code_theme.dart';

class MarkDownBlock extends StatelessWidget {
  final String assetPath;
  const MarkDownBlock({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Fehler: ${snapshot.error}'));
        }
        return MarkdownBlock(config: markDownConfig, data: snapshot.data!);
      },
    );
  }
}
