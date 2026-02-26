import 'package:flutter/material.dart';
import 'package:presentation/util/context_extensions.dart';

class AlertText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const AlertText({
    super.key,
    required this.text,
    this.style = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(fontSize: 80, color: context.colorScheme.error),
      textAlign: .center,
    );
  }
}

class QuestionText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const QuestionText({
    super.key,
    required this.text,
    this.style = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(fontSize: 40, color: context.colorScheme.primary),
      textAlign: .center,
    );
  }
}
