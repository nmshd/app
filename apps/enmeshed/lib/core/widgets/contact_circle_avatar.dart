import 'package:flutter/material.dart';

import '/core/utils/extensions.dart';

class ContactCircleAvatar extends StatelessWidget {
  final String contactName;
  final double radius;
  final Color? color;

  const ContactCircleAvatar({required this.contactName, required this.radius, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final initials = _contactNameLetters(contactName);
    final color = this.color ?? context.customColors.decorativeContainer;

    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        initials,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: radius * 0.75, color: context.customColors.onDecorativeContainer),
      ),
    );
  }

  String _contactNameLetters(String contactName) {
    if (contactName.length <= 2) return contactName;

    final splitted = contactName.split(RegExp('[ -]+')).where((e) => e.isNotEmpty).toList();
    if (splitted.length > 1) {
      return splitted[0].substring(0, 1) + splitted[1].substring(0, 1);
    }

    return contactName.substring(0, 2);
  }
}
