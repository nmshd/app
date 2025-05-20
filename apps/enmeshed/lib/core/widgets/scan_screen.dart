import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../utils/utils.dart';
import 'instructions_screen.dart';
import 'scanner_view/scanner_view.dart';

class ScanScreen extends StatelessWidget {
  final ScannerType scannerType;
  final String? accountId;

  const ScanScreen({required this.scannerType, this.accountId, super.key})
    : assert(scannerType == ScannerType.addContact && accountId != null || scannerType == ScannerType.loadProfile && accountId == null);

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

  Future<void> _onSubmit({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) async {
    pause();
    final runtime = GetIt.I.get<EnmeshedRuntime>();

    if (!context.mounted) return;

    final result = switch (scannerType) {
      ScannerType.loadProfile => await runtime.stringProcessor.processDeviceOnboardingReference(url: content),
      ScannerType.addContact => await runtime.stringProcessor.processURL(url: content, account: await runtime.accountServices.getAccount(accountId!)),
    };

    if (result.isSuccess) {
      resume();
      return;
    }

    GetIt.I.get<Logger>().e('Error while processing url $content: ${result.error.message}');
    if (!context.mounted) return;

    await context.push('/error-dialog', extra: result.error.code);

    resume();
  }
}
