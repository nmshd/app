import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AffiliationRoleAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = AffiliationRoleAttributeValue(value: 'anAffiliationRole');
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

  group('AffiliationRoleAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'anAffiliationRole'};
      expect(AffiliationRoleAttributeValue.fromJson(json), equals(const AffiliationRoleAttributeValue(value: 'anAffiliationRole')));
    });
  });
}
