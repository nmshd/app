import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class RequestScreen extends StatelessWidget {
  final String accountId;
  final String requestId;
  final bool isIncoming;

  final LocalRequestDVO? requestDVO;

  const RequestScreen({required this.accountId, required this.requestId, required this.isIncoming, super.key, this.requestDVO});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(context.l10n.contact_request)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: RequestDVORenderer(
            accountId: accountId,
            requestId: requestId,
            isIncoming: isIncoming,
            requestDVO: requestDVO,
            acceptRequestText: context.l10n.home_addContact,
            onAfterAccept: () {
              if (context.mounted) context.go('/account/$accountId/contacts');
            },
          ),
        ),
      ),
    );
  }
}
