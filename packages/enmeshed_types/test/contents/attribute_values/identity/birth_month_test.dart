import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthMonth(value: 01);
  group('Birth Month to json', () {
    test('valid BirthMonth', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthMonth',
          'value': 01,
        }),
      );
    });
  });

  group('Birth Month from json', () {
    test('valid BirthMonth', () {
      final json = {'value': 01};
      expect(BirthMonth.fromJson(json), equals(identityAttributeValue));
    });
  });
}
