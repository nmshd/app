import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('HonorificSuffix toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = HonorificSuffix(value: 'aHonorificSuffix');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'HonorificSuffix',
          'value': 'aHonorificSuffix',
        }),
      );
    });
  });

  group('HonorificSuffix fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aHonorificSuffix'};
      expect(HonorificSuffix.fromJson(json), equals(const HonorificSuffix(value: 'aHonorificSuffix')));
    });
  });
}
