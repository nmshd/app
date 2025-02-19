import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';

class ErrorDialog extends StatelessWidget {
  final String? code;

  const ErrorDialog({required this.code, super.key});

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

  String _title(BuildContext context) {
    return switch (code) {
      'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported' ||
      'error.appStringProcessor.truncatedReferenceInvalid' => context.l10n.errorDialog_invalidQRCode_title,
      'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError' => context.l10n.errorDialog_QRCodeProcessingFailed_title,
      final String c when c.contains('error.app-runtime.onboardedAccountAlreadyExists') =>
        context.l10n.restoreFromIdentityRecovery_errorTitleOnExistingProfile,
      final String c when c.contains('error.runtime.recordNotFound') => context.l10n.restoreFromIdentityRecovery_errorTitleOnAlreadyUsedRecoveryKit,
      _ => context.l10n.errorDialog_title,
    };
  }

  String _content(BuildContext context) {
    return switch (code) {
      'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported' ||
      'error.appStringProcessor.truncatedReferenceInvalid' => context.l10n.errorDialog_invalidQRCode_description,
      'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError' => context.l10n.errorDialog_QRCodeProcessingFailed_description,
      final String c when c.contains('error.app-runtime.onboardedAccountAlreadyExists') =>
        context.l10n.restoreFromIdentityRecovery_errorDescriptionOnExistingProfile,
      final String c when c.contains('error.runtime.recordNotFound') =>
        context.l10n.restoreFromIdentityRecovery_errorDescriptionOnAlreadyUsedRecoveryKit,
      _ => context.l10n.errorDialog_description,
    };
  }
}
