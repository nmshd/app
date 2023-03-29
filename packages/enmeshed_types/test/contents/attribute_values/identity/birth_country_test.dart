import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthCountry(value: 'aBirthCountry');
  group('Birth Country to json', () {
    test('valid BirthCountry', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthCountry',
          'value': 'aBirthCountry',
        }),
      );
    });
  });

  group('Birth Country from json', () {
    test('valid BirthCountry', () {
      final json = {'value': 'aBirthCountry'};
      expect(BirthCountry.fromJson(json), equals(identityAttributeValue));
    });
  });
}
