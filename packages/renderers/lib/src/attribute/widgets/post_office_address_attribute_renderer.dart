import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../value_hint_translation.dart';

class PostOfficeBoxAddressAttributeRenderer extends StatelessWidget {
  final PostOfficeBoxAddressAttributeValue value;
  final ValueHints valueHints;
  final Future<void> Function(String valueType)? onUpdateAttribute;

  const PostOfficeBoxAddressAttributeRenderer({
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
            TranslatedText(
              value.boxId,
              style: const TextStyle(fontSize: 16),
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
            ),
            TranslatedText(
              valueHints.propertyHints!['state']!.getTranslation(value.state),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }
}
