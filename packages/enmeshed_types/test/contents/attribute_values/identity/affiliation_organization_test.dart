import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = AffiliationOrganization(value: 'anAffiliationOrganization');
  group('Affiliation Organization to json', () {
    test('valid AffiliationOrganization', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'AffiliationOrganization',
          'value': 'anAffiliationOrganization',
        }),
      );
    });
  });

  group('Affiliation Organization from json', () {
    test('valid AffiliationOrganization', () {
      final json = {'value': 'anAffiliationOrganization'};
      expect(AffiliationOrganization.fromJson(json), equals(identityAttributeValue));
    });
  });
}
