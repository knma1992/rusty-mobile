import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class RustCodeBlock extends StatelessWidget {
  final String code;
  const RustCodeBlock({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return SyntaxView(
      code: code, // Code text
      syntax: Syntax.RUST, // Language
      syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
      fontSize: 16.0, // Font size
      withZoom: true, // Enable/Disable zoom icon controls
      withLinesCount: true, // Enable/Disable line number
      expanded: false, // Enable/Disable container expansion
      selectable: true, // Enable/Disable code text selection
    );
  }
}
