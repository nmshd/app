import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = DisplayName(value: 'aDisplayName');
  group('Display Name to json', () {
    test('valid DisplayName', () {
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

  group('Display Name from json', () {
    test('valid DisplayName', () {
      final json = {'value': 'aDisplayName'};
      expect(DisplayName.fromJson(json), equals(identityAttributeValue));
    });
  });
}
