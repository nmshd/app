import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? description;
  final String? thirdLine;
  final String? extraLine;
  final TextStyle? extraLineTextStyle;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? trailing;

  const CustomListTile({
    super.key,
    required this.title,
    this.description,
    this.thirdLine,
    this.extraLine,
    this.extraLineTextStyle,
    this.showTitle = true,
    this.valueTextStyle = const TextStyle(fontSize: 16),
    this.trailing,
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
              if (showTitle) TranslatedText(title, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
              if (description != null) ...[
                const SizedBox(height: 2),
                TranslatedText(description!, style: valueTextStyle),
              ],
              if (thirdLine != null) ...[
                const SizedBox(height: 2),
                TranslatedText(thirdLine!, style: valueTextStyle),
              ],
              if (extraLine != null) ...[
                const SizedBox(height: 2),
                TranslatedText(extraLine!, style: extraLineTextStyle),
              ]
            ],
          ),
        ),
        if (trailing != null) trailing!
      ],
    );
  }
}
