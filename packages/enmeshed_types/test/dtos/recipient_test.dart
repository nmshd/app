import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RecipientDTO toJson', () {
    test('is correctly converted', () {
      const dto = RecipientDTO(address: 'anAddress', relationshipId: 'aRelationshipId');
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({'address': 'anAddress', 'relationshipId': 'aRelationshipId'}),
      );
    });

    test('is correctly converted with property "receivedAt"', () {
      const dto = RecipientDTO(address: 'anAddress', receivedAt: '2023', relationshipId: 'aRelationshipId');
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({'address': 'anAddress', 'receivedAt': '2023', 'relationshipId': 'aRelationshipId'}),
      );
    });

    test('is correctly converted with property "receivedByDevice"', () {
      const dto = RecipientDTO(address: 'anAddress', receivedByDevice: 'aReceiverDeviceId', relationshipId: 'aRelationshipId');
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({'address': 'anAddress', 'receivedByDevice': 'aReceiverDeviceId', 'relationshipId': 'aRelationshipId'}),
      );
    });

    test('is correctly converted with properties "receivedAt" and "receivedByDevice"', () {
      const dto = RecipientDTO(address: 'anAddress', receivedAt: '2023', receivedByDevice: 'aReceiverDeviceId', relationshipId: 'aRelationshipId');
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({'address': 'anAddress', 'receivedAt': '2023', 'receivedByDevice': 'aReceiverDeviceId', 'relationshipId': 'aRelationshipId'}),
      );
    });
  });

  group('RecipientDTO fromJson', () {
    test('is correctly converted', () {
      final json = {'address': 'anAddress', 'relationshipId': 'aRelationshipId'};
      expect(
        RecipientDTO.fromJson(json),
        equals(const RecipientDTO(address: 'anAddress', relationshipId: 'aRelationshipId')),
      );
    });

    test('is correctly converted with property "receivedAt"', () {
      final json = {'address': 'anAddress', 'receivedAt': '2023', 'relationshipId': 'aRelationshipId'};
      expect(
        RecipientDTO.fromJson(json),
        equals(const RecipientDTO(address: 'anAddress', receivedAt: '2023', relationshipId: 'aRelationshipId')),
      );
    });

    test('is correctly converted with property "receivedByDevice"', () {
      final json = {'address': 'anAddress', 'receivedByDevice': 'aReceiverDeviceId', 'relationshipId': 'aRelationshipId'};
      expect(
        RecipientDTO.fromJson(json),
        equals(const RecipientDTO(address: 'anAddress', receivedByDevice: 'aReceiverDeviceId', relationshipId: 'aRelationshipId')),
      );
    });

    test('is correctly converted with properties "receivedAt" and "receivedByDevice"', () {
      final json = {'address': 'anAddress', 'receivedAt': '2023', 'receivedByDevice': 'aReceiverDeviceId', 'relationshipId': 'aRelationshipId'};
      expect(
        RecipientDTO.fromJson(json),
        equals(
          const RecipientDTO(address: 'anAddress', receivedAt: '2023', receivedByDevice: 'aReceiverDeviceId', relationshipId: 'aRelationshipId'),
        ),
      );
    });
  });
}
