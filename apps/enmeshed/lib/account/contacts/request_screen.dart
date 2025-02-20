import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class RequestScreen extends StatefulWidget {
  final String accountId;
  final String requestId;
  final bool isIncoming;

  final LocalRequestDVO? requestDVO;

  const RequestScreen({required this.accountId, required this.requestId, required this.isIncoming, super.key, this.requestDVO});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool _canAcceptRequest = false;

  @override
  void initState() {
    super.initState();

    _canAccept();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(context.l10n.contact_request)),
      body: SafeArea(
        child: RequestDVORenderer(
          accountId: widget.accountId,
          requestId: widget.requestId,
          isIncoming: widget.isIncoming,
          requestDVO: widget.requestDVO,
          acceptRequestText: context.l10n.home_addContact,
          validationErrorDescription: context.l10n.contact_request_validationErrorDescription,
          canAcceptRequest: _canAcceptRequest,
          onAfterAccept: () {
            if (context.mounted) context.go('/account/${widget.accountId}/contacts');
          },
          description: context.l10n.contact_requestDescription,
        ),
      ),
    );
  }

  Future<void> _canAccept() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final canAcceptRequestResponse = await canAcceptRelationshipRequest(
      accountId: widget.accountId,
      requestCreatedBy: widget.requestDVO!.createdBy.id,
      session: session,
    );

    setState(() => _canAcceptRequest = canAcceptRequestResponse.canAccept);

    if (canAcceptRequestResponse.canAccept) return;

    if (!mounted) return;

    await context.push('/error-dialog', extra: canAcceptRequestResponse.error);
  }
}
