import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthYearAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthYearAttributeValue(value: 1970);
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'BirthYear', 'value': 1970}));
    });
  });

  group('BirthYearAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 1970};
      expect(BirthYearAttributeValue.fromJson(json), equals(const BirthYearAttributeValue(value: 1970)));
    });
  });
}
