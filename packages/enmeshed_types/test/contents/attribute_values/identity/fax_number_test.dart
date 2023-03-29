import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = FaxNumber(value: '0123456789');
  group('Fax Number to json', () {
    test('valid FaxNumber', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'FaxNumber',
          'value': '0123456789',
        }),
      );
    });
  });

  group('Fax Number from json', () {
    test('valid FaxNumber', () {
      final json = {'value': '0123456789'};
      expect(FaxNumber.fromJson(json), equals(identityAttributeValue));
    });
  });
}
