import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ReadAttributeAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = ReadAttributeAcceptResponseItem(
        attributeId: 'anAttributeId',
        attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
      );
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({
          '@type': 'ReadAttributeAcceptResponseItem',
          'result': 'Accepted',
          'attributeId': 'anAttributeId',
          'attribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
        }),
      );
    });
  });

  group('ReadAttributeAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {
        'attributeId': 'anAttributeId',
        'attribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
      };
      expect(
        ReadAttributeAcceptResponseItem.fromJson(json),
        equals(const ReadAttributeAcceptResponseItem(
          attributeId: 'anAttributeId',
          attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
        )),
      );
    });
  });
}
