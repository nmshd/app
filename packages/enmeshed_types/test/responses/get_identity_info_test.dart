import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('GetIdentityInfoResponse toJson', () {
    test('is correctly converted', () {
      const response = GetIdentityInfoResponse(address: 'anAddress', publicKey: 'aPublicKey');
      final responseJson = response.toJson();
      expect(
        responseJson,
        equals({'address': 'anAddress', 'publicKey': 'aPublicKey'}),
      );
    });
  });

  group('GetIdentityInfoResponse fromJson', () {
    test('is correctly converted', () {
      final json = {'address': 'anAddress', 'publicKey': 'aPublicKey'};
      expect(
        GetIdentityInfoResponse.fromJson(json),
        equals(const GetIdentityInfoResponse(address: 'anAddress', publicKey: 'aPublicKey')),
      );
    });
  });
}
