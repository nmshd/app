import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Country toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = Country(value: 'aCountry');
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
      expect(Country.fromJson(json), equals(const Country(value: 'aCountry')));
    });
  });
}
