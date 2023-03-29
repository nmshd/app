import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = GivenName(value: 'aGivenName');
  group('Given Name to json', () {
    test('valid GivenName', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'GivenName',
          'value': 'aGivenName',
        }),
      );
    });
  });

  group('Given Name from json', () {
    test('valid GivenName', () {
      final json = {'value': 'aGivenName'};
      expect(GivenName.fromJson(json), equals(identityAttributeValue));
    });
  });
}
