import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../core.dart';

Future<List<LocalAccountDTO>> getAccountsInDeletion() async {
  final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
  return accounts.where((e) => e.deletionDate != null).toList();
}

Future<List<LocalAccountDTO>> getAccountsNotInDeletion() async {
  final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
  return accounts.where((e) => e.deletionDate == null).toList();
}

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

    showSuccessSnackbar(context: context, text: context.l10n.identity_delete_activated_and_switchedToProfile(account.name), showCloseIcon: true);
  }
}
