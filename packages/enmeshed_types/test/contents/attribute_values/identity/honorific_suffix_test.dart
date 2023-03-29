import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = HonorificSuffix(value: 'aHonorificSuffix');
  group('Honorific Suffix to json', () {
    test('valid HonorificSuffix', () {
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

  group('Honorific Suffix from json', () {
    test('valid HonorificSuffix', () {
      final json = {'value': 'aHonorificSuffix'};
      expect(HonorificSuffix.fromJson(json), equals(identityAttributeValue));
    });
  });
}
