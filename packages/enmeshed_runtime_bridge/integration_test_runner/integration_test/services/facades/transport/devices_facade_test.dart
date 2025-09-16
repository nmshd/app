import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account;
  late Session session;

  setUpAll(() async {
    account = await runtime.accountServices.createAccount(name: 'messagesFacade Test 1');
    session = runtime.getSession(account.id);
  });

  group('[DevicesFacade]', () {
    test('getDevice', () async {
      final devicesResult = await session.transportServices.devices.getDevices();
      final devices = devicesResult.value;

      final device = await session.transportServices.devices.getDevice(devices.first.id);
      expect(device, isSuccessful<DeviceDTO>());
    });

    test('getDevices', () async {
      final devicesResult = await session.transportServices.devices.getDevices();
      expect(devicesResult, isSuccessful<List<DeviceDTO>>());

      final devices = devicesResult.value;
      expect(devices, hasLength(1));
    });

    test('fillDeviceOnboardingTokenWithNewDevice', () async {
      final emptyToken = (await runtime.anonymousServices.tokens.createEmptyToken()).value;

      final filledTokenResult = await session.transportServices.devices.fillDeviceOnboardingTokenWithNewDevice(
        reference: emptyToken.reference.truncated,
        profileName: 'profileName',
        isAdmin: true,
      );
      expect(filledTokenResult, isSuccessful<TokenDTO>());
    });

    test('updateDevice', () async {
      final device = (await session.transportServices.devices.getDevices()).value.firstWhere((dev) => dev.isCurrentDevice);

      final updatedDeviceResult = await session.transportServices.devices.updateDevice(device.id, name: 'new name', description: 'new description');
      expect(updatedDeviceResult, isSuccessful<DeviceDTO>());

      final updatedDevice = updatedDeviceResult.value;
      expect(updatedDevice.name, 'new name');
      expect(updatedDevice.description, 'new description');

      final deviceAfterUpdate = (await session.transportServices.devices.getDevice(device.id)).value;
      expect(deviceAfterUpdate.name, 'new name');
      expect(deviceAfterUpdate.description, 'new description');
    });

    // deleteDevice is implemented but has to be handled with caution
    test('deleteDevice', skip: true, () async {});

    test('setCommunicationLanguage', () async {
      final result = await session.transportServices.devices.setCommunicationLanguage(communicationLanguage: 'fr');
      expect(result, isSuccessful<void>());
    });

    test('setCommunicationLanguage with false input', () async {
      final result = await session.transportServices.devices.setCommunicationLanguage(communicationLanguage: 'fra');
      expect(result, isFailingVoidResult('error.runtime.validation.invalidPropertyValue'));
    });
  });
}
