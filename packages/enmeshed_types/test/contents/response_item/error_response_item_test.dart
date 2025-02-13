import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ErrorResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = ErrorResponseItem(code: 'aCode', message: 'aMessage');
      final responseItemJson = responseItem.toJson();
      expect(responseItemJson, equals({'@type': 'ErrorResponseItem', 'result': 'Error', 'code': 'aCode', 'message': 'aMessage'}));
    });
  });

  group('ErrorResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {'code': 'aCode', 'message': 'aMessage'};
      expect(ErrorResponseItem.fromJson(json), equals(const ErrorResponseItem(code: 'aCode', message: 'aMessage')));
    });
  });
}
