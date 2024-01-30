import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class ComplexAttributeListTile extends StatelessWidget {
  final String title;
  final List<({String label, String value})> fields;
  final ValueHints? valueHints;
  final Widget? trailing;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final String? valueType;

  const ComplexAttributeListTile({
    super.key,
    required this.title,
    required this.fields,
    this.valueHints,
    this.trailing,
    this.onUpdateAttribute,
    this.valueType,
  });

  @override
  Widget build(BuildContext context) {
    const titlesTextStyle = TextStyle(fontSize: 12, color: Color(0xFF42474E));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(title, style: const TextStyle(fontSize: 16, color: Color(0xFF42474E))),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: fields.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final field = fields[index];

                  final label = field.label;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TranslatedText(label, style: titlesTextStyle),
                      const SizedBox(height: 2),
                      TranslatedText(_getValueHintsTranslation(field.value, valueHints!.propertyHints!.values.elementAt(index)),
                          style: const TextStyle(fontSize: 16)),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: trailing ??
                  IconButton(
                    onPressed: onUpdateAttribute != null && valueType != null ? () => onUpdateAttribute!(valueType!) : null,
                    icon: const Icon(Icons.chevron_right),
                  ),
            ),
          ],
        ),
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
