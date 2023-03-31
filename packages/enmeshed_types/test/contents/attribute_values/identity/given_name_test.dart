import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('GivenName toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = GivenName(value: 'aGivenName');
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

  group('GivenName fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aGivenName'};
      expect(GivenName.fromJson(json), equals(const GivenName(value: 'aGivenName')));
    });
  });
}
