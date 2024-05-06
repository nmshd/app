import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '/core/core.dart';

class ContactRequestItem extends StatelessWidget {
  final String accountId;
  final LocalRequestDVO request;

  const ContactRequestItem({required this.accountId, required this.request, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: Theme.of(context).colorScheme.outline, width: 0.5),
        ),
        elevation: 1,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          tileColor: Theme.of(context).colorScheme.onPrimary,
          leading: ContactCircleAvatar(contactName: request.peer.initials, radius: 28),
          title: Text(request.peer.name, style: Theme.of(context).textTheme.bodyLarge, overflow: TextOverflow.ellipsis),
          trailing: Text(
            timeago.format(DateTime.parse(request.createdAt), locale: Localizations.localeOf(context).languageCode),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          onTap: () => context.go('/account/$accountId/contacts/contact-request/${request.id}', extra: request),
        ),
      ),
    );
  }
}
