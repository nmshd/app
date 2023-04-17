import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LocalAccountDTO fromJson', () {
    test('is correctly converted', () {
      final json = {'id': 'anId', 'address': 'anAddress', 'name': 'aName', 'realm': 'aRealm', 'directory': 'aDirectory', 'order': 1};
      expect(
        LocalAccountDTO.fromJson(json),
        equals(const LocalAccountDTO(id: 'anId', address: 'anAddress', name: 'aName', realm: 'aRealm', directory: 'aDirectory', order: 1)),
      );
    });
  });
}
