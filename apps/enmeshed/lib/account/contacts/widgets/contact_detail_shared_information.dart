import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/utils/utils.dart';

class ContactDetailSharedInformation extends StatelessWidget {
  final String accountId;
  final String contactId;

  const ContactDetailSharedInformation({required this.accountId, required this.contactId, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(context.l10n.contactDetail_sharedInformation, style: Theme.of(context).textTheme.titleLarge),
        ),
        Column(
          children: [
            ListTile(
              title: Text(context.l10n.contactDetail_receivedAttributes),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/account/$accountId/contacts/$contactId/exchangedData'),
            ),
            const Divider(height: 2, indent: 16),
            ListTile(
              title: Text(context.l10n.contactDetail_sharedAttributes),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/account/$accountId/contacts/$contactId/exchangedData?showSharedAttributes=true'),
            ),
          ],
        ),
      ],
    );
  }
}
