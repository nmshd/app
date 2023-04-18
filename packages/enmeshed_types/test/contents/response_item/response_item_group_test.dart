import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ResponseItemGroup toJson', () {
    test('is correctly converted', () {
      const responseItemGroup = ResponseItemGroup(
        items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
      );
      final responseItemGroupJson = responseItemGroup.toJson();
      expect(
        responseItemGroupJson,
        equals({
          '@type': 'ResponseItemGroup',
          'result': 'Accepted',
          'items': [const CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId').toJson()],
        }),
      );
    });
  });

  group('ResponseItemGroup fromJson', () {
    test('is correctly converted', () {
      final json = {
        'result': 'Accepted',
        'items': [const CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId').toJson()],
      };
      expect(
        ResponseItemGroup.fromJson(json),
        equals(const ResponseItemGroup(
          items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
        )),
      );
    });
  });
}
