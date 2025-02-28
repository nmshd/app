import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class ContactStatusText extends StatelessWidget {
  final IdentityDVO contact;
  final LocalRequestDVO? openContactRequest;
  final TextStyle? style;

  const ContactStatusText({required this.contact, this.openContactRequest, this.style, super.key});

  static bool canRenderStatusText({required IdentityDVO contact, LocalRequestDVO? openContactRequest}) {
    final hasOpenContactRequestInCorrectStatus =
        openContactRequest != null && //
        [LocalRequestStatus.ManualDecisionRequired, LocalRequestStatus.Expired].contains(openContactRequest.status);

    final hasPeerDeletionStatus = contact.relationship?.peerDeletionStatus != null;

    final hasRelationshipInCorrectStatus = [
      RelationshipStatus.Pending,
      RelationshipStatus.Terminated,
      RelationshipStatus.DeletionProposed,
      null,
    ].contains(contact.relationship?.status);

    return hasOpenContactRequestInCorrectStatus || hasPeerDeletionStatus || hasRelationshipInCorrectStatus;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? Theme.of(context).textTheme.bodyMedium;

    if (openContactRequest != null) {
      final status = openContactRequest!.status;
      if (status == LocalRequestStatus.ManualDecisionRequired) {
        return Text(context.l10n.contacts_notYetRequested, style: textStyle?.copyWith(color: Theme.of(context).colorScheme.secondary));
      }

      if (status == LocalRequestStatus.Expired) {
        return Text(context.l10n.contacts_requestExpired, style: textStyle?.copyWith(color: Theme.of(context).colorScheme.error));
      }
    }

    if (contact.relationship?.peerDeletionStatus != null) {
      final status = contact.relationship!.peerDeletionStatus!;
      return switch (status) {
        PeerDeletionStatus.ToBeDeleted => Text(context.l10n.contacts_toBeDeleted, style: textStyle?.copyWith(color: context.customColors.warning)),
        PeerDeletionStatus.Deleted => Text(context.l10n.contacts_deleted, style: textStyle?.copyWith(color: Theme.of(context).colorScheme.error)),
      };
    }

    return switch (contact.relationship?.status) {
      RelationshipStatus.Pending => Text(context.l10n.contacts_pending, style: textStyle?.copyWith(color: Theme.of(context).colorScheme.secondary)),
      RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed => Text(
        context.l10n.contacts_terminatedOrDeletionProposed,
        style: textStyle?.copyWith(color: Theme.of(context).colorScheme.error),
      ),
      null => Text(context.l10n.contacts_notYetRequested, style: textStyle?.copyWith(color: Theme.of(context).colorScheme.secondary)),
      _ => const SizedBox.shrink(),
    };
  }
}
