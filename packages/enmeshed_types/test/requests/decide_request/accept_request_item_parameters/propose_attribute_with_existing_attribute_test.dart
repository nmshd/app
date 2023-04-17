import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AcceptProposeAttributeRequestItemParametersWithExistingAttribute toJson', () {
    test('is correctly converted', () {
      const item = AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: 'anAttributeId');
      final itemJson = item.toJson();
      expect(
        itemJson,
        equals({'accept': true, 'attributeId': 'anAttributeId'}),
      );
    });
  });
}
