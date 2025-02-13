import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('HouseNumberAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = HouseNumberAttributeValue(value: 'aHouseNumber');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'HouseNumber', 'value': 'aHouseNumber'}));
    });
  });

  group('HouseNumberAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aHouseNumber'};
      expect(HouseNumberAttributeValue.fromJson(json), equals(const HouseNumberAttributeValue(value: 'aHouseNumber')));
    });
  });
}
