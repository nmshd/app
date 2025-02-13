import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('CityAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = CityAttributeValue(value: 'aCity');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'City', 'value': 'aCity'}));
    });
  });

  group('CityAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aCity'};
      expect(CityAttributeValue.fromJson(json), equals(const CityAttributeValue(value: 'aCity')));
    });
  });
}
