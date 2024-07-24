import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class ContactItem extends StatelessWidget {
  final IdentityDVO contact;
  final void Function() onTap;
  final Widget? trailing;
  final Widget? subtitle;
  final String? query;
  final int iconSize;

  const ContactItem({
    required this.contact,
    required this.onTap,
    this.trailing,
    this.subtitle,
    this.query,
    this.iconSize = 56,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: ListTile(
        enabled: contact.relationship?.status == RelationshipStatus.Active,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        tileColor: Theme.of(context).colorScheme.onPrimary,
        leading: contact.relationship?.status == RelationshipStatus.Active
            ? ContactCircleAvatar(contactName: contact.name, radius: iconSize / 2)
            : Icon(Icons.pending_outlined, size: iconSize.toDouble(), color: Theme.of(context).colorScheme.outline),
        title: HighlightText(query: query, text: contact.name),
        subtitle: subtitle ?? (contact.relationship?.status == RelationshipStatus.Active ? null : Text(context.l10n.contacts_pending)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
