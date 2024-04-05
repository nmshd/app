import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import 'value_hint_translation.dart';

class ComplexAttributeListTile extends StatelessWidget {
  final String title;
  final List<({String label, String key, String value})> fields;
  final ValueHints valueHints;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? trailing;

  const ComplexAttributeListTile({
    super.key,
    required this.title,
    required this.fields,
    required this.valueHints,
    required this.showTitle,
    required this.valueTextStyle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final titlesTextStyle = TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          TranslatedText(title, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 8),
        ],
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

                  final propertyHints = valueHints.propertyHints![field.key]!;
                  final translation = propertyHints.getTranslation(field.value);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TranslatedText(field.label, style: titlesTextStyle),
                      const SizedBox(height: 2),
                      TranslatedText(translation, style: valueTextStyle),
                    ],
                  );
                },
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ],
    );
  }
}
