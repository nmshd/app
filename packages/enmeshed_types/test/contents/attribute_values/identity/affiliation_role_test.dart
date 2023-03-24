import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = AffiliationRole(value: 'anAffiliationRole');
  group('Affiliation Role to json', () {
    test('valid AffiliationRole', () {
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

  group('Affiliation Role from json', () {
    test('valid AffiliationRole', () {
      final json = {'value': 'anAffiliationRole'};
      expect(AffiliationRole.fromJson(json), equals(identityAttributeValue));
    });
  });
}
