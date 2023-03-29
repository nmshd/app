import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Birth Place to json', () {
    test('valid BirthPlace', () {
      const identityAttributeValue = BirthPlace(city: 'aCity', country: 'aCountry');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthPlace', 'city': 'aCity', 'country': 'aCountry'}),
      );
    });

    test('valid BirthPlace with state', () {
      const identityAttributeValue = BirthPlace(city: 'aCity', country: 'aCountry', state: 'aState');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthPlace', 'city': 'aCity', 'country': 'aCountry', 'state': 'aState'}),
      );
    });
  });

  group('Birth Place from json', () {
    test('valid BirthPlace', () {
      final json = {'city': 'aCity', 'country': 'aCountry'};
      expect(BirthPlace.fromJson(json), equals(const BirthPlace(city: 'aCity', country: 'aCountry')));
    });

    test('valid BirthPlace with state', () {
      final json = {'city': 'aCity', 'country': 'aCountry', 'state': 'aState'};
      expect(BirthPlace.fromJson(json), equals(const BirthPlace(city: 'aCity', country: 'aCountry', state: 'aState')));
    });
  });
}
