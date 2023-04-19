import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RejectResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = RejectResponseItem();
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({'@type': 'RejectResponseItem', 'result': 'Rejected'}),
      );
    });

    test('is correctly converted with property "code"', () {
      const responseItem = RejectResponseItem(code: 'aCode');
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({'@type': 'RejectResponseItem', 'result': 'Rejected', 'code': 'aCode'}),
      );
    });

    test('is correctly converted with property "message"', () {
      const responseItem = RejectResponseItem(message: 'aMessage');
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({'@type': 'RejectResponseItem', 'result': 'Rejected', 'message': 'aMessage'}),
      );
    });

    test('is correctly converted with properties "code" and "message"', () {
      const responseItem = RejectResponseItem(code: 'aCode', message: 'aMessage');
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({'@type': 'RejectResponseItem', 'result': 'Rejected', 'code': 'aCode', 'message': 'aMessage'}),
      );
    });
  });

  group('RejectResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {'code': null, 'message': null};
      expect(
        RejectResponseItem.fromJson(json),
        equals(const RejectResponseItem()),
      );
    });

    test('is correctly converted with property "code"', () {
      final json = {'code': 'aCode'};
      expect(
        RejectResponseItem.fromJson(json),
        equals(const RejectResponseItem(code: 'aCode')),
      );
    });

    test('is correctly converted with property "message"', () {
      final json = {'message': 'aMessage'};
      expect(
        RejectResponseItem.fromJson(json),
        equals(const RejectResponseItem(message: 'aMessage')),
      );
    });

    test('is correctly converted with properties "code" and "message"', () {
      final json = {'code': 'aCode', 'message': 'aMessage'};
      expect(
        RejectResponseItem.fromJson(json),
        equals(const RejectResponseItem(code: 'aCode', message: 'aMessage')),
      );
    });
  });
}
