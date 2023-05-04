import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthCountry toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthCountryAttributeValue(value: 'aBirthCountry');
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

  group('BirthCountry fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aBirthCountry'};
      expect(BirthCountryAttributeValue.fromJson(json), equals(const BirthCountryAttributeValue(value: 'aBirthCountry')));
    });
  });
}
