import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account;
  late Session session;

  setUpAll(() async {
    account = await runtime.accountServices.createAccount(name: 'requestFacade Test 1');
    session = runtime.getSession(account.id);
  });

  group('SettingsFacade', () {
    final value = {'aKey': 'a-value'};
    late String settingId;

    test('should create a setting', () async {
      final result = await session.consumptionServices.settings.createSetting(key: 'a-key', value: value);
      expect(result, isSuccessful<SettingDTO>());

      final setting = result.value;
      settingId = setting.id;

      expect(setting.value, value);
    });

    test('should contain the setting in the list of settings', () async {
      final result = await session.consumptionServices.settings.getSettings();
      expect(result, isSuccessful<List<SettingDTO>>());

      final settings = result.value;

      expect(settings, hasLength(1));
      expect(settings[0].id, settingId);
      expect(settings[0].value, value);
    });

    test('should edit the setting', () async {
      final newValue = {'aKey': 'another-Value'};
      final updateResult = await session.consumptionServices.settings.updateSetting(settingId, newValue);
      expect(updateResult, isSuccessful<SettingDTO>());

      final result = await session.consumptionServices.settings.getSetting(settingId);
      expect(result, isSuccessful<SettingDTO>());

      final setting = result.value;
      expect(setting.value, newValue);
    });

    test('should delete the setting', () async {
      final deleteResult = await session.consumptionServices.settings.deleteSetting(settingId);
      expect(deleteResult, isSuccessful());

      final result = await session.consumptionServices.settings.getSettings();
      expect(result, isSuccessful<List<SettingDTO>>());

      final settings = result.value;
      expect(settings, hasLength(0));
    });

    test('should get the setting by key', () async {
      final toBeSucceeded = await session.consumptionServices.settings.createSetting(key: 'a-key', value: {
        'key': ['value']
      });

      await session.consumptionServices.settings.createSetting(
        key: 'a-key',
        value: {
          'key': ['newValue']
        },
        succeedsItem: toBeSucceeded.value.id,
        succeedsAt: DateTime.now().toRuntimeIsoString(),
      );

      final result = await session.consumptionServices.settings.getSettingByKey('a-key');
      expect(result, isSuccessful<SettingDTO>());

      final setting = result.value;
      expect(setting.value, {
        'key': ['newValue']
      });
    });
  });
}
