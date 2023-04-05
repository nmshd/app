import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ResponseItemGroup toJson', () {
    test('is correctly converted', () {
      const responseItemGroup = ResponseItemGroup(result: ResponseItemResult.Accepted, items: []);
      final responseItemGroupJson = responseItemGroup.toJson();
      expect(
        responseItemGroupJson,
        equals({'@type': 'ResponseItemGroup', 'result': 'Accepted', 'items': []}),
      );
    });
  });

  group('ResponseItemGroup fromJson', () {
    test('is correctly converted', () {
      final json = {'result': 'Accepted', 'items': []};
      expect(ResponseItemGroup.fromJson(json), equals(const ResponseItemGroup(result: ResponseItemResult.Accepted, items: [])));
    });
  });
}
