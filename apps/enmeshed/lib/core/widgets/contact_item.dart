import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'contact_circle_avatar.dart';
import 'contact_status_text.dart';
import 'highlight_text.dart';

class ContactItem extends StatelessWidget {
  final IdentityDVO contact;
  final void Function() onTap;
  final Widget? trailing;
  final Widget? subtitle;
  final String? query;
  final int iconSize;
  final Color? borderColor;

  const ContactItem({
    required this.contact,
    required this.onTap,
    this.trailing,
    this.subtitle,
    this.query,
    this.iconSize = 56,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ContactCircleAvatar(contact: contact, radius: iconSize / 2, borderColor: borderColor),
      title: HighlightText(query: query, text: contact.isUnknown ? context.l10n.contacts_unknown : contact.name),
      subtitle:
          subtitle ??
          (ContactStatusText.canRenderStatusText(contact: contact)
              ? ContactStatusText(contact: contact, style: Theme.of(context).textTheme.labelMedium)
              : null),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
