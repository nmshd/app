import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? description;
  final String? thirdLine;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? trailing;
  final double? trailingWidth;

  const CustomListTile({
    super.key,
    required this.title,
    this.description,
    this.thirdLine,
    this.showTitle = true,
    this.valueTextStyle = const TextStyle(fontSize: 16),
    this.trailing,
    this.trailingWidth = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showTitle) TranslatedText(title, style: const TextStyle(fontSize: 12, color: Color(0xFF42474E))),
              if (description != null) ...[
                const SizedBox(height: 2),
                TranslatedText(description!, style: valueTextStyle),
              ],
              if (thirdLine != null) ...[
                const SizedBox(height: 2),
                TranslatedText(thirdLine!, style: valueTextStyle),
              ]
            ],
          ),
        ),
        if (trailing != null) SizedBox(width: trailingWidth, child: trailing),
      ],
    );
  }
}
