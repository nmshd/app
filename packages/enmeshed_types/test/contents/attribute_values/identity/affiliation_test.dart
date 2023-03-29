import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Affiliation(role: 'aRole', organization: 'anOrganization', unit: 'anUnit');
  group('Affiliation to json', () {
    test('valid Affiliation', () {
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

  group('Affiliation from json', () {
    test('valid Affiliation', () {
      final json = {
        'role': 'aRole',
        'organization': 'anOrganization',
        'unit': 'anUnit',
      };
      expect(Affiliation.fromJson(json), equals(identityAttributeValue));
    });
  });
}
