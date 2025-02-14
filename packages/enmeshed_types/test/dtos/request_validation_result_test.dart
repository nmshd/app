import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RequestValidationResultDTO toJson', () {
    test('is correctly converted', () {
      const dto = RequestValidationResultDTO(isSuccess: true, items: [RequestValidationResultDTO(isSuccess: true, items: [])]);
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'isSuccess': true,
          'items': [const RequestValidationResultDTO(isSuccess: true, items: []).toJson()],
        }),
      );
    });

    test('is correctly converted with property "code"', () {
      const dto = RequestValidationResultDTO(isSuccess: true, code: 'aCode', items: [RequestValidationResultDTO(isSuccess: true, items: [])]);
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'isSuccess': true,
          'code': 'aCode',
          'items': [const RequestValidationResultDTO(isSuccess: true, items: []).toJson()],
        }),
      );
    });

    test('is correctly converted with property "message"', () {
      const dto = RequestValidationResultDTO(isSuccess: true, message: 'aMessage', items: [RequestValidationResultDTO(isSuccess: true, items: [])]);
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'isSuccess': true,
          'message': 'aMessage',
          'items': [const RequestValidationResultDTO(isSuccess: true, items: []).toJson()],
        }),
      );
    });

    test('is correctly converted with properties "code" and "message"', () {
      const dto = RequestValidationResultDTO(
        isSuccess: true,
        code: 'aCode',
        message: 'aMessage',
        items: [RequestValidationResultDTO(isSuccess: true, items: [])],
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'isSuccess': true,
          'code': 'aCode',
          'message': 'aMessage',
          'items': [const RequestValidationResultDTO(isSuccess: true, items: []).toJson()],
        }),
      );
    });
  });

  group('RequestValidationResultDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'isSuccess': true,
        'items': [const RequestValidationResultDTO(isSuccess: true, items: []).toJson()],
      };
      expect(
        RequestValidationResultDTO.fromJson(json),
        equals(const RequestValidationResultDTO(isSuccess: true, items: [RequestValidationResultDTO(isSuccess: true, items: [])])),
      );
    });

    test('is correctly converted with property "code"', () {
      final json = {
        'isSuccess': true,
        'code': 'aCode',
        'items': [const RequestValidationResultDTO(isSuccess: true, items: []).toJson()],
      };
      expect(
        RequestValidationResultDTO.fromJson(json),
        equals(const RequestValidationResultDTO(isSuccess: true, code: 'aCode', items: [RequestValidationResultDTO(isSuccess: true, items: [])])),
      );
    });

    test('is correctly converted with property "message"', () {
      final json = {
        'isSuccess': true,
        'message': 'aMessage',
        'items': [const RequestValidationResultDTO(isSuccess: true, items: []).toJson()],
      };
      expect(
        RequestValidationResultDTO.fromJson(json),
        equals(
          const RequestValidationResultDTO(isSuccess: true, message: 'aMessage', items: [RequestValidationResultDTO(isSuccess: true, items: [])]),
        ),
      );
    });

    test('is correctly converted with properties "code" and "message"', () {
      final json = {
        'isSuccess': true,
        'code': 'aCode',
        'message': 'aMessage',
        'items': [const RequestValidationResultDTO(isSuccess: true, items: []).toJson()],
      };
      expect(
        RequestValidationResultDTO.fromJson(json),
        equals(
          const RequestValidationResultDTO(
            isSuccess: true,
            code: 'aCode',
            message: 'aMessage',
            items: [RequestValidationResultDTO(isSuccess: true, items: [])],
          ),
        ),
      );
    });
  });
}
