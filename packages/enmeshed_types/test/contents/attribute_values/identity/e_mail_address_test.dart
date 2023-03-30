import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = EMailAddress(value: 'test@test.com');
  group('EMailAddress toJson', () {
    test('is correctly converted', () {
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

  group('EMailAddress fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'test@test.com'};
      expect(EMailAddress.fromJson(json), equals(identityAttributeValue));
    });
  });
}
