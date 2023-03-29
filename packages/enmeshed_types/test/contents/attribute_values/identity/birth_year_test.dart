import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthYear(value: 1970);
  group('Birth Year to json', () {
    test('valid BirthYear', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthYear',
          'value': 1970,
        }),
      );
    });
  });

  group('Birth Year from json', () {
    test('valid BirthYear', () {
      final json = {'value': 1970};
      expect(BirthYear.fromJson(json), equals(identityAttributeValue));
    });
  });
}
