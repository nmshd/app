import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
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
