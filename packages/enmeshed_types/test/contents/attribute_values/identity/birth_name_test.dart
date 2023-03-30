import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthName(value: 'aBirthName');
  group('Birth Name to json', () {
    test('valid BirthName', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthName',
          'value': 'aBirthName',
        }),
      );
    });
  });

  group('Birth Name from json', () {
    test('valid BirthName', () {
      final json = {'value': 'aBirthName'};
      expect(BirthName.fromJson(json), equals(identityAttributeValue));
    });
  });
}
