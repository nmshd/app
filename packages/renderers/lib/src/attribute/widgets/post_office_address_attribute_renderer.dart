import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

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
              _getValueHintsTranslation(value.country, valueHints.propertyHints!['country']!),
              style: const TextStyle(fontSize: 16),
            ),
            TranslatedText(
              _getValueHintsTranslation(value.state, valueHints.propertyHints!['state']!),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }

  String _getValueHintsTranslation(value, ValueHints valueHints) {
    if (valueHints.values == null) {
      return value;
    } else {
      try {
        final valueHint = valueHints.values!.firstWhere((valueHint) => valueHint.key.toJson() == value);
        return valueHint.displayName;
      } on StateError {
        // no matching valueHint found
        return value;
      }
    }
  }
}
