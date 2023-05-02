import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('SyncEverythingResponse toJson', () {
    test('is correctly converted', () {
      const response = SyncEverythingResponse(
        relationships: [
          RelationshipDTO(
            id: 'anId',
            template: RelationshipTemplateDTO(
              id: 'anId',
              isOwn: true,
              createdBy: 'aCreatorAddress',
              createdByDevice: 'aCreatorDeviceId',
              createdAt: '2023',
              content: RelationshipTemplateContent(
                onNewRelationship: Request(items: [
                  CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity'))),
                ]),
              ),
              secretKey: 'aSecretKey',
              truncatedReference: 'aTruncatedReference',
            ),
            status: RelationshipStatus.Active,
            peer: 'aPeer',
            peerIdentity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey', realm: 'aRealm'),
            changes: [
              RelationshipChangeDTO(
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
              ),
            ],
          ),
        ],
        messages: [
          MessageDTO(
            id: 'anId',
            isOwn: true,
            content: Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody'),
            createdBy: 'aCreatorAddress',
            createdByDevice: 'aCreatorDeviceId',
            recipients: [RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId')],
            createdAt: '2023',
            attachments: ['attachment1', 'attachment2'],
          ),
        ],
      );
      final responseJson = response.toJson();
      print(const RelationshipTemplateContent(
        onNewRelationship: Request(items: [
          CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity'))),
        ]),
      ).toJson());
      expect(
        responseJson,
        equals({
          'relationships': [
            const RelationshipDTO(
              id: 'anId',
              template: RelationshipTemplateDTO(
                id: 'anId',
                isOwn: true,
                createdBy: 'aCreatorAddress',
                createdByDevice: 'aCreatorDeviceId',
                createdAt: '2023',
                content: RelationshipTemplateContent(
                  onNewRelationship: Request(items: [
                    CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity'))),
                  ]),
                ),
                secretKey: 'aSecretKey',
                truncatedReference: 'aTruncatedReference',
              ),
              status: RelationshipStatus.Active,
              peer: 'aPeer',
              peerIdentity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey', realm: 'aRealm'),
              changes: [
                RelationshipChangeDTO(
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
                ),
              ],
            ).toJson(),
          ],
          'messages': [
            const MessageDTO(
              id: 'anId',
              isOwn: true,
              content: Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody'),
              createdBy: 'aCreatorAddress',
              createdByDevice: 'aCreatorDeviceId',
              recipients: [RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId')],
              createdAt: '2023',
              attachments: ['attachment1', 'attachment2'],
            ).toJson(),
          ],
        }),
      );
    });
  });

  group('SyncEverythingResponse fromJson', () {
    test('is correctly converted', () {
      final json = {
        'relationships': [
          const RelationshipDTO(
            id: 'anId',
            template: RelationshipTemplateDTO(
              id: 'anId',
              isOwn: true,
              createdBy: 'aCreatorAddress',
              createdByDevice: 'aCreatorDeviceId',
              createdAt: '2023',
              content: RelationshipTemplateContent(
                onNewRelationship: Request(items: [
                  CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity'))),
                ]),
              ),
              secretKey: 'aSecretKey',
              truncatedReference: 'aTruncatedReference',
            ),
            status: RelationshipStatus.Active,
            peer: 'aPeer',
            peerIdentity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey', realm: 'aRealm'),
            changes: [
              RelationshipChangeDTO(
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
              ),
            ],
          ).toJson(),
        ],
        'messages': [
          const MessageDTO(
            id: 'anId',
            isOwn: true,
            content: Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody'),
            createdBy: 'aCreatorAddress',
            createdByDevice: 'aCreatorDeviceId',
            recipients: [RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId')],
            createdAt: '2023',
            attachments: ['attachment1', 'attachment2'],
          ).toJson(),
        ],
      };
      expect(
        SyncEverythingResponse.fromJson(json),
        equals(const SyncEverythingResponse(
          relationships: [
            RelationshipDTO(
              id: 'anId',
              template: RelationshipTemplateDTO(
                id: 'anId',
                isOwn: true,
                createdBy: 'aCreatorAddress',
                createdByDevice: 'aCreatorDeviceId',
                createdAt: '2023',
                content: RelationshipTemplateContent(
                  onNewRelationship: Request(items: [
                    CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity'))),
                  ]),
                ),
                secretKey: 'aSecretKey',
                truncatedReference: 'aTruncatedReference',
              ),
              status: RelationshipStatus.Active,
              peer: 'aPeer',
              peerIdentity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey', realm: 'aRealm'),
              changes: [
                RelationshipChangeDTO(
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
                ),
              ],
            ),
          ],
          messages: [
            MessageDTO(
              id: 'anId',
              isOwn: true,
              content: Mail(to: ['anAddress'], subject: 'aSubject', body: 'aBody'),
              createdBy: 'aCreatorAddress',
              createdByDevice: 'aCreatorDeviceId',
              recipients: [RecipientDTO(address: 'anAddress', receivedAt: null, receivedByDevice: null, relationshipId: 'aRelationshipId')],
              createdAt: '2023',
              attachments: ['attachment1', 'attachment2'],
            ),
          ],
        )),
      );
    });
  });
}
