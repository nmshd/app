import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('MessageWithAttachmentsDTO toJson', () {
    test('is correctly converted', () {
      const dto = MessageWithAttachmentsDTO(
        id: 'anId',
        isOwn: true,
        content: Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody'),
        createdBy: 'aCreatorAddress',
        createdByDevice: 'aCreatorDeviceId',
        recipients: [RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId')],
        createdAt: '2023',
        attachments: [
          FileDTO(
            id: 'anId',
            filename: 'aFilename',
            filesize: 1,
            createdAt: '2023',
            createdBy: 'aCreator',
            createdByDevice: 'aCreatorDeviceId',
            expiresAt: '2023',
            mimetype: 'aMimetype',
            isOwn: true,
            title: 'aTitle',
            reference: ObjectReferenceDTO(truncated: 'aTruncatedReference', url: 'aUrl'),
          ),
        ],
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
          'attachments': [
            const FileDTO(
              id: 'anId',
              filename: 'aFilename',
              filesize: 1,
              createdAt: '2023',
              createdBy: 'aCreator',
              createdByDevice: 'aCreatorDeviceId',
              expiresAt: '2023',
              mimetype: 'aMimetype',
              isOwn: true,
              title: 'aTitle',
              reference: ObjectReferenceDTO(truncated: 'aTruncatedReference', url: 'aUrl'),
            ).toJson(),
          ],
        }),
      );
    });
  });

  group('MessageWithAttachmentsDTO fromJson', () {
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
        'attachments': [
          const FileDTO(
            id: 'anId',
            filename: 'aFilename',
            filesize: 1,
            createdAt: '2023',
            createdBy: 'aCreator',
            createdByDevice: 'aCreatorDeviceId',
            expiresAt: '2023',
            mimetype: 'aMimetype',
            isOwn: true,
            title: 'aTitle',
            reference: ObjectReferenceDTO(truncated: 'aTruncatedReference', url: 'aUrl'),
          ).toJson(),
        ],
      };
      expect(
        MessageWithAttachmentsDTO.fromJson(json),
        equals(
          const MessageWithAttachmentsDTO(
            id: 'anId',
            isOwn: true,
            content: Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody'),
            createdBy: 'aCreatorAddress',
            createdByDevice: 'aCreatorDeviceId',
            recipients: [RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId')],
            createdAt: '2023',
            attachments: [
              FileDTO(
                id: 'anId',
                filename: 'aFilename',
                filesize: 1,
                createdAt: '2023',
                createdBy: 'aCreator',
                createdByDevice: 'aCreatorDeviceId',
                expiresAt: '2023',
                mimetype: 'aMimetype',
                isOwn: true,
                title: 'aTitle',
                reference: ObjectReferenceDTO(truncated: 'aTruncatedReference', url: 'aUrl'),
              ),
            ],
          ),
        ),
      );
    });
  });
}
