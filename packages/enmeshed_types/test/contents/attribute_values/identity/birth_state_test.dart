import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthStateAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthStateAttributeValue(value: 'aBirthState');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'BirthState', 'value': 'aBirthState'}));
    });
  });

  group('BirthStateAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aBirthState'};
      expect(BirthStateAttributeValue.fromJson(json), equals(const BirthStateAttributeValue(value: 'aBirthState')));
    });
  });
}
