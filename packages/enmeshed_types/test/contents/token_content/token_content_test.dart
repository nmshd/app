import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('TokenContent fromJson', () {
    test('parsed valid ArbitraryTokenContent', () {
      final json = {'akey': 'aValue'};
      final content = TokenContent.fromJson(json);
      expect(content, isA<ArbitraryTokenContent>());
    });

    test('parsed valid TokenContentDeviceSharedSecret', () {
      final json = {
        '@type': 'TokenContentDeviceSharedSecret',
        'sharedSecret':
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
            ).toJson(),
      };

      final content = TokenContent.fromJson(json);
      expect(content, isA<TokenContentDeviceSharedSecret>());
    });
  });
}
