import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

class BoldStyledText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BoldStyledText(this.text, {this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text,
      style: style,
      tags: {
        'bold': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
      },
    );
  }
}
