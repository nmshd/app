import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
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
            _ContactFavoriteIcon(contact: contact),
            SizedBox(
              width: 72,
              child: Text(
                contact.isUnknown ? context.l10n.contacts_unknown : contact.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: _getColor(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? _getColor(BuildContext context) => switch ((contact.relationship?.peerDeletionStatus, contact.relationship?.status)) {
        (PeerDeletionStatus.ToBeDeleted, _) => context.customColors.warning,
        (PeerDeletionStatus.Deleted, _) => Theme.of(context).colorScheme.error,
        (_, RelationshipStatus.Pending) => Theme.of(context).colorScheme.secondary,
        (_, RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed) => Theme.of(context).colorScheme.error,
        _ => null,
      };
}

class _ContactFavoriteIcon extends StatelessWidget {
  final IdentityDVO contact;

  const _ContactFavoriteIcon({required this.contact});

  @override
  Widget build(BuildContext context) {
    final iconSize = IconTheme.of(context).size ?? kDefaultFontSize;
    final widget = switch ((contact.relationship?.peerDeletionStatus, contact.relationship?.status)) {
      (null, null) => null,
      (PeerDeletionStatus.ToBeDeleted, _) => Icon(Icons.warning_rounded, color: context.customColors.warning, size: iconSize),
      (PeerDeletionStatus.Deleted, _) => Icon(Icons.cancel, color: Theme.of(context).colorScheme.error, size: iconSize),
      (_, RelationshipStatus.Pending) => Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: iconSize),
      (_, RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed) => Icon(
          Icons.error,
          color: Theme.of(context).colorScheme.error,
          size: iconSize,
        ),
      (_, _) => null,
    };

    final circleAvatar = ContactCircleAvatar(contact: contact, radius: 36);
    if (widget == null) return circleAvatar;

    return Stack(
      children: [
        circleAvatar,
        Positioned(
          bottom: 0,
          left: iconSize * 0.375,
          child: Container(
            width: iconSize * 0.25,
            height: iconSize * 0.75,
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onInverseSurface, borderRadius: BorderRadius.circular(4)),
          ),
        ),
        Positioned(bottom: 0, child: widget),
      ],
    );
  }
}
