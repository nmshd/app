import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('IdentityDTO toJson', () {
    test('is correctly converted', () {
      const dto = IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey');
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({'address': 'anAddress', 'publicKey': 'aPublicKey'}),
      );
    });
  });

  group('IdentityDTO fromJson', () {
    test('is correctly converted', () {
      final json = {'address': 'anAddress', 'publicKey': 'aPublicKey'};
      expect(
        IdentityDTO.fromJson(json),
        equals(const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey')),
      );
    });
  });
}
