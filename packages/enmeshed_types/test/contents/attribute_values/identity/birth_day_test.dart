import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthDay(value: 01);
  group('Birth Day to json', () {
    test('valid BirthDay', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthDay',
          'value': 01,
        }),
      );
    });
  });

  group('Birth Day from json', () {
    test('valid BirthDay', () {
      final json = {'value': 01};
      expect(BirthDay.fromJson(json), equals(identityAttributeValue));
    });
  });
}
