import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipChangeDTO toJson', () {
    test('is correctly converted', () {
      const dto = RelationshipChangeDTO(
        id: 'anId',
        request: RelationshipChangeRequestDTO(
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipCreationChangeRequestContent(
            response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
          ),
        ),
        status: RelationshipChangeStatus.Accepted,
        type: RelationshipChangeType.Creation,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'request': const RelationshipChangeRequestDTO(
            createdBy: 'aCreator',
            createdByDevice: 'aCreatorDeviceId',
            createdAt: '2023',
            content: RelationshipCreationChangeRequestContent(
              response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
            ),
          ).toJson(),
          'status': 'Accepted',
          'type': 'Creation',
        }),
      );
    });

    test('is correctly converted with property "response"', () {
      const dto = RelationshipChangeDTO(
        id: 'anId',
        request: RelationshipChangeRequestDTO(
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipCreationChangeRequestContent(
            response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
          ),
        ),
        status: RelationshipChangeStatus.Accepted,
        type: RelationshipChangeType.Creation,
        response: RelationshipChangeResponseDTO(
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: ArbitraryRelationshipChangeResponseContent({'aKey': 'aValue'}),
        ),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'request': const RelationshipChangeRequestDTO(
            createdBy: 'aCreator',
            createdByDevice: 'aCreatorDeviceId',
            createdAt: '2023',
            content: RelationshipCreationChangeRequestContent(
              response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
            ),
          ).toJson(),
          'status': 'Accepted',
          'type': 'Creation',
          'response': const RelationshipChangeResponseDTO(
            createdBy: 'aCreator',
            createdByDevice: 'aCreatorDeviceId',
            createdAt: '2023',
            content: ArbitraryRelationshipChangeResponseContent({'aKey': 'aValue'}),
          ).toJson(),
        }),
      );
    });
  });

  group('RelationshipChangeDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'request': const RelationshipChangeRequestDTO(
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipCreationChangeRequestContent(
            response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
          ),
        ).toJson(),
        'status': 'Accepted',
        'type': 'Creation',
      };
      expect(
        RelationshipChangeDTO.fromJson(json),
        equals(const RelationshipChangeDTO(
          id: 'anId',
          request: RelationshipChangeRequestDTO(
            createdBy: 'aCreator',
            createdByDevice: 'aCreatorDeviceId',
            createdAt: '2023',
            content: RelationshipCreationChangeRequestContent(
              response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
            ),
          ),
          status: RelationshipChangeStatus.Accepted,
          type: RelationshipChangeType.Creation,
        )),
      );
    });

    test('is correctly converted with property "response"', () {
      final json = {
        'id': 'anId',
        'request': const RelationshipChangeRequestDTO(
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipCreationChangeRequestContent(
            response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
          ),
        ).toJson(),
        'status': 'Accepted',
        'type': 'Creation',
        'response': const RelationshipChangeResponseDTO(
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: ArbitraryRelationshipChangeResponseContent({'aKey': 'aValue'}),
        ).toJson(),
      };
      expect(
        RelationshipChangeDTO.fromJson(json),
        equals(const RelationshipChangeDTO(
          id: 'anId',
          request: RelationshipChangeRequestDTO(
            createdBy: 'aCreator',
            createdByDevice: 'aCreatorDeviceId',
            createdAt: '2023',
            content: RelationshipCreationChangeRequestContent(
              response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
            ),
          ),
          status: RelationshipChangeStatus.Accepted,
          type: RelationshipChangeType.Creation,
          response: RelationshipChangeResponseDTO(
            createdBy: 'aCreator',
            createdByDevice: 'aCreatorDeviceId',
            createdAt: '2023',
            content: ArbitraryRelationshipChangeResponseContent({'aKey': 'aValue'}),
          ),
        )),
      );
    });
  });
}
