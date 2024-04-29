import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AcceptDeleteAttributeRequestItemParameters toJson', () {
    test('is correctly converted', () {
      final deletionDate = DateTime.now().add(const Duration(days: 1)).toIso8601String();
      final item = AcceptDeleteAttributeRequestItemParameters(
        deletionDate: deletionDate,
      );
      final itemJson = item.toJson();
      expect(
        itemJson,
        equals({'accept': true, 'deletionDate': deletionDate}),
      );
    });
  });
}
