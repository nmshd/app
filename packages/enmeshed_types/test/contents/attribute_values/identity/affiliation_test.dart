import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Affiliation toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = AffiliationAttributeValue(role: 'aRole', organization: 'anOrganization', unit: 'anUnit');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Affiliation',
          'role': 'aRole',
          'organization': 'anOrganization',
          'unit': 'anUnit',
        }),
      );
    });
  });

  group('Affiliation fromJson', () {
    test('is correctly converted', () {
      final json = {
        'role': 'aRole',
        'organization': 'anOrganization',
        'unit': 'anUnit',
      };
      expect(
        AffiliationAttributeValue.fromJson(json),
        equals(const AffiliationAttributeValue(role: 'aRole', organization: 'anOrganization', unit: 'anUnit')),
      );
    });
  });
}
