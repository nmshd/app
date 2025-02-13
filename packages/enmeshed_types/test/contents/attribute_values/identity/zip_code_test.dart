import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ZipCodeAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = ZipCodeAttributeValue(value: 'aZipCode');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'ZipCode', 'value': 'aZipCode'}));
    });
  });

  group('ZipCodeAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aZipCode'};
      expect(ZipCodeAttributeValue.fromJson(json), equals(const ZipCodeAttributeValue(value: 'aZipCode')));
    });
  });
}
