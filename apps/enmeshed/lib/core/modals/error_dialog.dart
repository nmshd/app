import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';

class ErrorDialog extends StatelessWidget {
  final String? code;

  const ErrorDialog({required this.code, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: _icon(context),
      title: Text(_title(context)),
      content: Text(_content(context), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
      actions: <Widget>[FilledButton(onPressed: context.pop, child: Text(context.l10n.error_understood))],
      actionsAlignment: MainAxisAlignment.center,
    );
  }

  Icon _icon(BuildContext context) => switch (code) {
    'error.recordNotFoundOnScanRecoveryKit' ||
    'error.app-runtime.onboardedAccountAlreadyExists' => Icon(Icons.warning_rounded, color: context.customColors.warning),
    _ => Icon(Icons.cancel, color: Theme.of(context).colorScheme.error),
  };

  String _title(BuildContext context) => switch (code) {
    'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported' ||
    'error.appStringProcessor.truncatedReferenceInvalid' => context.l10n.errorDialog_invalidQRCode_title,
    'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError' => context.l10n.errorDialog_QRCodeProcessingFailed_title,
    'error.recordNotFoundOnScanRecoveryKit' => context.l10n.restoreFromIdentityRecovery_errorTitleOnAlreadyUsedRecoveryKit,
    'error.app-runtime.onboardedAccountAlreadyExists' => context.l10n.restoreFromIdentityRecovery_errorTitleOnExistingProfile,
    _ => context.l10n.errorDialog_title,
  };

  String _content(BuildContext context) => switch (code) {
    'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported' ||
    'error.appStringProcessor.truncatedReferenceInvalid' => context.l10n.errorDialog_invalidQRCode_description,
    'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError' => context.l10n.errorDialog_QRCodeProcessingFailed_description,
    'error.recordNotFoundOnScanRecoveryKit' => context.l10n.restoreFromIdentityRecovery_errorDescriptionOnAlreadyUsedRecoveryKit,
    'error.app-runtime.onboardedAccountAlreadyExists' => context.l10n.restoreFromIdentityRecovery_errorDescriptionOnExistingProfile,
    _ => context.l10n.errorDialog_description,
  };
}
