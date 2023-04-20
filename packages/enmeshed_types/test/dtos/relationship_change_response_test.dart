import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipChangeResponseDTO toJson', () {
    test('is correctly converted', () {
      final dto = RelationshipChangeResponseDTO(
        createdBy: 'aCreator',
        createdByDevice: 'aCreatorDeviceId',
        createdAt: '2023',
        content: ArbitraryRelationshipChangeResponseContent({'aKey': 'aValue'}),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'createdBy': 'aCreator',
          'createdByDevice': 'aCreatorDeviceId',
          'createdAt': '2023',
          'content': ArbitraryRelationshipChangeResponseContent({'aKey': 'aValue'}).toJson(),
        }),
      );
    });
  });

  group('RelationshipChangeResponseDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'createdBy': 'aCreator',
        'createdByDevice': 'aCreatorDeviceId',
        'createdAt': '2023',
        'content': ArbitraryRelationshipChangeResponseContent({'aKey': 'aValue'}).toJson(),
      };
      expect(
        RelationshipChangeResponseDTO.fromJson(json),
        equals(RelationshipChangeResponseDTO(
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: ArbitraryRelationshipChangeResponseContent({'aKey': 'aValue'}),
        )),
      );
    });
  });
}
