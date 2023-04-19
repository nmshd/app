import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LocalRequestDTO toJson', () {
    test('is correctly converted', () {
      const dto = LocalRequestDTO(
        id: 'anId',
        isOwn: true,
        peer: 'aPeer',
        createdAt: '2023',
        status: LocalRequestStatus.Open,
        content: Request(
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
        ),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isOwn': true,
          'peer': 'aPeer',
          'createdAt': '2023',
          'status': 'Open',
          'content': const Request(
            items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
          ).toJson(),
        }),
      );
    });

    test('is correctly converted with property "source"', () {
      const dto = LocalRequestDTO(
        id: 'anId',
        isOwn: true,
        peer: 'aPeer',
        createdAt: '2023',
        status: LocalRequestStatus.Open,
        content: Request(
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
        ),
        source: LocalRequestSourceDTO(type: LocalRequestSourceType.Message, reference: 'aReference'),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isOwn': true,
          'peer': 'aPeer',
          'createdAt': '2023',
          'status': 'Open',
          'content': const Request(
            items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
          ).toJson(),
          'source': const LocalRequestSourceDTO(type: LocalRequestSourceType.Message, reference: 'aReference').toJson(),
        }),
      );
    });
  });

  group('LocalRequestDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'isOwn': true,
        'peer': 'aPeer',
        'createdAt': '2023',
        'status': 'Open',
        'content': const Request(
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
        ).toJson(),
      };
      expect(
        LocalRequestDTO.fromJson(json),
        equals(const LocalRequestDTO(
          id: 'anId',
          isOwn: true,
          peer: 'aPeer',
          createdAt: '2023',
          status: LocalRequestStatus.Open,
          content: Request(
            items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
          ),
        )),
      );
    });

    test('is correctly converted with property "source"', () {
      final json = {
        'id': 'anId',
        'isOwn': true,
        'peer': 'aPeer',
        'createdAt': '2023',
        'status': 'Open',
        'content': const Request(
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
        ).toJson(),
        'source': const LocalRequestSourceDTO(type: LocalRequestSourceType.Message, reference: 'aReference').toJson(),
      };
      expect(
        LocalRequestDTO.fromJson(json),
        equals(const LocalRequestDTO(
          id: 'anId',
          isOwn: true,
          peer: 'aPeer',
          createdAt: '2023',
          status: LocalRequestStatus.Open,
          content: Request(
            items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
          ),
          source: LocalRequestSourceDTO(type: LocalRequestSourceType.Message, reference: 'aReference'),
        )),
      );
    });
  });
}
