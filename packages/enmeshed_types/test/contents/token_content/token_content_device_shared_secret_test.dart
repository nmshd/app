import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const sharedSecret = DeviceSharedSecret(
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

  group('TokenContentDeviceSharedSecret toJson', () {
    test('is correctly converted', () {
      const content = TokenContentDeviceSharedSecret(sharedSecret: sharedSecret);

      final json = content.toJson();
      expect(json, {
        '@type': 'TokenContentDeviceSharedSecret',
        'sharedSecret': sharedSecret.toJson(),
      });
    });
  });

  group('TokenContentDeviceSharedSecret fromJson', () {
    test('is correctly converted', () {
      final json = {
        '@type': 'TokenContentDeviceSharedSecret',
        'sharedSecret': sharedSecret.toJson(),
      };

      final content = TokenContent.fromJson(json);
      expect(content, isA<TokenContentDeviceSharedSecret>());
      expect((content as TokenContentDeviceSharedSecret).sharedSecret, equals(sharedSecret));
    });

    test('is correctly converted with json as keys', () {
      final json = {
        '@type': 'TokenContentDeviceSharedSecret',
        'sharedSecret': {
          'id': 'anId',
          'createdAt': 'aDate',
          'createdByDevice': 'aDeviceId',
          'secretBaseKey': {'a': 'b'},
          'deviceIndex': 0,
          'synchronizationKey': {'a': 'b'},
          'identityPrivateKey': {'a': 'b'},
          'identity': {
            'address': 'anAddress',
            'publicKey': {'a': 'b'},
            'realm': 'aRealm',
          },
          'password': 'aPassword',
          'username': 'aUsername',
        },
      };

      final content = TokenContent.fromJson(json);
      expect(content, isA<TokenContentDeviceSharedSecret>());
      expect(
        (content as TokenContentDeviceSharedSecret).sharedSecret,
        equals(
          const DeviceSharedSecret(
            id: 'anId',
            createdAt: 'aDate',
            createdByDevice: 'aDeviceId',
            secretBaseKey: 'eyJhIjoiYiJ9',
            deviceIndex: 0,
            synchronizationKey: 'eyJhIjoiYiJ9',
            identityPrivateKey: 'eyJhIjoiYiJ9',
            identity: IdentityDTO(address: 'anAddress', publicKey: 'eyJhIjoiYiJ9'),
            password: 'aPassword',
            username: 'aUsername',
          ),
        ),
      );
    });
  });
}
