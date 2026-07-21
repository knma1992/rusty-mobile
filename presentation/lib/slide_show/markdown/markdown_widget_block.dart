import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:presentation/slide_show/markdown/markdown_theme.dart';

const double _markdownTextScale = 1.2;

final markdownAssetProvider = FutureProvider.autoDispose.family<String, String>(
  (ref, assetPath) => rootBundle.loadString(assetPath),
);

class MarkdownWidgetBlock extends ConsumerWidget {
  final String assetPath;
  const MarkdownWidgetBlock({super.key, required this.assetPath});

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
