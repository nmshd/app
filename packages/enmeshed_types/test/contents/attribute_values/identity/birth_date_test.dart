import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthDateAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthDateAttributeValue(day: 01, month: 01, year: 1970);
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthDate', 'day': 01, 'month': 01, 'year': 1970}),
      );
    });
  });

  group('BirthDateAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'day': 01, 'month': 01, 'year': 1970};
      expect(BirthDateAttributeValue.fromJson(json), equals(const BirthDateAttributeValue(day: 01, month: 01, year: 1970)));
    });
  });
}
