import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('CountryAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = CountryAttributeValue(value: 'aCountry');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'Country', 'value': 'aCountry'}));
    });
  });

  group('CountryAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aCountry'};
      expect(CountryAttributeValue.fromJson(json), equals(const CountryAttributeValue(value: 'aCountry')));
    });
  });
}
