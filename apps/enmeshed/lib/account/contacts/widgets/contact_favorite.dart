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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => ContactCircleAvatar(contact: contact, radius: constraints.biggest.height / 2),
              ),
            ),
            if (!contact.isUnknown) SizedBox(width: 72, child: Text(contact.name, overflow: TextOverflow.ellipsis, maxLines: 1)),
          ],
        ),
      ),
    );
  }
}
