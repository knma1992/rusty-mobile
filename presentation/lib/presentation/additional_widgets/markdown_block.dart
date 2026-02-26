import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:presentation/markdown_theme.dart';

class MarkDownBlock extends StatefulWidget {
  final String assetPath;
  const MarkDownBlock({super.key, required this.assetPath});

  @override
  State<MarkDownBlock> createState() => _MarkDownBlockState();
}

class _MarkDownBlockState extends State<MarkDownBlock> {
  late final Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = rootBundle.loadString(widget.assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Fehler: ${snapshot.error}'));
        }
        return MarkdownBlock(config: markdownConfig, data: snapshot.data!);
      },
    );
  }
}
