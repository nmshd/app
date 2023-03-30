import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = City(value: 'aCity');
  group('City toJson', () {
    test('is correctly converted', () {
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

  group('City fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aCity'};
      expect(City.fromJson(json), equals(identityAttributeValue));
    });
  });
}
