import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = FileReference(value: 'aFileReference');
  group('File Reference to json', () {
    test('valid FileReference', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'FileReference',
          'value': 'aFileReference',
        }),
      );
    });
  });

  group('File Reference from json', () {
    test('valid FileReference', () {
      final json = {'value': 'aFileReference'};
      expect(FileReference.fromJson(json), equals(identityAttributeValue));
    });
  });
}
