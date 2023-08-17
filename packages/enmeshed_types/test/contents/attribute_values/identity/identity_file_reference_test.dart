import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('IdentityFileReferenceAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = IdentityFileReferenceAttributeValue(value: 'aFileReference');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'IdentityFileReference',
          'value': 'aFileReference',
        }),
      );
    });
  });

  group('IdentityFileReferenceAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aFileReference'};
      expect(IdentityFileReferenceAttributeValue.fromJson(json), equals(const IdentityFileReferenceAttributeValue(value: 'aFileReference')));
    });
  });
}
