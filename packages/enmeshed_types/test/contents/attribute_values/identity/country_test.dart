import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Country(value: 'aCountry');
  group('Country to json', () {
    test('valid Country', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Country',
          'value': 'aCountry',
        }),
      );
    });
  });

  group('Country from json', () {
    test('valid Country', () {
      final json = {'value': 'aCountry'};
      expect(Country.fromJson(json), equals(identityAttributeValue));
    });
  });
}
