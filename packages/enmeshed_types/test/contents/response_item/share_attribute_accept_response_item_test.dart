import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ShareAttributeAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = ShareAttributeAcceptResponseItem(attributeId: 'anAttributeId');
      final responseItemJson = responseItem.toJson();
      expect(responseItemJson, equals({'@type': 'ShareAttributeAcceptResponseItem', 'result': 'Accepted', 'attributeId': 'anAttributeId'}));
    });
  });

  group('ShareAttributeAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {'attributeId': 'anAttributeId'};
      expect(ShareAttributeAcceptResponseItem.fromJson(json), equals(const ShareAttributeAcceptResponseItem(attributeId: 'anAttributeId')));
    });
  });
}
