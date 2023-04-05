import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProposeAttributeAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = ProposeAttributeAcceptResponseItem(
        attributeId: 'anAttributeId',
        attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
      );
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({
          '@type': 'ProposeAttributeAcceptResponseItem',
          'result': 'Accepted',
          'attributeId': 'anAttributeId',
          'attribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
        }),
      );
    });
  });

  group('ProposeAttributeAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {
        'attributeId': 'anAttributeId',
        'attribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
      };
      expect(
        ProposeAttributeAcceptResponseItem.fromJson(json),
        equals(const ProposeAttributeAcceptResponseItem(
          attributeId: 'anAttributeId',
          attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
        )),
      );
    });
  });
}
