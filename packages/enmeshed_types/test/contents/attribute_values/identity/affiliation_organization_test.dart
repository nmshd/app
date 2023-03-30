import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = AffiliationOrganization(value: 'anAffiliationOrganization');
  group('AffiliationOrganization toJson', () {
    test('is correctly converted', () {
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

  group('AffiliationOrganization fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'anAffiliationOrganization'};
      expect(AffiliationOrganization.fromJson(json), equals(identityAttributeValue));
    });
  });
}
