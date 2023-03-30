import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Nationality(value: 'DE');
  group('Nationality toJson', () {
    test('is correctly converted', () {
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

  group('Nationality fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'DE'};
      expect(Nationality.fromJson(json), equals(identityAttributeValue));
    });
  });
}
