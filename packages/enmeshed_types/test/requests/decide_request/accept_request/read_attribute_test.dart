import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AcceptReadAttributeRequestItemParametersWithNewAttribute toJson', () {
    test('is correctly converted', () {
      const item = AcceptReadAttributeRequestItemParametersWithNewAttribute(
        newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
      );
      final itemJson = item.toJson();
      expect(
        itemJson,
        equals({'accept': true, 'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson()}),
      );
    });
  });

  group('AcceptReadAttributeRequestItemParametersWithExistingAttribute toJson', () {
    test('is correctly converted', () {
      const item = AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: 'anExistingAttributeId');
      final itemJson = item.toJson();
      expect(
        itemJson,
        equals({'accept': true, 'existingAttributeId': 'anExistingAttributeId'}),
      );
    });
  });
}
