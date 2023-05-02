import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipDTO toJson', () {
    test('is correctly converted', () {
      const dto = RelationshipDTO(
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
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'template': const RelationshipTemplateDTO(
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
          ).toJson(),
          'status': 'Active',
          'peer': 'aPeer',
          'peerIdentity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey', realm: 'aRealm').toJson(),
          'changes': [
            const RelationshipChangeDTO(
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
            ).toJson(),
          ],
        }),
      );
    });
  });

  group('RelationshipDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'template': const RelationshipTemplateDTO(
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
        ).toJson(),
        'status': 'Active',
        'peer': 'aPeer',
        'peerIdentity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey', realm: 'aRealm').toJson(),
        'changes': [
          const RelationshipChangeDTO(
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
          ).toJson(),
        ],
      };
      expect(
        RelationshipDTO.fromJson(json),
        equals(const RelationshipDTO(
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
        )),
      );
    });
  });
}
