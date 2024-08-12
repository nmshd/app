import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'contact_circle_avatar.dart';
import 'highlight_text.dart';

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
    return ListTile(
      enabled: contact.relationship?.status == RelationshipStatus.Active,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: switch (contact.relationship?.status) {
        RelationshipStatus.Pending => Icon(Icons.pending_outlined, size: iconSize.toDouble(), color: Theme.of(context).colorScheme.outline),
        _ => ContactCircleAvatar(contactName: contact.name, radius: iconSize / 2)
      },
      title: HighlightText(query: query, text: contact.name),
      subtitle: subtitle ??
          switch (contact.relationship?.status) {
            RelationshipStatus.Pending => Text(context.l10n.contacts_pending),
            RelationshipStatus.Terminated => Text(context.l10n.contacts_terminated),
            RelationshipStatus.DeletionProposed => Text(context.l10n.contacts_deletionProposed),
            _ => null,
          },
      trailing: trailing,
      onTap: onTap,
    );
  }
}
