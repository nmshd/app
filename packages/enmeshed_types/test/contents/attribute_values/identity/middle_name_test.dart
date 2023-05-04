import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('MiddleName toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = MiddleNameAttributeValue(value: 'aMiddleName');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'MiddleName',
          'value': 'aMiddleName',
        }),
      );
    });
  });

  group('MiddleName fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aMiddleName'};
      expect(MiddleNameAttributeValue.fromJson(json), equals(const MiddleNameAttributeValue(value: 'aMiddleName')));
    });
  });
}
