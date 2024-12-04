import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../utils/utils.dart';
import 'scanner_view/scanner_view.dart';

class ScanScreen extends StatelessWidget {
  final String? accountId;
  final bool? showContactHints;

  const ScanScreen({this.accountId, this.showContactHints, super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerView(
      onSubmit: _onSubmit,
      lineUpQrCodeText: context.l10n.scanner_lineUpQrCode,
      scanQrOrEnterUrlText: context.l10n.scanner_scanQrOrEnterUrl,
      enterUrlText: context.l10n.scanner_enterUrl,
      urlTitle: context.l10n.scanner_enterUrl_title,
      urlDescription: context.l10n.scanner_enterUrl_description,
      urlLabelText: context.l10n.scanner_enterUrl,
      urlValidationErrorText: context.l10n.scanner_urlValidationError,
      urlButtonText: context.l10n.scanner_enterUrl_button,
    );
  }

  Future<void> _onSubmit({
    required String content,
    required VoidCallback pause,
    required VoidCallback resume,
    required BuildContext context,
  }) async {
    pause();
    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final account = accountId != null ? await runtime.accountServices.getAccount(accountId!) : null;
    if (!context.mounted) return;

    await _processString(content: content, context: context, runtime: runtime, account: account);

    resume();
  }

  Future<void> _processString({
    required String content,
    required BuildContext context,
    required EnmeshedRuntime runtime,
    required LocalAccountDTO? account,
  }) async {
    final result = await runtime.stringProcessor.processURL(url: content, account: account);

    if (result.isError) GetIt.I.get<Logger>().e('Error while processing url $content: ${result.error.message}');

    if (result.isError && context.mounted) {
      if (result.isSuccess) return;

      switch (result.error.code) {
        case 'error.appStringProcessor.passwordNotProvided':
          break;
        case 'error.runtime.recordNotFound':
          // this could mean that the password is wrong, retry
          await _processString(content: content, context: context, runtime: runtime, account: account);
          break;
        default:
          await showWrongTokenErrorDialog(context);
          break;
      }
    }
  }
}
