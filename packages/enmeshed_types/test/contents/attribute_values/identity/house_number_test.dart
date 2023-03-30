import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = HouseNumber(value: 'aHouseNumber');
  group('HouseNumber toJson', () {
    test('is correctly converted', () {
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

  group('HouseNumber fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aHouseNumber'};
      expect(HouseNumber.fromJson(json), equals(identityAttributeValue));
    });
  });
}
