import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../value_hint_translation.dart';

class StreetAddressAttributeRenderer extends StatelessWidget {
  final StreetAddressAttributeValue value;
  final ValueHints valueHints;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? trailing;

  const StreetAddressAttributeRenderer({
    super.key,
    required this.value,
    required this.valueHints,
    required this.showTitle,
    required this.valueTextStyle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showTitle)
                  TranslatedText(
                    'i18n://attributes.values.${value.atType}._title',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF42474E)),
                  ),
                TranslatedText(value.recipient, style: valueTextStyle),
                Row(
                  children: [
                    TranslatedText(value.street, style: valueTextStyle),
                    const SizedBox(width: 4),
                    TranslatedText(value.houseNumber, style: valueTextStyle)
                  ],
                ),
                Row(
                  children: [
                    TranslatedText(value.zipCode, style: valueTextStyle),
                    const SizedBox(width: 4),
                    TranslatedText(value.city, style: valueTextStyle),
                  ],
                ),
                TranslatedText(valueHints.propertyHints!['country']!.getTranslation(value.country), style: valueTextStyle)
              ],
            ),
          ),
        ),
        if (trailing != null) SizedBox(width: 50, child: trailing)
      ],
    );
  }
}
