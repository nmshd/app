import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';

class RequestScreen extends StatefulWidget {
  final String accountId;
  final String requestId;
  final bool isIncoming;
  final LocalRequestDVO? requestDVO;

  const RequestScreen({required this.accountId, required this.requestId, required this.isIncoming, this.requestDVO, super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  void initState() {
    super.initState();

    _validateCreateRelationship();
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
          validateCreateRelationship: _validateCreateRelationship,
        ),
      ),
    );
  }

  Future<bool> _validateCreateRelationship() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final validateRelationshipCreationResponse = await validateRelationshipCreation(
      accountId: widget.accountId,
      request: widget.requestDVO,
      session: session,
    );

    if (validateRelationshipCreationResponse.success) return true;

    if (!mounted) return false;

    final result = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => CreateRelationshipErrorDialog(errorCode: validateRelationshipCreationResponse.errorCode!),
    );

    if (result ?? false) await _deleteRequest();

    if (mounted) context.pop();

    return false;
  }

  Future<void> _deleteRequest() async {
    if (widget.requestDVO == null) showErrorSnackbar(context: context, text: context.l10n.error_deleteRequestFailed);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final deleteResult = await session.consumptionServices.incomingRequests.delete(requestId: widget.requestDVO!.id);

    if (deleteResult.isError) {
      GetIt.I.get<Logger>().e(deleteResult.error);

      if (!mounted) return;

      showErrorSnackbar(context: context, text: context.l10n.error_deleteRequestFailed);
    }
  }
}
