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
  final bool enabled;
  final Widget? trailing;
  final Widget? subtitle;
  final String? query;
  final int iconSize;
  final LocalRequestDVO? openContactRequest;

  const ContactItem({
    required this.contact,
    required this.onTap,
    this.enabled = true,
    this.trailing,
    this.subtitle,
    this.query,
    this.iconSize = 56,
    this.openContactRequest,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contactStatusWidget = (ContactStatusText.canRenderStatusText(contact: contact, openContactRequest: openContactRequest)
        ? ContactStatusText(contact: contact, style: Theme.of(context).textTheme.labelMedium, openContactRequest: openContactRequest)
        : null);

    return ListTile(
      enabled: enabled,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).copyWith(right: trailing != null ? 4 : null),
      leading: ContactCircleAvatar(
        contact: contact,
        radius: iconSize / 2,
        borderColor: _getCircularAvatarBorderColor(context: context, contact: contact, openContactRequest: openContactRequest),
        disabled: !enabled,
      ),
      title: HighlightText(query: query, text: contact.isUnknown ? context.l10n.contacts_unknown : contact.name, maxLines: 2),
      subtitle: subtitle ?? contactStatusWidget,
      trailing: trailing,
      onTap: onTap,
    );
  }

  Color _getCircularAvatarBorderColor({required BuildContext context, required IdentityDVO contact, LocalRequestDVO? openContactRequest}) {
    if (contact.relationship?.status == RelationshipStatus.Pending || (openContactRequest?.peer.hasRelationship ?? false)) {
      return Theme.of(context).colorScheme.secondary;
    }

    if (openContactRequest != null ||
        contact.relationship?.peerDeletionStatus == PeerDeletionStatus.Deleted ||
        contact.relationship?.status == RelationshipStatus.Terminated ||
        contact.relationship?.status == RelationshipStatus.DeletionProposed) {
      return Theme.of(context).colorScheme.error;
    }

    if (contact.relationship?.peerDeletionStatus == PeerDeletionStatus.ToBeDeleted) return context.customColors.warning;

    return Colors.transparent;
  }
}
