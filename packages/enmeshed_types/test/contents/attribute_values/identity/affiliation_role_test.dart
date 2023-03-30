import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = AffiliationRole(value: 'anAffiliationRole');
  group('AffiliationRole toJson', () {
    test('is correctly converted', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'AffiliationRole',
          'value': 'anAffiliationRole',
        }),
      );
    });
  });

  group('AffiliationRole fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'anAffiliationRole'};
      expect(AffiliationRole.fromJson(json), equals(identityAttributeValue));
    });
  });
}
