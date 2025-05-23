import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('DeviceDTO toJson', () {
    test('is correctly converted', () {
      const dto = DeviceDTO(
        id: 'anId',
        isAdmin: true,
        name: 'aName',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        type: 'aType',
        username: 'anUsername',
        isCurrentDevice: true,
        isBackupDevice: true,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isAdmin': true,
          'name': 'aName',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'type': 'aType',
          'username': 'anUsername',
          'isCurrentDevice': true,
          'isBackupDevice': true,
        }),
      );
    });

    test('is correctly converted with property "publicKey"', () {
      const dto = DeviceDTO(
        id: 'anId',
        isAdmin: true,
        publicKey: 'aPublicKey',
        name: 'aName',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        type: 'aType',
        username: 'anUsername',
        isCurrentDevice: true,
        isBackupDevice: true,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isAdmin': true,
          'publicKey': 'aPublicKey',
          'name': 'aName',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'type': 'aType',
          'username': 'anUsername',
          'isCurrentDevice': true,
          'isBackupDevice': true,
        }),
      );
    });

    test('is correctly converted with property "certificate"', () {
      const dto = DeviceDTO(
        id: 'anId',
        isAdmin: true,
        certificate: 'aCertificate',
        name: 'aName',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        type: 'aType',
        username: 'anUsername',
        isCurrentDevice: true,
        isBackupDevice: true,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isAdmin': true,
          'certificate': 'aCertificate',
          'name': 'aName',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'type': 'aType',
          'username': 'anUsername',
          'isCurrentDevice': true,
          'isBackupDevice': true,
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const dto = DeviceDTO(
        id: 'anId',
        isAdmin: true,
        name: 'aName',
        description: 'aDescription',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        type: 'aType',
        username: 'anUsername',
        isCurrentDevice: true,
        isBackupDevice: true,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isAdmin': true,
          'name': 'aName',
          'description': 'aDescription',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'type': 'aType',
          'username': 'anUsername',
          'isCurrentDevice': true,
          'isBackupDevice': true,
        }),
      );
    });

    test('is correctly converted with property "operatingSystem"', () {
      const dto = DeviceDTO(
        id: 'anId',
        isAdmin: true,
        name: 'aName',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        operatingSystem: 'aOperatingSystem',
        type: 'aType',
        username: 'anUsername',
        isCurrentDevice: true,
        isBackupDevice: true,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isAdmin': true,
          'name': 'aName',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'operatingSystem': 'aOperatingSystem',
          'type': 'aType',
          'username': 'anUsername',
          'isCurrentDevice': true,
          'isBackupDevice': true,
        }),
      );
    });

    test('is correctly converted with property "lastLoginAt"', () {
      const dto = DeviceDTO(
        id: 'anId',
        isAdmin: true,
        name: 'aName',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        lastLoginAt: '2023',
        type: 'aType',
        username: 'anUsername',
        isCurrentDevice: true,
        isBackupDevice: true,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isAdmin': true,
          'name': 'aName',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'lastLoginAt': '2023',
          'type': 'aType',
          'username': 'anUsername',
          'isCurrentDevice': true,
          'isBackupDevice': true,
        }),
      );
    });

    test('is correctly converted with properties "publicKey", "certificate", "description", "operatingSystem" and "lastLoginAt"', () {
      const dto = DeviceDTO(
        id: 'anId',
        isAdmin: true,
        publicKey: 'aPublicKey',
        certificate: 'aCertificate',
        name: 'aName',
        description: 'aDescription',
        createdAt: '2023',
        createdByDevice: 'aCreatorDeviceId',
        operatingSystem: 'aOperatingSystem',
        lastLoginAt: '2023',
        type: 'aType',
        username: 'anUsername',
        isCurrentDevice: true,
        isBackupDevice: true,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isAdmin': true,
          'publicKey': 'aPublicKey',
          'certificate': 'aCertificate',
          'name': 'aName',
          'description': 'aDescription',
          'createdAt': '2023',
          'createdByDevice': 'aCreatorDeviceId',
          'operatingSystem': 'aOperatingSystem',
          'lastLoginAt': '2023',
          'type': 'aType',
          'username': 'anUsername',
          'isCurrentDevice': true,
          'isBackupDevice': true,
        }),
      );
    });
  });

  group('DeviceDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'isAdmin': true,
        'name': 'aName',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'type': 'aType',
        'username': 'anUsername',
        'isCurrentDevice': true,
        'isBackupDevice': true,
      };
      expect(
        DeviceDTO.fromJson(json),
        equals(
          const DeviceDTO(
            id: 'anId',
            isAdmin: true,
            name: 'aName',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            type: 'aType',
            username: 'anUsername',
            isCurrentDevice: true,
            isBackupDevice: true,
          ),
        ),
      );
    });

    test('is correctly converted with property "publicKey"', () {
      final json = {
        'id': 'anId',
        'isAdmin': true,
        'publicKey': 'aPublicKey',
        'name': 'aName',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'type': 'aType',
        'username': 'anUsername',
        'isCurrentDevice': true,
        'isBackupDevice': true,
      };
      expect(
        DeviceDTO.fromJson(json),
        equals(
          const DeviceDTO(
            id: 'anId',
            isAdmin: true,
            publicKey: 'aPublicKey',
            name: 'aName',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            type: 'aType',
            username: 'anUsername',
            isCurrentDevice: true,
            isBackupDevice: true,
          ),
        ),
      );
    });

    test('is correctly converted with property "certificate"', () {
      final json = {
        'id': 'anId',
        'isAdmin': true,
        'certificate': 'aCertificate',
        'name': 'aName',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'type': 'aType',
        'username': 'anUsername',
        'isCurrentDevice': true,
        'isBackupDevice': true,
      };
      expect(
        DeviceDTO.fromJson(json),
        equals(
          const DeviceDTO(
            id: 'anId',
            isAdmin: true,
            certificate: 'aCertificate',
            name: 'aName',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            type: 'aType',
            username: 'anUsername',
            isCurrentDevice: true,
            isBackupDevice: true,
          ),
        ),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'id': 'anId',
        'isAdmin': true,
        'name': 'aName',
        'description': 'aDescription',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'type': 'aType',
        'username': 'anUsername',
        'isCurrentDevice': true,
        'isBackupDevice': true,
      };
      expect(
        DeviceDTO.fromJson(json),
        equals(
          const DeviceDTO(
            id: 'anId',
            isAdmin: true,
            name: 'aName',
            description: 'aDescription',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            type: 'aType',
            username: 'anUsername',
            isCurrentDevice: true,
            isBackupDevice: true,
          ),
        ),
      );
    });

    test('is correctly converted with property "operatingSystem"', () {
      final json = {
        'id': 'anId',
        'isAdmin': true,
        'name': 'aName',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'operatingSystem': 'aOperatingSystem',
        'type': 'aType',
        'username': 'anUsername',
        'isCurrentDevice': true,
        'isBackupDevice': true,
      };
      expect(
        DeviceDTO.fromJson(json),
        equals(
          const DeviceDTO(
            id: 'anId',
            isAdmin: true,
            name: 'aName',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            operatingSystem: 'aOperatingSystem',
            type: 'aType',
            username: 'anUsername',
            isCurrentDevice: true,
            isBackupDevice: true,
          ),
        ),
      );
    });

    test('is correctly converted with property "lastLoginAt"', () {
      final json = {
        'id': 'anId',
        'isAdmin': true,
        'name': 'aName',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'lastLoginAt': '2023',
        'type': 'aType',
        'username': 'anUsername',
        'isCurrentDevice': true,
        'isBackupDevice': true,
      };
      expect(
        DeviceDTO.fromJson(json),
        equals(
          const DeviceDTO(
            id: 'anId',
            isAdmin: true,
            name: 'aName',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            lastLoginAt: '2023',
            type: 'aType',
            username: 'anUsername',
            isCurrentDevice: true,
            isBackupDevice: true,
          ),
        ),
      );
    });

    test('is correctly converted with properties "publicKey", "certificate", "description", "operatingSystem" and "lastLoginAt"', () {
      final json = {
        'id': 'anId',
        'isAdmin': true,
        'publicKey': 'aPublicKey',
        'certificate': 'aCertificate',
        'name': 'aName',
        'description': 'aDescription',
        'createdAt': '2023',
        'createdByDevice': 'aCreatorDeviceId',
        'operatingSystem': 'aOperatingSystem',
        'lastLoginAt': '2023',
        'type': 'aType',
        'username': 'anUsername',
        'isCurrentDevice': true,
        'isBackupDevice': true,
      };
      expect(
        DeviceDTO.fromJson(json),
        equals(
          const DeviceDTO(
            id: 'anId',
            isAdmin: true,
            publicKey: 'aPublicKey',
            certificate: 'aCertificate',
            name: 'aName',
            description: 'aDescription',
            createdAt: '2023',
            createdByDevice: 'aCreatorDeviceId',
            operatingSystem: 'aOperatingSystem',
            lastLoginAt: '2023',
            type: 'aType',
            username: 'anUsername',
            isCurrentDevice: true,
            isBackupDevice: true,
          ),
        ),
      );
    });
  });
}
