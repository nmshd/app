import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? description;
  final String? thirdLine;
  final Widget? extraLine;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? trailing;
  final String Function(String)? titleOverride;

  const CustomListTile({
    super.key,
    required this.title,
    this.description,
    this.thirdLine,
    this.extraLine,
    this.showTitle = true,
    this.valueTextStyle = const TextStyle(fontSize: 16),
    this.trailing,
    this.titleOverride,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title.startsWith('i18n://') ? FlutterI18n.translate(context, this.title.substring(7)) : this.title;

    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              if (showTitle)
                Text(
                  titleOverride != null ? titleOverride!(title) : title,
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              if (description != null) TranslatedText(description!, style: valueTextStyle),
              if (thirdLine != null) TranslatedText(thirdLine!, style: valueTextStyle),
              ?extraLine,
            ],
          ),
        ),
        if (trailing != null) trailing!,
        if (trailing == null) const SizedBox(width: 16),
      ],
    );
  }
}
