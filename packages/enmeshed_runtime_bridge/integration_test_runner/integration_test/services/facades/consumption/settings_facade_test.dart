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

  tearDown(() async {
    final settings = await session.consumptionServices.settings.getSettings();
    for (final setting in settings.value) {
      await session.consumptionServices.settings.deleteSetting(setting.id);
    }
  });

  group('SettingsFacade', () {
    test('should create a setting', () async {
      const value = {'aKey': 'a-value'};
      final result = await session.consumptionServices.settings.createSetting(key: 'a-key', value: value);
      expect(result, isSuccessful<SettingDTO>());

      final setting = result.value;

      expect(setting.value, value);
    });

    test('should contain the setting in the list of settings', () async {
      const value = {'aKey': 'a-value'};
      final setting = (await session.consumptionServices.settings.createSetting(key: 'a-key', value: value)).value;

      final result = await session.consumptionServices.settings.getSettings();
      expect(result, isSuccessful<List<SettingDTO>>());

      final settings = result.value;

      expect(settings, hasLength(1));
      expect(settings[0].id, setting.id);
      expect(settings[0].value, value);
    });

    test('should edit the setting', () async {
      const value = {'aKey': 'a-value'};
      final setting = (await session.consumptionServices.settings.createSetting(key: 'a-key', value: value)).value;

      final newValue = {'aKey': 'another-Value'};
      final updateResult = await session.consumptionServices.settings.updateSetting(setting.id, newValue);
      expect(updateResult, isSuccessful<SettingDTO>());

      final result = await session.consumptionServices.settings.getSetting(setting.id);
      expect(result, isSuccessful<SettingDTO>());

      final updatedSetting = result.value;
      expect(updatedSetting.value, newValue);
    });

    test('should delete the setting', () async {
      const value = {'aKey': 'a-value'};
      final setting = (await session.consumptionServices.settings.createSetting(key: 'a-key', value: value)).value;

      final deleteResult = await session.consumptionServices.settings.deleteSetting(setting.id);
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

    test('should upsert a setting by key when it does not exist yet', () async {
      await session.consumptionServices.settings.upsertSettingByKey('a-key', {'aKey': 'a-value'});

      final result = await session.consumptionServices.settings.getSettings();
      expect(result, isSuccessful<List<SettingDTO>>());
      expect(result.value, hasLength(1));

      final setting = await session.consumptionServices.settings.getSettingByKey('a-key');
      expect(setting.value.value, {'aKey': 'a-value'});
    });

    test('should upsert a setting by key', () async {
      const value = {'aKey': 'a-value'};
      await session.consumptionServices.settings.createSetting(key: 'a-key', value: value);

      await session.consumptionServices.settings.upsertSettingByKey('a-key', {'aKey': 'aNewValue'});

      final result = await session.consumptionServices.settings.getSettings();
      expect(result, isSuccessful<List<SettingDTO>>());
      expect(result.value, hasLength(1));

      final setting = await session.consumptionServices.settings.getSettingByKey('a-key');
      expect(setting.value.value, {'aKey': 'aNewValue'});
    });

    test('should upsert a relationship setting by key', () async {
      const value = {'aKey': 'a-value'};

      const reference = 'RELaaaaaaaaaaaaaaaaa';

      final upsertSettingResult = await session.consumptionServices.settings.upsertSettingByKey(
        'a-key',
        value,
        reference: reference,
        scope: SettingScope.Relationship,
      );
      expect(upsertSettingResult, isSuccessful<SettingDTO>());
      expect(upsertSettingResult.value.value, value);
      expect(upsertSettingResult.value.reference, reference);
      expect(upsertSettingResult.value.scope, SettingScope.Relationship);

      final result = await session.consumptionServices.settings.getSettings();
      expect(result, isSuccessful<List<SettingDTO>>());
      expect(result.value, hasLength(1));

      final getSettingResult = await session.consumptionServices.settings.getSettingByKey(
        'a-key',
        reference: reference,
        scope: SettingScope.Relationship,
      );
      final setting = getSettingResult.value;
      expect(setting.value, value);
      expect(setting.reference, reference);
      expect(setting.scope, SettingScope.Relationship);
    });
  });
}
