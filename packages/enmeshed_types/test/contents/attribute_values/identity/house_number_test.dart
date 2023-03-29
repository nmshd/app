import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = HouseNumber(value: 'aHouseNumber');
  group('House Number to json', () {
    test('valid HouseNumber', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'HouseNumber',
          'value': 'aHouseNumber',
        }),
      );
    });
  });

  group('House Number from json', () {
    test('valid HouseNumber', () {
      final json = {'value': 'aHouseNumber'};
      expect(HouseNumber.fromJson(json), equals(identityAttributeValue));
    });
  });
}
