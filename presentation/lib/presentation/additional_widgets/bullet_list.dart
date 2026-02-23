import 'package:flutter/material.dart';
import 'package:presentation/util/context_extensions.dart';

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [for (final item in items) BulletItem(item: item)],
    );
  }
}

class BulletItem extends StatelessWidget {
  final String item;
  const BulletItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Text('• ', style: context.textTheme.headlineMedium),
          Expanded(child: Text(item, style: context.textTheme.headlineMedium)),
        ],
      ),
    );
  }
}
