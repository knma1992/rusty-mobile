import 'package:flutter/material.dart';
import 'package:presentation/util/context_extensions.dart';

class Headline extends StatelessWidget {
  final String highlight;
  final String rest;

  const Headline({super.key, required this.highlight, required this.rest});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: context.textTheme.displayLarge,
        children: [
          TextSpan(
            text: highlight,
            style: TextStyle(color: context.colorScheme.primary),
          ),
          TextSpan(text: rest),
        ],
      ),
    );
  }
}
