import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('CreateAttributeAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId');
      final responseItemJson = responseItem.toJson();
      expect(responseItemJson, equals({'@type': 'CreateAttributeAcceptResponseItem', 'result': 'Accepted', 'attributeId': 'anAttributeId'}));
    });
  });

  group('CreateAttributeAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {'attributeId': 'anAttributeId'};
      expect(CreateAttributeAcceptResponseItem.fromJson(json), equals(const CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')));
    });
  });
}
