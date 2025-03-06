import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/core.dart';

class ContactDetailHeader extends StatelessWidget {
  final IdentityDVO contact;

  const ContactDetailHeader({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ContactCircleAvatar(
            contact: contact,
            radius: 36,
            color: contact.relationship?.status == RelationshipStatus.Pending ? Theme.of(context).colorScheme.surfaceContainerLow : null,
            child:
                contact.relationship?.status == RelationshipStatus.Pending
                    ? Icon(Icons.hourglass_top, color: Theme.of(context).colorScheme.onPrimaryFixedVariant, size: 43.2)
                    : null,
          ),
          Gaps.w16,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.isUnknown ? context.l10n.contacts_unknown : contact.name, style: Theme.of(context).textTheme.titleMedium),
                if (contact.date != null && contact.relationship?.status != RelationshipStatus.Pending)
                  Text(
                    context.l10n.contactDetail_connectedSince(
                      DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(DateTime.parse(contact.date!).toLocal()),
                    ),
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ContactStatusText(contact: contact),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
