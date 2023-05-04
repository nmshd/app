import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('HonorificPrefix toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = HonorificPrefixAttributeValue(value: 'aHonorificPrefix');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'HonorificPrefix',
          'value': 'aHonorificPrefix',
        }),
      );
    });
  });

  group('HonorificPrefix fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aHonorificPrefix'};
      expect(HonorificPrefixAttributeValue.fromJson(json), equals(const HonorificPrefixAttributeValue(value: 'aHonorificPrefix')));
    });
  });
}
