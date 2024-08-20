import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../core.dart';

Future<bool> isAccountInDeletion(LocalAccountDTO account) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(account.id);
  final activeIdentityDeletionResult = await session.transportServices.identityDeletionProcesses.getActiveIdentityDeletionProcess();

  if (activeIdentityDeletionResult.isError) return false;

  return true;
}

Future<String> getAccountDeletionDate(LocalAccountDTO account) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(account.id);
  final activeIdentityDeletionResult = await session.transportServices.identityDeletionProcesses.getActiveIdentityDeletionProcess();
  return activeIdentityDeletionResult.value.gracePeriodEndsAt!;
}

Future<List<LocalAccountDTO>> getAccountsInDeletion() async {
  final accountsInDeletion = <LocalAccountDTO>[];
  final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
  for (final account in accounts) {
    if (await isAccountInDeletion(account)) {
      accountsInDeletion.add(account);
    }
  }
  return accountsInDeletion;
}

Future<List<LocalAccountDTO>> getAccountsNotInDeletion() async {
  final accountsNotInDeletion = <LocalAccountDTO>[];
  final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
  for (final account in accounts) {
    if (!(await isAccountInDeletion(account))) {
      accountsNotInDeletion.add(account);
    }
  }
  return accountsNotInDeletion;
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        content: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: context.customColors.successIcon),
            Gaps.w8,
            Expanded(child: Text(context.l10n.identity_delete_activated_and_switchedToProfile(account.name))),
          ],
        ),
      ),
    );
  }
}
