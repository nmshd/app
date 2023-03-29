import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = MiddleName(value: 'aMiddleName');
  group('Middle Name to json', () {
    test('valid MiddleName', () {
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

  group('Middle Name from json', () {
    test('valid MiddleName', () {
      final json = {'value': 'aMiddleName'};
      expect(MiddleName.fromJson(json), equals(identityAttributeValue));
    });
  });
}
