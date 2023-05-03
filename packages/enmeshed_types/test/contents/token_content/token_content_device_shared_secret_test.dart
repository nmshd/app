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
    identity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey', realm: 'aRealm'),
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
    });
  });
}
