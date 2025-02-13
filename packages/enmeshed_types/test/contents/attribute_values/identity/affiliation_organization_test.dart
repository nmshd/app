import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AffiliationOrganizationAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = AffiliationOrganizationAttributeValue(value: 'anAffiliationOrganization');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'AffiliationOrganization', 'value': 'anAffiliationOrganization'}));
    });
  });

  group('AffiliationOrganizationAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'anAffiliationOrganization'};
      expect(
        AffiliationOrganizationAttributeValue.fromJson(json),
        equals(const AffiliationOrganizationAttributeValue(value: 'anAffiliationOrganization')),
      );
    });
  });
}
