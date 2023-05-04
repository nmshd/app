import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthCityAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthCityAttributeValue(value: 'aBirthCity');
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

  group('BirthCityAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aBirthCity'};
      expect(BirthCityAttributeValue.fromJson(json), equals(const BirthCityAttributeValue(value: 'aBirthCity')));
    });
  });
}
