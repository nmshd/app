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

    final templatesResult = await session.transportServices.relationshipTemplates.getRelationshipTemplates();

    if (templatesResult.isSuccess) {
      final template = templatesResult.value.firstWhere((template) => template.createdBy == widget.requestDVO!.createdBy.id);

      final canCreate = await session.transportServices.relationships.canCreateRelationship(templateId: template.id);
      print('canCreate: ${canCreate.value.isSuccess}');

      final contact = await session.expander.expandAddress(template.createdBy);

      final status = contact.relationship?.peerDeletionStatus;

      final relationshipStatus = contact.relationship?.status;

    }
  }
}
