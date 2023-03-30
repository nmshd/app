import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Surname(value: 'aSurname');
  group('Surname toJson', () {
    test('is correctly converted', () {
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

  group('Surname fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aSurname'};
      expect(Surname.fromJson(json), equals(identityAttributeValue));
    });
  });
}
