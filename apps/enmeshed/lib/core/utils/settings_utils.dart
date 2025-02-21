import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../widgets/instructions_screen.dart';

Future<void> upsertHintsSetting({required String accountId, required String key, required bool value}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);
  await session.consumptionServices.settings.upsertSettingByKey(key, {'showHints': value});
}

Future<void> upsertCompleteProfileContainerSetting({required String accountId, required bool value}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);
  await session.consumptionServices.settings.upsertSettingByKey('home.completeProfileContainerShown', {'isShown': value});
}

Future<bool> getSetting({required String accountId, required String key, required String valueKey, bool emptyRecordAllowed = false}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

  final settingResult = await session.consumptionServices.settings.getSettingByKey(key);

  if (settingResult.isError && settingResult.error.code == 'error.runtime.recordNotFound' && !emptyRecordAllowed) {
    return true;
  } else if (settingResult.isError) {
    return false;
  }

  final setting = settingResult.value;

  final value = setting.value[valueKey];

  if (value is! bool) return true;

  return value;
}

Future<void> goToInstructionsOrScanScreen({required String accountId, required ScannerType instructionsType, required BuildContext context}) async {
  final showHints = await getSetting(accountId: accountId, key: 'hints.$instructionsType', valueKey: 'showHints');

  if (!context.mounted) return;

  if (showHints) {
    await context.push('/account/$accountId/instructions/$instructionsType');
  } else {
    await context.push(switch (instructionsType) {
      ScannerType.addContact => '/account/$accountId/scan',
      ScannerType.loadProfile => '/scan',
    });
  }
}
