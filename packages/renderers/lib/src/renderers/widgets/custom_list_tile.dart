import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? trailing;
  final void Function()? onPressed;

  const CustomListTile({
    super.key,
    required this.title,
    this.description,
    this.trailing,
    this.onPressed,
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
                TranslatedText(title, style: const TextStyle(fontSize: 12, color: Color(0xFF42474E))),
                if (description != null) ...[
                  const SizedBox(height: 2),
                  Text(description!, style: const TextStyle(fontSize: 16)),
                ]
              ],
            ),
          ),
        ),
        SizedBox(width: 50, child: trailing ?? IconButton(onPressed: onPressed, icon: const Icon(Icons.chevron_right)))
      ],
    );
  }
}
