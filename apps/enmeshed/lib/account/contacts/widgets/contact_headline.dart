import 'package:flutter/material.dart';

class ContactHeadline extends StatelessWidget {
  final String text;
  final Icon? icon;

  const ContactHeadline({required this.text, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40,
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          if (icon != null) Padding(padding: const EdgeInsets.only(right: 8), child: icon),
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
