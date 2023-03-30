import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = FileReference(value: 'aFileReference');
  group('FileReference toJson', () {
    test('is correctly converted', () {
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

  group('FileReference fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aFileReference'};
      expect(FileReference.fromJson(json), equals(identityAttributeValue));
    });
  });
}
