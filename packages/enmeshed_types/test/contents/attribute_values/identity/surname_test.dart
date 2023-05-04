import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Surname toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = SurnameAttributeValue(value: 'aSurname');
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
      expect(SurnameAttributeValue.fromJson(json), equals(const SurnameAttributeValue(value: 'aSurname')));
    });
  });
}
