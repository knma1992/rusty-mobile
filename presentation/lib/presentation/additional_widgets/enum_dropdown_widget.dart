import 'package:flutter/material.dart';

class EnumDropdownMenu<T extends Enum> extends StatelessWidget {
  final double dropdownElementWidth;
  final bool uiEnabled;
  final List<T> enums;
  final T? initialSelection;
  final void Function(T) onSelected;

  const EnumDropdownMenu({
    super.key,
    required this.dropdownElementWidth,
    required this.onSelected,
    required this.enums,
    this.uiEnabled = true,
    this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dropdownElementWidth,
      child: Center(
        child: DropdownMenu(
          initialSelection: initialSelection,
          enabled: uiEnabled,
          width: dropdownElementWidth,
          label: const Text("Style", style: TextStyle(fontSize: 16)),
          dropdownMenuEntries: <DropdownMenuEntry<T>>[
            for (var value in enums)
              DropdownMenuEntry(
                value: value,
                label: value.name,
                enabled: uiEnabled,
              ),
          ],
          onSelected: (value) {
            if (value != null) {
              onSelected(value);
            }
          },
        ),
      ),
    );
  }
}
