import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../core.dart';

Future<void> cancelIdentityDeletionProcess(BuildContext context, LocalAccountDTO account) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(account.id);

  final cancelIdentityDeletionProcessResult = await session.transportServices.identityDeletionProcesses.cancelIdentityDeletionProcess();

  if (cancelIdentityDeletionProcessResult.isError) {
    GetIt.I.get<Logger>().e('Can not cancel Identity deletion process: ${cancelIdentityDeletionProcessResult.error}');
    return;
  }

  await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

  if (context.mounted) {
    context.go('/account/${account.id}');
    showSuccessSnackbar(context: context, text: context.l10n.identity_restore_successful(account.name), showCloseIcon: true);

    await context.push('/profiles');
  }
}

Future<void> handleRecoveryKitScan({
  required String content,
  required BuildContext context,
  required VoidCallback pause,
  required VoidCallback resume,
}) async {
  pause();

  unawaited(
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.restoreFromIdentityRecovery_loading,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
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
