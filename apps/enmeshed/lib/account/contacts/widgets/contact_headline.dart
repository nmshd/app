import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class ContactHeadline extends StatelessWidget {
  final IdentityDVO? contact;
  final Icon? icon;

  const ContactHeadline({super.key, this.contact, this.icon});

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
            contact?.initials[0].toUpperCase() ?? context.l10n.favorites,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
