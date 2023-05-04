import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Nationality toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = NationalityAttributeValue(value: 'DE');
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
      expect(NationalityAttributeValue.fromJson(json), equals(const NationalityAttributeValue(value: 'DE')));
    });
  });
}
