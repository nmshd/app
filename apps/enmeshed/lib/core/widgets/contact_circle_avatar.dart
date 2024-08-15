import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../utils/extensions.dart';

class ContactCircleAvatar extends StatelessWidget {
  final IdentityDVO contact;
  final double radius;
  final Color? color;

  const ContactCircleAvatar({required this.contact, required this.radius, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.customColors.decorativeContainer;
    if (contact.isUnknown) return _UnknownContactAvatar(radius: radius, color: color);

    final initials = _contactNameLetters(contact.name);

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

class _UnknownContactAvatar extends StatelessWidget {
  final double radius;
  final Color? color;

  const _UnknownContactAvatar({required this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.customColors.decorativeContainer;

    return ClipOval(
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: const VectorGraphic(loader: AssetBytesLoader('assets/svg/unknown_contact.svg')),
      ),
    );
  }
}
