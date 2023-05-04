import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AcceptProposeAttributeRequestItemParametersWithNewAttribute toJson', () {
    test('is correctly converted', () {
      const item = AcceptProposeAttributeRequestItemParametersWithNewAttribute(
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final itemJson = item.toJson();
      expect(
        itemJson,
        equals({'accept': true, 'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson()}),
      );
    });
  });

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
