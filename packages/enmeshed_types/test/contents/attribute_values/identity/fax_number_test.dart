import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('FaxNumberAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = FaxNumberAttributeValue(value: '0123456789');
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

  group('FaxNumberAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': '0123456789'};
      expect(FaxNumberAttributeValue.fromJson(json), equals(const FaxNumberAttributeValue(value: '0123456789')));
    });
  });
}
