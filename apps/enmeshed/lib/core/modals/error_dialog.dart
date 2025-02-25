import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';

class ErrorDialog extends StatelessWidget {
  final String? code;
  final VoidCallback? onButtonPressed;

  const ErrorDialog({required this.code, this.onButtonPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: _icon(context),
      title: Text(_title(context)),
      content: Text(_content(context), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
      actions: <Widget>[FilledButton(onPressed: onButtonPressed ?? context.pop, child: Text(_buttonText(context)))],
      actionsAlignment: MainAxisAlignment.center,
    );
  }

  Icon _icon(BuildContext context) => switch (code) {
    'error.recordNotFoundOnScanRecoveryKit' ||
    'error.app-runtime.onboardedAccountAlreadyExists' => Icon(Icons.warning_rounded, color: context.customColors.warning),
    'error.transport.relationships.relationshipNotYetDecomposedByPeer' ||
    'error.transport.relationships.relationshipTemplateIsExpired' ||
    'error.relationshipTemplateProcessedModule.requestExpired' => Icon(Icons.error, color: Theme.of(context).colorScheme.error),
    _ => Icon(Icons.cancel, color: Theme.of(context).colorScheme.error),
  };

  String _buttonText(BuildContext context) => switch (code) {
    'error.transport.relationships.relationshipTemplateIsExpired' => context.l10n.error_deleteRequest,
    _ => context.l10n.error_understood,
  };

  String _title(BuildContext context) => switch (code) {
    'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported' ||
    'error.appStringProcessor.truncatedReferenceInvalid' => context.l10n.errorDialog_invalidQRCode_title,
    'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError' => context.l10n.errorDialog_QRCodeProcessingFailed_title,
    'error.recordNotFoundOnScanRecoveryKit' => context.l10n.restoreFromIdentityRecovery_errorTitleOnAlreadyUsedRecoveryKit,
    'error.app-runtime.onboardedAccountAlreadyExists' => context.l10n.restoreFromIdentityRecovery_errorTitleOnExistingProfile,
    'error.transport.relationships.relationshipNotYetDecomposedByPeer' => context.l10n.errorDialog_relationshipNotYetDecomposedByPeer_title,
    'error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate' =>
      context.l10n.errorDialog_activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate_title,
    'error.transport.relationships.relationshipTemplateIsExpired' => context.l10n.errorDialog_relationshipTemplateIsExpired_title,
    'error.relationshipTemplateProcessedModule.requestExpired' => context.l10n.errorDialog_requestExpired_title,
    _ => context.l10n.errorDialog_title,
  };

  String _content(BuildContext context) => switch (code) {
    'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported' ||
    'error.appStringProcessor.truncatedReferenceInvalid' => context.l10n.errorDialog_invalidQRCode_description,
    'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError' => context.l10n.errorDialog_QRCodeProcessingFailed_description,
    'error.recordNotFoundOnScanRecoveryKit' => context.l10n.restoreFromIdentityRecovery_errorDescriptionOnAlreadyUsedRecoveryKit,
    'error.app-runtime.onboardedAccountAlreadyExists' => context.l10n.restoreFromIdentityRecovery_errorDescriptionOnExistingProfile,
    'error.transport.relationships.relationshipNotYetDecomposedByPeer' => context.l10n.errorDialog_relationshipNotYetDecomposedByPeer_description,
    'error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate' =>
      context.l10n.errorDialog_activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate_description,
    'error.transport.relationships.relationshipTemplateIsExpired' => context.l10n.errorDialog_relationshipTemplateIsExpired_description,
    'error.relationshipTemplateProcessedModule.requestExpired' => context.l10n.errorDialog_requestExpired_description,
    _ => context.l10n.errorDialog_description,
  };
}
