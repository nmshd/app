import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Citizenship(value: 'DE');
  group('Citizenship to json', () {
    test('valid Citizenship', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Citizenship',
          'value': 'DE',
        }),
      );
    });
  });

  group('Citizenship from json', () {
    test('valid Citizenship', () {
      final json = {'value': 'DE'};
      expect(Citizenship.fromJson(json), equals(identityAttributeValue));
    });
  });
}
