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
  final Color? tileColor;

  const ContactItem({
    required this.contact,
    required this.onTap,
    this.trailing,
    this.subtitle,
    this.query,
    this.iconSize = 56,
    this.tileColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ContactCircleAvatar(contact: contact, radius: iconSize / 2),
      title: HighlightText(query: query, text: contact.isUnknown ? context.l10n.contacts_unknown : contact.name),
      subtitle: subtitle ??
          switch (contact.relationship?.status) {
            RelationshipStatus.Pending => Text(
                context.l10n.contacts_pending,
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            RelationshipStatus.Terminated => Text(
                context.l10n.contacts_terminated,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            RelationshipStatus.DeletionProposed => Text(
                context.l10n.contacts_deletionProposed,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            null => Text(
                context.l10n.contacts_notYetRequested,
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            _ => null,
          },
      trailing: trailing,
      onTap: onTap,
    );
  }
}
