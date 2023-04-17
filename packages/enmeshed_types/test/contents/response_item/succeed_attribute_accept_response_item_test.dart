import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('SucceedAttributeAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = SucceedAttributeAcceptResponseItem(attributeId: 'anAttributeId');
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({'@type': 'SucceedAttributeAcceptResponseItem', 'result': 'Accepted', 'attributeId': 'anAttributeId'}),
      );
    });
  });

  group('SucceedAttributeAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {'attributeId': 'anAttributeId'};
      expect(
        SucceedAttributeAcceptResponseItem.fromJson(json),
        equals(const SucceedAttributeAcceptResponseItem(attributeId: 'anAttributeId')),
      );
    });
  });
}
