import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = City(value: 'aCity');
  group('City to json', () {
    test('valid City', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'City',
          'value': 'aCity',
        }),
      );
    });
  });

  group('City from json', () {
    test('valid City', () {
      final json = {'value': 'aCity'};
      expect(City.fromJson(json), equals(identityAttributeValue));
    });
  });
}
