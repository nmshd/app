import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/utils/extensions.dart';

class CreateRelationshipErrorDialog extends StatelessWidget {
  final String errorCode;

  const CreateRelationshipErrorDialog({required this.errorCode, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: _icon(context),
      title: Text(_title(context)),
      content: Text(_content(context), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
      actions: [
        FilledButton(
          onPressed: errorCode == 'error.transport.relationships.relationshipTemplateIsExpired' ? () => context.pop(true) : () => context.pop(false),
          child: Text(
            errorCode == 'error.transport.relationships.relationshipTemplateIsExpired'
                ? context.l10n.error_deleteRequest
                : context.l10n.error_understood,
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }

  Icon _icon(BuildContext context) => switch (errorCode) {
    'error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate' => Icon(
      Icons.cancel,
      color: Theme.of(context).colorScheme.error,
    ),
    _ => Icon(Icons.error, color: Theme.of(context).colorScheme.error),
  };

  String _title(BuildContext context) => switch (errorCode) {
    'error.transport.relationships.relationshipNotYetDecomposedByPeer' => context.l10n.errorDialog_relationshipNotYetDecomposedByPeer_title,
    'error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate' =>
      context.l10n.errorDialog_activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate_title,
    'error.transport.relationships.relationshipTemplateIsExpired' => context.l10n.errorDialog_relationshipTemplateIsExpired_title,
    'error.relationshipTemplateProcessedModule.requestExpired' => context.l10n.errorDialog_requestExpired_title,
    _ => context.l10n.errorDialog_title,
  };

  String _content(BuildContext context) => switch (errorCode) {
    'error.transport.relationships.relationshipNotYetDecomposedByPeer' => context.l10n.errorDialog_relationshipNotYetDecomposedByPeer_description,
    'error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate' =>
      context.l10n.errorDialog_activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate_description,
    'error.transport.relationships.relationshipTemplateIsExpired' => context.l10n.errorDialog_relationshipTemplateIsExpired_description,
    'error.relationshipTemplateProcessedModule.requestExpired' => context.l10n.errorDialog_requestExpired_description,
    _ => context.l10n.errorDialog_description,
  };
}
