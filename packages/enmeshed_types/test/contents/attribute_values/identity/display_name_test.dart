import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = DisplayName(value: 'aDisplayName');
  group('DisplayName toJson', () {
    test('is correctly converted', () {
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
      expect(DisplayName.fromJson(json), equals(identityAttributeValue));
    });
  });
}
