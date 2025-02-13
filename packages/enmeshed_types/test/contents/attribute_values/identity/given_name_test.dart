import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('GivenNameAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = GivenNameAttributeValue(value: 'aGivenName');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'GivenName', 'value': 'aGivenName'}));
    });
  });

  group('GivenNameAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aGivenName'};
      expect(GivenNameAttributeValue.fromJson(json), equals(const GivenNameAttributeValue(value: 'aGivenName')));
    });
  });
}
