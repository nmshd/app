import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('FreeTextAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = FreeTextAcceptResponseItem(freeText: 'aFreeText');
      final responseItemJson = responseItem.toJson();
      expect(responseItemJson, equals({'@type': 'FreeTextAcceptResponseItem', 'result': 'Accepted', 'freeText': 'aFreeText'}));
    });
  });

  group('FreeTextAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {'freeText': 'aFreeText'};
      expect(FreeTextAcceptResponseItem.fromJson(json), equals(const FreeTextAcceptResponseItem(freeText: 'aFreeText')));
    });
  });
}
