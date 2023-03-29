import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = HonorificPrefix(value: 'aHonorificPrefix');
  group('Honorific Prefix to json', () {
    test('valid HonorificPrefix', () {
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

  group('Honorific Prefix from json', () {
    test('valid HonorificPrefix', () {
      final json = {'value': 'aHonorificPrefix'};
      expect(HonorificPrefix.fromJson(json), equals(identityAttributeValue));
    });
  });
}
