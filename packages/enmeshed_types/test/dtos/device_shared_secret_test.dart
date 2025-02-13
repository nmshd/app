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

    test('is correctly converted with property "profileName"', () {
      const dto = DeviceSharedSecret(
        id: 'anId',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        profileName: 'aProfileName',
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
          'profileName': 'aProfileName',
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

    test('is correctly converted with property "isBackupDevice"', () {
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
        isBackupDevice: true,
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
          'isBackupDevice': true,
        }),
      );
    });

    test('is correctly converted with all properties', () {
      const dto = DeviceSharedSecret(
        id: 'anId',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        name: 'aName',
        description: 'aDescription',
        profileName: 'aProfileName',
        secretBaseKey: 'aSecretBaseKey',
        deviceIndex: 1,
        synchronizationKey: 'aSynchronizationKey',
        identityPrivateKey: 'aPrivateKey',
        identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
        password: 'aPassword',
        username: 'anUsername',
        isBackupDevice: true,
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
          'profileName': 'aProfileName',
          'secretBaseKey': 'aSecretBaseKey',
          'deviceIndex': 1,
          'synchronizationKey': 'aSynchronizationKey',
          'identityPrivateKey': 'aPrivateKey',
          'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
          'password': 'aPassword',
          'username': 'anUsername',
          'isBackupDevice': true,
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
        equals(
          const DeviceSharedSecret(
            id: 'anId',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            secretBaseKey: 'aSecretBaseKey',
            deviceIndex: 1,
            synchronizationKey: 'aSynchronizationKey',
            identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
            password: 'aPassword',
            username: 'anUsername',
          ),
        ),
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
        equals(
          const DeviceSharedSecret(
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
          ),
        ),
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
        equals(
          const DeviceSharedSecret(
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
          ),
        ),
      );
    });

    test('is correctly converted with property "profileName"', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'profileName': 'aProfileName',
        'secretBaseKey': 'aSecretBaseKey',
        'deviceIndex': 1,
        'synchronizationKey': 'aSynchronizationKey',
        'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
        'password': 'aPassword',
        'username': 'anUsername',
      };
      expect(
        DeviceSharedSecret.fromJson(json),
        equals(
          const DeviceSharedSecret(
            id: 'anId',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            profileName: 'aProfileName',
            secretBaseKey: 'aSecretBaseKey',
            deviceIndex: 1,
            synchronizationKey: 'aSynchronizationKey',
            identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
            password: 'aPassword',
            username: 'anUsername',
          ),
        ),
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
        equals(
          const DeviceSharedSecret(
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
          ),
        ),
      );
    });

    test('is correctly converted with property "isBackupDevice"', () {
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
        'isBackupDevice': true,
      };
      expect(
        DeviceSharedSecret.fromJson(json),
        equals(
          const DeviceSharedSecret(
            id: 'anId',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            secretBaseKey: 'aSecretBaseKey',
            deviceIndex: 1,
            synchronizationKey: 'aSynchronizationKey',
            identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
            password: 'aPassword',
            username: 'anUsername',
            isBackupDevice: true,
          ),
        ),
      );
    });

    test('is correctly converted with all properties', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'name': 'aName',
        'description': 'aDescription',
        'profileName': 'aProfileName',
        'secretBaseKey': 'aSecretBaseKey',
        'deviceIndex': 1,
        'synchronizationKey': 'aSynchronizationKey',
        'identityPrivateKey': 'aPrivateKey',
        'identity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
        'password': 'aPassword',
        'username': 'anUsername',
        'isBackupDevice': true,
      };
      expect(
        DeviceSharedSecret.fromJson(json),
        equals(
          const DeviceSharedSecret(
            id: 'anId',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            name: 'aName',
            description: 'aDescription',
            profileName: 'aProfileName',
            secretBaseKey: 'aSecretBaseKey',
            deviceIndex: 1,
            synchronizationKey: 'aSynchronizationKey',
            identityPrivateKey: 'aPrivateKey',
            identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
            password: 'aPassword',
            username: 'anUsername',
            isBackupDevice: true,
          ),
        ),
      );
    });
  });
}
