import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthPlace toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthPlace(city: 'aCity', country: 'aCountry');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthPlace', 'city': 'aCity', 'country': 'aCountry'}),
      );
    });

    test('is correctly converted with property "state"', () {
      const identityAttributeValue = BirthPlace(city: 'aCity', country: 'aCountry', state: 'aState');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthPlace', 'city': 'aCity', 'country': 'aCountry', 'state': 'aState'}),
      );
    });
  });

  group('BirthPlace fromJson', () {
    test('is correctly converted', () {
      final json = {'city': 'aCity', 'country': 'aCountry'};
      expect(BirthPlace.fromJson(json), equals(const BirthPlace(city: 'aCity', country: 'aCountry')));
    });

    test('is correctly converted with property "state"', () {
      final json = {'city': 'aCity', 'country': 'aCountry', 'state': 'aState'};
      expect(BirthPlace.fromJson(json), equals(const BirthPlace(city: 'aCity', country: 'aCountry', state: 'aState')));
    });
  });
}
