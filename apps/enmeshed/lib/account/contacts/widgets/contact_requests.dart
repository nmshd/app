import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import 'contact_request_item.dart';

class ContactRequests extends StatelessWidget {
  final String accountId;
  final List<LocalRequestDVO> requests;
  final Future<void> Function() onRefresh;

  const ContactRequests({
    required this.accountId,
    required this.requests,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: (requests.isEmpty)
            ? EmptyListIndicator(icon: Icons.contacts, text: context.l10n.requests_empty, wrapInListView: true)
            : ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) => ContactRequestItem(accountId: accountId, request: requests[index]),
              ),
      ),
    );
  }
}
