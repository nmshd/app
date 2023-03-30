import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Country(value: 'aCountry');
  group('Country toJson', () {
    test('is correctly converted', () {
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

  group('Country fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aCountry'};
      expect(Country.fromJson(json), equals(identityAttributeValue));
    });
  });
}
