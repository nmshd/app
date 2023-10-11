import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const CustomListTile({super.key, required this.title, required this.subTitle, this.trailing, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: TranslatedText(title, style: const TextStyle(fontSize: 12, color: Color(0xFF42474E))),
          subtitle: Text(subTitle, style: const TextStyle(fontSize: 16)),
          trailing: trailing ?? IconButton(onPressed: onPressed, icon: const Icon(Icons.info)),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
