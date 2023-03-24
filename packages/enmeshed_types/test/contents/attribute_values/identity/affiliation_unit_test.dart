import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = AffiliationUnit(value: 'anAffiliationUnit');
  group('Affiliation Unit to json', () {
    test('valid AffiliationUnit', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'AffiliationUnit',
          'value': 'anAffiliationUnit',
        }),
      );
    });
  });

  group('Affiliation Unit from json', () {
    test('valid AffiliationUnit', () {
      final json = {'value': 'anAffiliationUnit'};
      expect(AffiliationUnit.fromJson(json), equals(identityAttributeValue));
    });
  });
}
