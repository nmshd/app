import 'package:flutter/material.dart';

class ContactHeadline extends StatelessWidget {
  final String text;
  final Icon? icon;

  const ContactHeadline({required this.text, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (icon != null) Padding(padding: const EdgeInsets.only(right: 8), child: icon),
          Text(text, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
