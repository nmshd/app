import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class ContactFavorite extends StatelessWidget {
  final IdentityDVO contact;
  final VoidCallback onTap;

  const ContactFavorite({
    required this.contact,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const iconSize = 72;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ContactCircleAvatar(contactName: contact.name, radius: iconSize / 2),
          SizedBox(
            width: iconSize.toDouble(),
            child: Text(contact.name, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
