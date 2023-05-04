import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthName toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthNameAttributeValue(value: 'aBirthName');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthName',
          'value': 'aBirthName',
        }),
      );
    });
  });

  group('BirthName fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aBirthName'};
      expect(BirthNameAttributeValue.fromJson(json), equals(const BirthNameAttributeValue(value: 'aBirthName')));
    });
  });
}
