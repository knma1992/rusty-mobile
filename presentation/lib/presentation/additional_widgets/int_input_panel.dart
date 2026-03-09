import 'package:flutter/material.dart';

class NumberInputPanel extends StatefulWidget {
  final int initialValue;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const NumberInputPanel({
    super.key,
    this.initialValue = 4,
    this.min = 2,
    this.max = 64,
    required this.onChanged,
  });

  @override
  State<NumberInputPanel> createState() => _NumberInputPanelState();
}

class _NumberInputPanelState extends State<NumberInputPanel> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(widget.min, widget.max);
  }

  void add() {
    final temp = _value + 1;
    final clamped = temp.clamp(widget.min, widget.max);
    if (clamped == _value) return;
    setState(() => _value = clamped);
    widget.onChanged(_value);
  }

  void remove() {
    final temp = _value - 1;
    final clamped = temp.clamp(widget.min, widget.max);
    if (clamped == _value) return;
    setState(() => _value = clamped);
    widget.onChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$_value"),
        IconButton(onPressed: () => add(), icon: const Icon(Icons.add)),
        IconButton(onPressed: () => remove(), icon: const Icon(Icons.remove)),
      ],
    );
  }
}
