import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthNameAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthNameAttributeValue(value: 'aBirthName');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'BirthName', 'value': 'aBirthName'}));
    });
  });

  group('BirthNameAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aBirthName'};
      expect(BirthNameAttributeValue.fromJson(json), equals(const BirthNameAttributeValue(value: 'aBirthName')));
    });
  });
}
