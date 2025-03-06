import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
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
  final LocalRequestDVO? openContactRequest;

  const ContactItem({
    required this.contact,
    required this.onTap,
    this.trailing,
    this.subtitle,
    this.query,
    this.iconSize = 56,
    this.openContactRequest,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contactStatusWidget =
        (ContactStatusText.canRenderStatusText(contact: contact)
            ? ContactStatusText(contact: contact, style: Theme.of(context).textTheme.labelMedium)
            : null);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ContactCircleAvatar(
        contact: contact,
        radius: iconSize / 2,
        borderColor: _getCircularAvatarBorderColor(context: context, contact: contact, openContactRequest: openContactRequest),
      ),
      title: HighlightText(query: query, text: contact.isUnknown ? context.l10n.contacts_unknown : contact.name),
      subtitle: subtitle ?? contactStatusWidget,
      trailing: trailing,
      onTap: onTap,
    );
  }

  Color? _getCircularAvatarBorderColor({required BuildContext context, required IdentityDVO contact, LocalRequestDVO? openContactRequest}) {
    if (openContactRequest != null ||
        contact.relationship?.peerDeletionStatus == PeerDeletionStatus.Deleted ||
        contact.relationship?.status == RelationshipStatus.Terminated ||
        contact.relationship?.status == RelationshipStatus.DeletionProposed) {
      return Theme.of(context).colorScheme.error;
    }

    if (contact.relationship?.peerDeletionStatus == PeerDeletionStatus.ToBeDeleted) return context.customColors.warning;

    if (contact.relationship?.status == RelationshipStatus.Pending) return Theme.of(context).colorScheme.secondary;

    return null;
  }
}
