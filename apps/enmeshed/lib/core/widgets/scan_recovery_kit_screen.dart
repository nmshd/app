import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../utils/utils.dart';
import 'scanner_view/scanner_view.dart';

class ScanRecoveryKitScreen extends StatelessWidget {
  const ScanRecoveryKitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerView(
      onSubmit: _onSubmit,
      lineUpQrCodeText: context.l10n.scanner_lineUpQrCode,
      scanQrOrEnterUrlText: context.l10n.restoreFromIdentityRecovery_scanner_scanQrOrEnterUrl,
      enterUrlText: context.l10n.scanner_enterUrl,
      urlTitle: context.l10n.restoreFromIdentityRecovery_scanner_connectWithUrl_title,
      urlDescription: context.l10n.restoreFromIdentityRecovery_scanner_connectWithUrl_description,
      urlLabelText: context.l10n.restoreFromIdentityRecovery_scanner_connectWithUrl_urlLabel,
      urlValidationErrorText: context.l10n.scanner_urlValidationError,
      urlButtonText: context.l10n.next,
    );
  }

  Future<void> _onSubmit({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) async {
    pause();

    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder:
              (_) => Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.l10n.restoreFromIdentityRecovery_loading, style: Theme.of(context).textTheme.headlineSmall),
                      Gaps.h24,
                      const SizedBox(height: 150, width: 150, child: CircularProgressIndicator(strokeWidth: 16)),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    if (!context.mounted) return;

    final result = await runtime.stringProcessor.processURL(url: content);
    if (result.isSuccess) {
      resume();
      return;
    }

    GetIt.I.get<Logger>().e('Error while processing url $content: ${result.error.message}');
    if (!context.mounted) return;

    await context.push('/error-dialog', extra: result.error.code);

    if (!context.mounted) return;
    if (context.canPop()) context.pop();

    resume();
  }
}
