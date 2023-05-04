import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthPlaceAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthPlaceAttributeValue(city: 'aCity', country: 'aCountry');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthPlace', 'city': 'aCity', 'country': 'aCountry'}),
      );
    });

    test('is correctly converted with property "state"', () {
      const identityAttributeValue = BirthPlaceAttributeValue(city: 'aCity', country: 'aCountry', state: 'aState');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthPlace', 'city': 'aCity', 'country': 'aCountry', 'state': 'aState'}),
      );
    });
  });

  group('BirthPlaceAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'city': 'aCity', 'country': 'aCountry'};
      expect(BirthPlaceAttributeValue.fromJson(json), equals(const BirthPlaceAttributeValue(city: 'aCity', country: 'aCountry')));
    });

    test('is correctly converted with property "state"', () {
      final json = {'city': 'aCity', 'country': 'aCountry', 'state': 'aState'};
      expect(BirthPlaceAttributeValue.fromJson(json), equals(const BirthPlaceAttributeValue(city: 'aCity', country: 'aCountry', state: 'aState')));
    });
  });
}
