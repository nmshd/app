import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthDate toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthDate(day: 01, month: 01, year: 1970);
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthDate', 'day': 01, 'month': 01, 'year': 1970}),
      );
    });
  });

  group('BirthDate fromJson', () {
    test('is correctly converted', () {
      final json = {'day': 01, 'month': 01, 'year': 1970};
      expect(BirthDate.fromJson(json), equals(const BirthDate(day: 01, month: 01, year: 1970)));
    });
  });
}
