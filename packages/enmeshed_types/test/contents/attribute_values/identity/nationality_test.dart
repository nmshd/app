import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Nationality(value: 'DE');
  group('Nationality to json', () {
    test('valid Nationality', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Nationality',
          'value': 'DE',
        }),
      );
    });
  });

  group('Nationality from json', () {
    test('valid Nationality', () {
      final json = {'value': 'DE'};
      expect(Nationality.fromJson(json), equals(identityAttributeValue));
    });
  });
}
