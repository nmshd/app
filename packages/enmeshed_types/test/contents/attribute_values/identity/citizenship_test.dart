import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Citizenship toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = CitizenshipAttributeValue(value: 'DE');
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

  group('Citizenship fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'DE'};
      expect(CitizenshipAttributeValue.fromJson(json), equals(const CitizenshipAttributeValue(value: 'DE')));
    });
  });
}
