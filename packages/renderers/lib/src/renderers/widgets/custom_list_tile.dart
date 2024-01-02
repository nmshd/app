import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? trailing;
  final bool? isChecked;
  final bool? hideCheckbox;
  final Function(bool?)? onUpdateCheckbox;

  const CustomListTile({
    super.key,
    required this.title,
    this.description,
    this.trailing,
    this.isChecked,
    this.hideCheckbox,
    this.onUpdateCheckbox,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hideCheckbox != null && !hideCheckbox!) Checkbox(value: isChecked, onChanged: onUpdateCheckbox),
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
