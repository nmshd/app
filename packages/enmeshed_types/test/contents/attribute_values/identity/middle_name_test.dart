import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = MiddleName(value: 'aMiddleName');
  group('MiddleName toJson', () {
    test('is correctly converted', () {
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
      expect(MiddleName.fromJson(json), equals(identityAttributeValue));
    });
  });
}
