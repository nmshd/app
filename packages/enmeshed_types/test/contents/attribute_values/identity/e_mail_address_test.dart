import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('EMailAddressAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = EMailAddressAttributeValue(value: 'test@test.com');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'EMailAddress',
          'value': 'test@test.com',
        }),
      );
    });
  });

  group('EMailAddressAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'test@test.com'};
      expect(EMailAddressAttributeValue.fromJson(json), equals(const EMailAddressAttributeValue(value: 'test@test.com')));
    });
  });
}
