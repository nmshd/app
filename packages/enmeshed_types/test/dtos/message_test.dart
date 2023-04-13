import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('MessageDTO toJson', () {
    test('is correctly converted', () {
      const dto = MessageDTO(
        id: 'anId',
        isOwn: true,
        content: Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody'),
        createdBy: 'aCreatorAddress',
        createdByDevice: 'aCreatorDeviceId',
        recipients: [RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId')],
        createdAt: '2023',
        attachments: ['attachment1', 'attachment2'],
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isOwn': true,
          'content': const Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody').toJson(),
          'createdBy': 'aCreatorAddress',
          'createdByDevice': 'aCreatorDeviceId',
          'recipients': [
            const RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId').toJson(),
          ],
          'createdAt': '2023',
          'attachments': ['attachment1', 'attachment2'],
        }),
      );
    });
  });

  group('MessageDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'isOwn': true,
        'content': const Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody').toJson(),
        'createdBy': 'aCreatorAddress',
        'createdByDevice': 'aCreatorDeviceId',
        'recipients': [
          const RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId').toJson(),
        ],
        'createdAt': '2023',
        'attachments': ['attachment1', 'attachment2'],
      };
      expect(
        MessageDTO.fromJson(json),
        equals(const MessageDTO(
          id: 'anId',
          isOwn: true,
          content: Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody'),
          createdBy: 'aCreatorAddress',
          createdByDevice: 'aCreatorDeviceId',
          recipients: [RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId')],
          createdAt: '2023',
          attachments: ['attachment1', 'attachment2'],
        )),
      );
    });
  });
}
