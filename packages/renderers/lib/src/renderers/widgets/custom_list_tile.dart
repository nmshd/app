import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? trailing;

  const CustomListTile({
    super.key,
    required this.title,
    this.description,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TranslatedText(title, style: const TextStyle(fontSize: 12, color: Color(0xFF42474E))),
                if (description != null) ...[
                  const SizedBox(height: 2),
                  Text(description!, style: const TextStyle(fontSize: 16)),
                ]
              ],
            ),
          ),
        ),
        if (trailing != null) SizedBox(width: 96, child: trailing)
      ],
    );
  }
}
