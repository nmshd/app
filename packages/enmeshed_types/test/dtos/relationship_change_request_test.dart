import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipChangeRequestDTO toJson', () {
    test('is correctly converted', () {
      const dto = RelationshipChangeRequestDTO(
        createdBy: 'aCreator',
        createdByDevice: 'aCreatorDeviceId',
        createdAt: '2023',
        content: RelationshipCreationChangeRequestContent(
          response: Response(result: 'aResult', requestId: 'aRequestId', items: [RejectResponseItem()]),
        ),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'createdBy': 'aCreator',
          'createdByDevice': 'aCreatorDeviceId',
          'createdAt': '2023',
          'content': const RelationshipCreationChangeRequestContent(
            response: Response(result: 'aResult', requestId: 'aRequestId', items: [RejectResponseItem()]),
          ).toJson(),
        }),
      );
    });
  });

  group('RelationshipChangeRequestDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'createdBy': 'aCreator',
        'createdByDevice': 'aCreatorDeviceId',
        'createdAt': '2023',
        'content': const RelationshipCreationChangeRequestContent(
          response: Response(result: 'aResult', requestId: 'aRequestId', items: [RejectResponseItem()]),
        ).toJson(),
      };
      expect(
        RelationshipChangeRequestDTO.fromJson(json),
        equals(const RelationshipChangeRequestDTO(
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipCreationChangeRequestContent(
            response: Response(result: 'aResult', requestId: 'aRequestId', items: [RejectResponseItem()]),
          ),
        )),
      );
    });
  });
}
