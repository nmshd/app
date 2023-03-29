import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Surname(value: 'aSurname');
  group('Surname to json', () {
    test('valid Surname', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Surname',
          'value': 'aSurname',
        }),
      );
    });
  });

  group('Surname from json', () {
    test('valid Surname', () {
      final json = {'value': 'aSurname'};
      expect(Surname.fromJson(json), equals(identityAttributeValue));
    });
  });
}
