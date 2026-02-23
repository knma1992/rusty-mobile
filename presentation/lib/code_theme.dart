import 'package:flutter/material.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/blocks/leaf/code_block.dart';

final markDownConfig = MarkdownConfig.darkConfig.copy(
  configs: [
    PreConfig.darkConfig.copy(
      theme: zedOneDarkTheme,
      decoration: BoxDecoration(
        color: Color(0xff1e1e1e),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  ],
);

const zedOneDarkTheme = {
  'root': TextStyle(
    backgroundColor: Color(0x1e1e1eff),
    color: Color(0xFFABB2BF),
  ),
  'keyword': TextStyle(color: Color(0xFFC678DD)),
  'built_in': TextStyle(color: Color(0xFFE5C07B)),
  'type': TextStyle(color: Color(0xFFE5C07B)),
  'literal': TextStyle(color: Color(0xFFD19A66)),
  'number': TextStyle(color: Color(0xFFD19A66)),
  'string': TextStyle(color: Color(0xFF98C379)),
  'comment': TextStyle(color: Color(0xFF5C6370), fontStyle: FontStyle.italic),
  'function': TextStyle(color: Color(0xFF61AFEF)),
  'class': TextStyle(color: Color(0xFFE5C07B)),
  'attr': TextStyle(color: Color(0xFFD19A66)),
  'params': TextStyle(color: Color(0xFFABB2BF)),
  'punctuation': TextStyle(color: Color(0xFFABB2BF)),
  'meta': TextStyle(color: Color(0xFF61AFEF)),
  'title': TextStyle(color: Color(0xFF61AFEF)),
  'section': TextStyle(color: Color(0xFFE06C75)),
  'addition': TextStyle(color: Color(0xFF98C379)),
  'deletion': TextStyle(color: Color(0xFFE06C75)),
  'selector-class': TextStyle(color: Color(0xFFE5C07B)),
  'selector-id': TextStyle(color: Color(0xFF61AFEF)),
  'subst': TextStyle(color: Color(0xFFE06C75)),
  'symbol': TextStyle(color: Color(0xFF56B6C2)),
};
