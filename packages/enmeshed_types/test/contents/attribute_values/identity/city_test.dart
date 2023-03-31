import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('City toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = City(value: 'aCity');
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
      expect(City.fromJson(json), equals(const City(value: 'aCity')));
    });
  });
}
