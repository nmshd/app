import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthCity(value: 'aBirthCity');
  group('Birth City to json', () {
    test('valid BirthCity', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthCity',
          'value': 'aBirthCity',
        }),
      );
    });
  });

  group('Birth City from json', () {
    test('valid BirthCity', () {
      final json = {'value': 'aBirthCity'};
      expect(BirthCity.fromJson(json), equals(identityAttributeValue));
    });
  });
}
