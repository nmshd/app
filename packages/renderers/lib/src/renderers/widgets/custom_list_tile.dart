import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

typedef CheckboxSettings = ({bool isChecked, Function(bool?)? onUpdateCheckbox});

class CustomListTile extends StatelessWidget {
  final String title;
  final String? description;
  final String? thirdLine;
  final Widget? trailing;
  final CheckboxSettings? checkboxSettings;

  const CustomListTile({
    super.key,
    required this.title,
    this.description,
    this.thirdLine,
    this.trailing,
    this.checkboxSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TranslatedText(title, style: const TextStyle(fontSize: 12, color: Color(0xFF42474E))),
                if (description != null) ...[
                  const SizedBox(height: 2),
                  TranslatedText(description!, style: const TextStyle(fontSize: 16)),
                ],
                if (thirdLine != null) ...[
                  const SizedBox(height: 2),
                  TranslatedText(thirdLine!, style: const TextStyle(fontSize: 16)),
                ]
              ],
            ),
          ),
        ),
        if (trailing != null) SizedBox(width: 50, child: trailing),
      ],
    );
  }
}
