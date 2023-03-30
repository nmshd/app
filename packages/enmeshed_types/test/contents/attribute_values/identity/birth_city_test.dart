import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthCity(value: 'aBirthCity');
  group('BirthCity toJson', () {
    test('is correctly converted', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthCity',
          'value': 'aBirthCity',
        }),
      );
    });
  });

  group('BirthCity fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aBirthCity'};
      expect(BirthCity.fromJson(json), equals(identityAttributeValue));
    });
  });
}
