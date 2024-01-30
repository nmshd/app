import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class StreetAddressAttributeRenderer extends StatelessWidget {
  final StreetAddressAttributeValue value;
  final ValueHints valueHints;
  final Future<void> Function(String valueType)? onUpdateAttribute;

  const StreetAddressAttributeRenderer({
    super.key,
    required this.value,
    required this.valueHints,
    this.onUpdateAttribute,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TranslatedText('i18n://attributes.values.${value.atType}._title',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF42474E),
                )),
            TranslatedText(
              value.recipient,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                TranslatedText(
                  value.street,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                TranslatedText(
                  value.houseNumber,
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            Row(
              children: [
                TranslatedText(
                  value.zipCode,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                TranslatedText(
                  value.city,
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            TranslatedText(
              valueHints.propertyHints!['country']!.getTranslation(value.country),
              style: const TextStyle(fontSize: 16),
            )
          ],
        )
      ],
    );
  }
}
