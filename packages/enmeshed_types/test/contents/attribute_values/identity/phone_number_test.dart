import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = PhoneNumber(value: 'aPhoneNumber');
  group('Phone Number to json', () {
    test('valid PhoneNumber', () {
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

  group('Phone Number from json', () {
    test('valid PhoneNumber', () {
      final json = {'value': 'aPhoneNumber'};
      expect(PhoneNumber.fromJson(json), equals(identityAttributeValue));
    });
  });
}
