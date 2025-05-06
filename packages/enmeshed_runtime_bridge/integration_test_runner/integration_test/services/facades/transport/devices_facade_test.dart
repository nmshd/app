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

    test('createDevice', () async {
      final devices1 = (await session.transportServices.devices.getDevices()).value;
      expect(devices1, hasLength(1));

      final deviceResult = await session.transportServices.devices.createDevice(
        name: 'name',
        description: 'description',
      );
      expect(deviceResult, isSuccessful<DeviceDTO>());

      final device = deviceResult.value;
      expect(device.name, 'name');
      expect(device.description, 'description');

      final devices2 = (await session.transportServices.devices.getDevices()).value;
      expect(devices2, hasLength(2));
    });

    test('getDeviceOnboardingInfo', () async {
      final device = (await session.transportServices.devices.createDevice()).value;

      final onboardingInfo = await session.transportServices.devices.getDeviceOnboardingInfo(device.id);
      expect(onboardingInfo, isSuccessful<DeviceSharedSecret>());
    });

    test('getDeviceOnboardingInfo with profile name', () async {
      final device = (await session.transportServices.devices.createDevice()).value;
      const profileName = 'profileName';

      final onboardingInfo = await session.transportServices.devices.getDeviceOnboardingInfo(device.id, profileName: profileName);
      expect(onboardingInfo, isSuccessful<DeviceSharedSecret>());
      expect(onboardingInfo.value.profileName, profileName);
    });

    test('createDeviceOnboardingToken', () async {
      final device = (await session.transportServices.devices.createDevice()).value;

      final onboardingTokenResult = await session.transportServices.devices.createDeviceOnboardingToken(device.id);
      expect(onboardingTokenResult, isSuccessful<TokenDTO>());

      final onboardingToken = onboardingTokenResult.value;
      expect(onboardingToken.content, const TypeMatcher<TokenContentDeviceSharedSecret>());
    });

    test('createDeviceOnboardingToken with profile name', () async {
      final device = (await session.transportServices.devices.createDevice()).value;
      const profileName = 'profileName';

      final onboardingTokenResult = await session.transportServices.devices.createDeviceOnboardingToken(device.id, profileName: profileName);
      expect(onboardingTokenResult, isSuccessful<TokenDTO>());

      final onboardingToken = onboardingTokenResult.value;
      expect(onboardingToken.content, const TypeMatcher<TokenContentDeviceSharedSecret>());
      expect((onboardingToken.content as TokenContentDeviceSharedSecret).sharedSecret.profileName, profileName);
    });

    test('updateDevice', () async {
      final device = (await session.transportServices.devices.createDevice(name: 'name', description: 'description')).value;

      final updatedDeviceResult = await session.transportServices.devices.updateDevice(
        device.id,
        name: 'new name',
        description: 'new description',
      );
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
      expect(result, isSuccessful());
    });

    test('setCommunicationLanguage with false input', () async {
      final result = await session.transportServices.devices.setCommunicationLanguage(communicationLanguage: 'fra');
      expect(result, isFailingVoidResult('error.runtime.validation.invalidPropertyValue'));
    });
  });
}
