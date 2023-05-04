import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('DisplayName toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = DisplayNameAttributeValue(value: 'aDisplayName');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'DisplayName',
          'value': 'aDisplayName',
        }),
      );
    });
  });

  group('DisplayName fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aDisplayName'};
      expect(DisplayNameAttributeValue.fromJson(json), equals(const DisplayNameAttributeValue(value: 'aDisplayName')));
    });
  });
}
