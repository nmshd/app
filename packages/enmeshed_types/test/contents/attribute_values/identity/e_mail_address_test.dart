import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = EMailAddress(value: 'test@test.com');
  group('E-Mail Address to json', () {
    test('valid EMailAddress', () {
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

  group('E-Mail Address from json', () {
    test('valid EMailAddress', () {
      final json = {'value': 'test@test.com'};
      expect(EMailAddress.fromJson(json), equals(identityAttributeValue));
    });
  });
}
