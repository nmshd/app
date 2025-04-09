import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
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

Future<void> createNewAccount({required BuildContext context, required String accountName, required void Function() goToOnboardingAccount}) async {
  try {
    final account = await GetIt.I.get<EnmeshedRuntime>().accountServices.createAccount(name: accountName);

    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);
    if (context.mounted) context.go('/account/${account.id}');
  } catch (e) {
    GetIt.I.get<Logger>().e(e.toString());
    if (context.mounted) {
      context.pop();

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
            content: Text(context.l10n.error_createAccount),
          );
        },
      );

      goToOnboardingAccount();
    }
  }
}
