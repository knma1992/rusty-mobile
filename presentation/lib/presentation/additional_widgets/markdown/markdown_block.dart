import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:presentation/markdown_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'markdown_block.g.dart';

const double _markdownTextScale = 1.2;

@riverpod
Future<String> markdownAsset(Ref ref, String assetPath) =>
    rootBundle.loadString(assetPath);

class MarkdownWidget extends ConsumerWidget {
  final String assetPath;
  const MarkdownWidget({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(markdownAssetProvider(assetPath));
    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (data) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: const TextScaler.linear(_markdownTextScale)),
        child: MarkdownBlock(config: markdownConfig, data: data),
      ),
    );
  }
}
