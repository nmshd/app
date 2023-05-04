import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AffiliationUnit toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = AffiliationUnitAttributeValue(value: 'anAffiliationUnit');
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
      expect(AffiliationUnitAttributeValue.fromJson(json), equals(const AffiliationUnitAttributeValue(value: 'anAffiliationUnit')));
    });
  });
}
