import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = AffiliationUnit(value: 'anAffiliationUnit');
  group('AffiliationUnit toJson', () {
    test('is correctly converted', () {
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

  group('AffiliationUnit fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'anAffiliationUnit'};
      expect(AffiliationUnit.fromJson(json), equals(identityAttributeValue));
    });
  });
}
