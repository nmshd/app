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
        child: RequestDVORenderer(
          accountId: accountId,
          requestId: requestId,
          isIncoming: isIncoming,
          requestDVO: requestDVO,
          acceptRequestText: context.l10n.home_addContact,
          validationErrorDescription: context.l10n.contact_request_validationErrorDescription,
          checkCanCreateRelationship: true,
          onAfterAccept: () {
            if (context.mounted) context.go('/account/$accountId/contacts');
          },
          description: context.l10n.contact_requestDescription,
        ),
      ),
    );
  }
}
