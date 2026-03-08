import 'package:flutter/material.dart';
import 'package:presentation/util/context_extensions.dart';

class LabeledList extends StatelessWidget {
  final List<({String header, String body})> items;
  const LabeledList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(), // shrinks to widest label
        1: FlexColumnWidth(), // takes remaining space
      },
      children: [for (final item in items) _buildRow(context, item)],
    );
  }

  TableRow _buildRow(
    BuildContext context,
    ({String header, String body}) item,
  ) {
    const bottomPadding = 16.0;
    return TableRow(
      children: [
        Padding(
          padding: const .fromLTRB(8, 4, 16, bottomPadding),
          child: Text(
            "${item.header}:",
            textAlign: .right,
            style: context.textTheme.displaySmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
        Padding(
          padding: const .fromLTRB(8, 4, 32, bottomPadding),
          child: Text(item.body, style: context.textTheme.displaySmall),
        ),
      ],
    );
  }
}

// class LabeledList extends StatelessWidget {
//   final List<({String header, String body})> items;
//   const LabeledList({super.key, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: .start,
//       children: [for (final item in items) LabelItem(item: item)],
//     );
//   }
// }

// class LabelItem extends StatelessWidget {
//   final ({String header, String body}) item;
//   const LabelItem({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const .fromLTRB(8.0, 0, 32.0, 16.0),
//       child: Row(
//         crossAxisAlignment: .start,
//         children: [
//           Text(
//             item.header,
//             style: context.textTheme.displayMedium?.copyWith(
//               color: context.colorScheme.primary,
//             ),
//           ),
//           Expanded(
//             child: Text(item.body, style: context.textTheme.displayMedium),
//           ),
//         ],
//       ),
//     );
//   }
// }
