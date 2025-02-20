import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';

class ErrorDialog extends StatelessWidget {
  final String? code;
  final String? date;

  const ErrorDialog({required this.code, this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.error),
      title: Text(_title(context)),
      content: Text(_content(context), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
      actions: <Widget>[FilledButton(onPressed: context.pop, child: Text(context.l10n.error_understood))],
      actionsAlignment: MainAxisAlignment.center,
    );
  }

  String _title(BuildContext context) => switch (code) {
    'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported' ||
    'error.appStringProcessor.truncatedReferenceInvalid' => context.l10n.errorDialog_invalidQRCode_title,
    'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError' => context.l10n.errorDialog_QRCodeProcessingFailed_title,
    'error.transport.relationships.relationshipNotYetDecomposedByPeer' => context.l10n.errorDialog_relationshipNotYetDecomposedByPeer_title,
    'error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate' =>
      context.l10n.errorDialog_activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate_title,
    'error.transport.relationships.relationshipTemplateIsExpired' => context.l10n.errorDialog_relationshipTemplateIsExpired_title,
    'expiredRequestFirstTime' => context.l10n.errorDialog_expiredRequestFirstTime_title,
    'expiredRequest' => context.l10n.errorDialog_expiredRequest_title,
    _ => context.l10n.errorDialog_title,
  };

  String _content(BuildContext context) => switch (code) {
    'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported' ||
    'error.appStringProcessor.truncatedReferenceInvalid' => context.l10n.errorDialog_invalidQRCode_description,
    'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError' => context.l10n.errorDialog_QRCodeProcessingFailed_description,
    'error.transport.relationships.relationshipNotYetDecomposedByPeer' => context.l10n.errorDialog_relationshipNotYetDecomposedByPeer_description,
    'error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate' =>
      context.l10n.errorDialog_activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate_description,
    'error.transport.relationships.relationshipTemplateIsExpired' => context.l10n.errorDialog_relationshipTemplateIsExpired_description(
      DateTime.parse(DateTime.now().toString()).toLocal(),
    ),
    'expiredRequestFirstTime' => context.l10n.errorDialog_expiredRequestFirstTime_description(DateTime.parse(DateTime.now().toString()).toLocal()),
    'expiredRequest' => context.l10n.errorDialog_expiredRequest_description(DateTime.parse(DateTime.now().toString()).toLocal()),
    _ => context.l10n.errorDialog_description,
  };
}
