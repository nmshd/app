import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('SexAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = SexAttributeValue(value: 'male');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Sex',
          'value': 'male',
        }),
      );
    });
  });

  group('SexAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'male'};
      expect(SexAttributeValue.fromJson(json), equals(const SexAttributeValue(value: 'male')));
    });
  });
}
