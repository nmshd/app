import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../value_hint_translation.dart';

class DeliveryBoxAddressAttributeRenderer extends StatelessWidget {
  final DeliveryBoxAddressAttributeValue value;
  final ValueHints valueHints;
  final Widget? trailing;

  const DeliveryBoxAddressAttributeRenderer({super.key, required this.value, required this.valueHints, this.trailing});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TranslatedText(
                  'i18n://attributes.values.${value.atType}._title',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF42474E),
                  ),
                ),
                TranslatedText(
                  value.recipient,
                  style: textStyle,
                ),
                TranslatedText(
                  value.deliveryBoxId,
                  style: textStyle,
                ),
                Row(
                  children: [
                    TranslatedText(
                      value.zipCode,
                      style: textStyle,
                    ),
                    const SizedBox(width: 4),
                    TranslatedText(
                      value.city,
                      style: textStyle,
                    )
                  ],
                ),
                TranslatedText(
                  valueHints.propertyHints!['country']!.getTranslation(value.country),
                  style: textStyle,
                ),
                TranslatedText(
                  valueHints.propertyHints!['state']!.getTranslation(value.state),
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
        if (trailing != null) SizedBox(width: 50, child: trailing)
      ],
    );
  }
}
