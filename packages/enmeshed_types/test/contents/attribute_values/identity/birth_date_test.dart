import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthDate(day: 01, month: 01, year: 1970);
  group('Birth Date to json', () {
    test('valid BirthDate', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'BirthDate', 'day': 01, 'month': 01, 'year': 1970}),
      );
    });
  });

  group('Birth Date from json', () {
    test('valid BirthDate', () {
      final json = {'day': 01, 'month': 01, 'year': 1970};
      expect(BirthDate.fromJson(json), equals(identityAttributeValue));
    });
  });
}
