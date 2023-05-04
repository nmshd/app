import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumber toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = PhoneNumberAttributeValue(value: 'aPhoneNumber');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'PhoneNumber',
          'value': 'aPhoneNumber',
        }),
      );
    });
  });

  group('PhoneNumber fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aPhoneNumber'};
      expect(PhoneNumberAttributeValue.fromJson(json), equals(const PhoneNumberAttributeValue(value: 'aPhoneNumber')));
    });
  });
}
