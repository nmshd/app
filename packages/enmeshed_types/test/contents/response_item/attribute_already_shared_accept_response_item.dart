import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AttributeAlreadySharedAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = AttributeAlreadySharedAcceptResponseItem(
        attributeId: 'anAttributeId',
      );
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({
          '@type': 'AttributeAlreadySharedAcceptResponseItem',
          'result': 'Accepted',
          'attributeId': 'anAttributeId',
        }),
      );
    });
  });

  group('AttributeAlreadySharedAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {
        'attributeId': 'anAttributeId',
      };
      expect(
        AttributeAlreadySharedAcceptResponseItem.fromJson(json),
        equals(const AttributeAlreadySharedAcceptResponseItem(
          attributeId: 'anAttributeId',
        )),
      );
    });
  });
}
