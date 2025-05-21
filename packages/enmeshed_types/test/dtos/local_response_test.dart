import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LocalResponseDTO toJson', () {
    test('is correctly converted', () {
      const dto = LocalResponseDTO(
        createdAt: '2023',
        content: Response(
          result: ResponseResult.Accepted,
          requestId: 'aRequestId',
          items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
        ),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'createdAt': '2023',
          'content': const Response(
            result: ResponseResult.Accepted,
            requestId: 'aRequestId',
            items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
          ).toJson(),
        }),
      );
    });

    test('is correctly converted with property "source"', () {
      const dto = LocalResponseDTO(
        createdAt: '2023',
        content: Response(
          result: ResponseResult.Accepted,
          requestId: 'aRequestId',
          items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
        ),
        source: LocalResponseSourceDTO(type: LocalResponseSourceType.Message, reference: 'aReference'),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'createdAt': '2023',
          'content': const Response(
            result: ResponseResult.Accepted,
            requestId: 'aRequestId',
            items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
          ).toJson(),
          'source': const LocalResponseSourceDTO(type: LocalResponseSourceType.Message, reference: 'aReference').toJson(),
        }),
      );
    });
  });

  group('LocalResponseDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'createdAt': '2023',
        'content': const Response(
          result: ResponseResult.Accepted,
          requestId: 'aRequestId',
          items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
        ).toJson(),
      };
      expect(
        LocalResponseDTO.fromJson(json),
        equals(
          const LocalResponseDTO(
            createdAt: '2023',
            content: Response(
              result: ResponseResult.Accepted,
              requestId: 'aRequestId',
              items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
            ),
          ),
        ),
      );
    });

    test('is correctly converted with property "source"', () {
      final json = {
        'createdAt': '2023',
        'content': const Response(
          result: ResponseResult.Accepted,
          requestId: 'aRequestId',
          items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
        ).toJson(),
        'source': const LocalResponseSourceDTO(type: LocalResponseSourceType.Message, reference: 'aReference').toJson(),
      };
      expect(
        LocalResponseDTO.fromJson(json),
        equals(
          const LocalResponseDTO(
            createdAt: '2023',
            content: Response(
              result: ResponseResult.Accepted,
              requestId: 'aRequestId',
              items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
            ),
            source: LocalResponseSourceDTO(type: LocalResponseSourceType.Message, reference: 'aReference'),
          ),
        ),
      );
    });
  });
}
