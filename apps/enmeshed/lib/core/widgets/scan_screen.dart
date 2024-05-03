import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../utils/utils.dart';
import 'scanner_view/scanner_view.dart';

class ScanScreen extends StatelessWidget {
  final String? accountId;

  const ScanScreen({super.key, this.accountId});

  @override
  Widget build(BuildContext context) {
    return ScannerView(
      onSubmit: onSubmit,
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

  Future<void> onSubmit({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) async {
    pause();

    final account = accountId != null ? await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccount(accountId!) : null;

    final result = await GetIt.I.get<EnmeshedRuntime>().stringProcessor.processURL(url: content, account: account);
    if (result.isError) {
      GetIt.I.get<Logger>().e('Error while processing url $content: ${result.error.message}');

      if (context.mounted) await showWrongTokenErrorDialog(context);
      resume();
      return;
    } else {
      resume();
    }
  }
}
