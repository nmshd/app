import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../value_hint_translation.dart';

class DeliveryBoxAddressAttributeRenderer extends StatelessWidget {
  final DeliveryBoxAddressAttributeValue value;
  final ValueHints valueHints;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? extraLine;
  final Widget? trailing;

  const DeliveryBoxAddressAttributeRenderer({
    super.key,
    required this.value,
    required this.valueHints,
    required this.showTitle,
    required this.valueTextStyle,
    this.extraLine,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showTitle)
                TranslatedText(
                  'i18n://attributes.values.${value.atType}._title',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              TranslatedText(value.recipient, style: valueTextStyle),
              TranslatedText(value.deliveryBoxId, style: valueTextStyle),
              Row(
                children: [
                  TranslatedText(value.zipCode, style: valueTextStyle),
                  const SizedBox(width: 4),
                  TranslatedText(value.city, style: valueTextStyle),
                ],
              ),
              TranslatedText(valueHints.propertyHints!['country']!.getTranslation(value.country), style: valueTextStyle),
              if (value.state != null) TranslatedText(valueHints.propertyHints!['state']!.getTranslation(value.state), style: valueTextStyle),
              if (extraLine != null) ...[
                const SizedBox(height: 2),
                extraLine!,
              ],
            ],
          ),
        ),
        if (trailing != null)
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: trailing!,
          )
      ],
    );
  }
}
