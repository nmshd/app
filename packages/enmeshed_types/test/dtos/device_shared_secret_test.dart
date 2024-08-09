import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('DeviceSharedSecret toJson', () {
    test('is correctly converted', () {
      const dto = DeviceSharedSecret(
        id: 'anId',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        secretBaseKey: 'aSecretBaseKey',
        deviceIndex: 1,
        synchronizationKey: 'aSynchronizationKey',
        identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
        password: 'aPassword',
        username: 'anUsername',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'secretBaseKey': 'aSecretBaseKey',
          'deviceIndex': 1,
          'synchronizationKey': 'aSynchronizationKey',
          'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
          'password': 'aPassword',
          'username': 'anUsername',
        }),
      );
    });

    test('is correctly converted with property "name"', () {
      const dto = DeviceSharedSecret(
        id: 'anId',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        name: 'aName',
        secretBaseKey: 'aSecretBaseKey',
        deviceIndex: 1,
        synchronizationKey: 'aSynchronizationKey',
        identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
        password: 'aPassword',
        username: 'anUsername',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'name': 'aName',
          'secretBaseKey': 'aSecretBaseKey',
          'deviceIndex': 1,
          'synchronizationKey': 'aSynchronizationKey',
          'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
          'password': 'aPassword',
          'username': 'anUsername',
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const dto = DeviceSharedSecret(
        id: 'anId',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        description: 'aDescription',
        secretBaseKey: 'aSecretBaseKey',
        deviceIndex: 1,
        synchronizationKey: 'aSynchronizationKey',
        identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
        password: 'aPassword',
        username: 'anUsername',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'description': 'aDescription',
          'secretBaseKey': 'aSecretBaseKey',
          'deviceIndex': 1,
          'synchronizationKey': 'aSynchronizationKey',
          'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
          'password': 'aPassword',
          'username': 'anUsername',
        }),
      );
    });

    test('is correctly converted with property "identityPrivateKey"', () {
      const dto = DeviceSharedSecret(
        id: 'anId',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        secretBaseKey: 'aSecretBaseKey',
        deviceIndex: 1,
        synchronizationKey: 'aSynchronizationKey',
        identityPrivateKey: 'aPrivateKey',
        identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
        password: 'aPassword',
        username: 'anUsername',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'secretBaseKey': 'aSecretBaseKey',
          'deviceIndex': 1,
          'synchronizationKey': 'aSynchronizationKey',
          'identityPrivateKey': 'aPrivateKey',
          'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
          'password': 'aPassword',
          'username': 'anUsername',
        }),
      );
    });

    test('is correctly converted with properties "name", "description", and "identityPrivateKey"', () {
      const dto = DeviceSharedSecret(
        id: 'anId',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        name: 'aName',
        description: 'aDescription',
        secretBaseKey: 'aSecretBaseKey',
        deviceIndex: 1,
        synchronizationKey: 'aSynchronizationKey',
        identityPrivateKey: 'aPrivateKey',
        identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
        password: 'aPassword',
        username: 'anUsername',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'name': 'aName',
          'description': 'aDescription',
          'secretBaseKey': 'aSecretBaseKey',
          'deviceIndex': 1,
          'synchronizationKey': 'aSynchronizationKey',
          'identityPrivateKey': 'aPrivateKey',
          'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
          'password': 'aPassword',
          'username': 'anUsername',
        }),
      );
    });
  });

  group('DeviceSharedSecret fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'secretBaseKey': 'aSecretBaseKey',
        'deviceIndex': 1,
        'synchronizationKey': 'aSynchronizationKey',
        'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
        'password': 'aPassword',
        'username': 'anUsername',
      };
      expect(
        DeviceSharedSecret.fromJson(json),
        equals(const DeviceSharedSecret(
          id: 'anId',
          createdAt: '2023',
          createdByDevice: 'aCreatorDeviceId',
          secretBaseKey: 'aSecretBaseKey',
          deviceIndex: 1,
          synchronizationKey: 'aSynchronizationKey',
          identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
          password: 'aPassword',
          username: 'anUsername',
        )),
      );
    });

    test('is correctly converted with property "name"', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'name': 'aName',
        'secretBaseKey': 'aSecretBaseKey',
        'deviceIndex': 1,
        'synchronizationKey': 'aSynchronizationKey',
        'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
        'password': 'aPassword',
        'username': 'anUsername',
      };
      expect(
        DeviceSharedSecret.fromJson(json),
        equals(const DeviceSharedSecret(
          id: 'anId',
          createdAt: '2023',
          createdByDevice: 'aCreatorDeviceId',
          name: 'aName',
          secretBaseKey: 'aSecretBaseKey',
          deviceIndex: 1,
          synchronizationKey: 'aSynchronizationKey',
          identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
          password: 'aPassword',
          username: 'anUsername',
        )),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'description': 'aDescription',
        'secretBaseKey': 'aSecretBaseKey',
        'deviceIndex': 1,
        'synchronizationKey': 'aSynchronizationKey',
        'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
        'password': 'aPassword',
        'username': 'anUsername',
      };
      expect(
        DeviceSharedSecret.fromJson(json),
        equals(const DeviceSharedSecret(
          id: 'anId',
          createdAt: '2023',
          createdByDevice: 'aCreatorDeviceId',
          description: 'aDescription',
          secretBaseKey: 'aSecretBaseKey',
          deviceIndex: 1,
          synchronizationKey: 'aSynchronizationKey',
          identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
          password: 'aPassword',
          username: 'anUsername',
        )),
      );
    });

    test('is correctly converted with property "identityPrivateKey"', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'secretBaseKey': 'aSecretBaseKey',
        'deviceIndex': 1,
        'synchronizationKey': 'aSynchronizationKey',
        'identityPrivateKey': 'aPrivateKey',
        'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
        'password': 'aPassword',
        'username': 'anUsername',
      };
      expect(
        DeviceSharedSecret.fromJson(json),
        equals(const DeviceSharedSecret(
          id: 'anId',
          createdAt: '2023',
          createdByDevice: 'aCreatorDeviceId',
          secretBaseKey: 'aSecretBaseKey',
          deviceIndex: 1,
          synchronizationKey: 'aSynchronizationKey',
          identityPrivateKey: 'aPrivateKey',
          identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
          password: 'aPassword',
          username: 'anUsername',
        )),
      );
    });

    test('is correctly converted with properties "name", "description", and "identityPrivateKey"', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'name': 'aName',
        'description': 'aDescription',
        'secretBaseKey': 'aSecretBaseKey',
        'deviceIndex': 1,
        'synchronizationKey': 'aSynchronizationKey',
        'identityPrivateKey': 'aPrivateKey',
        'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
        'password': 'aPassword',
        'username': 'anUsername',
      };
      expect(
        DeviceSharedSecret.fromJson(json),
        equals(const DeviceSharedSecret(
          id: 'anId',
          createdAt: '2023',
          createdByDevice: 'aCreatorDeviceId',
          name: 'aName',
          description: 'aDescription',
          secretBaseKey: 'aSecretBaseKey',
          deviceIndex: 1,
          synchronizationKey: 'aSynchronizationKey',
          identityPrivateKey: 'aPrivateKey',
          identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
          password: 'aPassword',
          username: 'anUsername',
        )),
      );
    });
  });
}
