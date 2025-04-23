import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../value_hint_translation.dart';

class StreetAddressAttributeRenderer extends StatelessWidget {
  final StreetAddressAttributeValue value;
  final ValueHints valueHints;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? extraLine;
  final Widget? trailing;
  final String Function(String)? titleOverride;

  const StreetAddressAttributeRenderer({
    super.key,
    required this.value,
    required this.valueHints,
    required this.showTitle,
    required this.valueTextStyle,
    this.extraLine,
    this.trailing,
    this.titleOverride,
  });

  @override
  Widget build(BuildContext context) {
    final title = FlutterI18n.translate(context, 'attributes.values.${value.atType}._title');
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showTitle)
                Text(
                  titleOverride != null ? titleOverride!(title) : title,
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              TranslatedText(value.recipient, style: valueTextStyle),
              Row(
                spacing: 4,
                children: [TranslatedText(value.street, style: valueTextStyle), TranslatedText(value.houseNumber, style: valueTextStyle)],
              ),
              Row(spacing: 4, children: [TranslatedText(value.zipCode, style: valueTextStyle), TranslatedText(value.city, style: valueTextStyle)]),
              TranslatedText(valueHints.propertyHints!['country']!.getTranslation(value.country), style: valueTextStyle),
              if (extraLine != null) ...[const SizedBox(height: 2), extraLine!],
            ],
          ),
        ),
        if (trailing != null) Padding(padding: EdgeInsets.only(right: 12), child: trailing!),
      ],
    );
  }
}
