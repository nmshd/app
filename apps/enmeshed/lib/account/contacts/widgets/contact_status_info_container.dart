import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class ContactStatusInfoContainer extends StatelessWidget {
  final IdentityDVO contact;

  const ContactStatusInfoContainer({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    if (!_shouldRenderStatusInfo()) return const SizedBox.shrink();

    final textStyle = Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              switch (contact.relationship?.peerDeletionStatus) {
                (PeerDeletionStatus.ToBeDeleted) => Icon(Icons.warning_rounded, color: context.customColors.warning),
                (PeerDeletionStatus.Deleted) => Icon(Icons.cancel, color: Theme.of(context).colorScheme.error),
                _ => Icon(Icons.error, color: Theme.of(context).colorScheme.error),
              },
              Gaps.w8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_getInfoTitle(context) != null) ...[
                      Text(_getInfoTitle(context)!),
                      Gaps.h8,
                    ],
                    Text(
                      contact.relationship?.status == RelationshipStatus.Terminated
                          ? context.l10n.contactDetail_terminatedDescription1
                          : context.l10n.contactDetail_description1,
                      style: textStyle,
                    ),
                    Gaps.h8,
                    Text(context.l10n.contactDetail_description2, style: textStyle),
                    Gaps.h8,
                    Text(context.l10n.contactDetail_description3, style: textStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldRenderStatusInfo() {
    return contact.relationship?.peerDeletionStatus == PeerDeletionStatus.ToBeDeleted ||
        contact.relationship?.peerDeletionStatus == PeerDeletionStatus.Deleted ||
        contact.relationship?.status == RelationshipStatus.Terminated ||
        contact.relationship?.status == RelationshipStatus.DeletionProposed;
  }

  String? _getInfoTitle(BuildContext context) {
    if (contact.relationship?.peerDeletionStatus == PeerDeletionStatus.ToBeDeleted && contact.relationship!.peerDeletionDate != null) {
      return context.l10n.contactDetail_toBeDeletedTitle(DateTime.parse(contact.relationship!.peerDeletionDate!).toLocal());
    }

    if (contact.relationship?.peerDeletionStatus == PeerDeletionStatus.Deleted) {
      return context.l10n.contactDetail_deletedTitle;
    }

    if (contact.relationship?.status == RelationshipStatus.Terminated || contact.relationship?.status == RelationshipStatus.DeletionProposed) {
      return context.l10n.contactDetail_terminatedTitle;
    }

    return null;
  }
}
