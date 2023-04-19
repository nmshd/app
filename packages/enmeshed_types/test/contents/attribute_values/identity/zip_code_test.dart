import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ZipCode toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = ZipCode(value: 'aZipCode');
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

  group('ZipCode fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aZipCode'};
      expect(ZipCode.fromJson(json), equals(const ZipCode(value: 'aZipCode')));
    });
  });
}
