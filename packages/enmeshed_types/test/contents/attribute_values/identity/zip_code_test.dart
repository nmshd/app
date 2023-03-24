import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = ZipCode(value: 'aZipCode');
  group('Zip Code to json', () {
    test('valid ZipCode', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'ZipCode',
          'value': 'aZipCode',
        }),
      );
    });
  });

  group('Zip Code from json', () {
    test('valid ZipCode', () {
      final json = {'value': 'aZipCode'};
      expect(ZipCode.fromJson(json), equals(identityAttributeValue));
    });
  });
}
