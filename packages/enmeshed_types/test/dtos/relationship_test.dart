import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipDTO toJson', () {
    test(
      'is correctly converted',
      () {
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
                CreateAttributeRequestItem(
                  mustBeAccepted: true,
                  attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
                ),
              ]),
            ),
            secretKey: 'aSecretKey',
            truncatedReference: 'aTruncatedReference',
          ),
          status: RelationshipStatus.Active,
          peer: 'aPeer',
          peerIdentity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
          creationContent: RelationshipCreationContentContainingResponse(
            response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
          ),
          auditLog: [
            RelationshipAuditLogEntryDTO(
                createdAt: '2023',
                createdBy: 'aRequestorAddress',
                createdByDevice: 'aRequestorDevice',
                reason: RelationshipAuditLogEntryReason.Creation,
                newStatus: RelationshipStatus.Pending),
            RelationshipAuditLogEntryDTO(
                createdAt: '2023',
                createdBy: 'aCreatorAddress',
                createdByDevice: 'aCreatorDevice',
                reason: RelationshipAuditLogEntryReason.AcceptanceOfCreation,
                oldStatus: RelationshipStatus.Pending,
                newStatus: RelationshipStatus.Active)
          ],
        );

        final dtoJson = dto.toJson();
        expect(
          dtoJson,
          equals(
            {
              'id': 'anId',
              'template': const RelationshipTemplateDTO(
                id: 'anId',
                isOwn: true,
                createdBy: 'aCreatorAddress',
                createdByDevice: 'aCreatorDeviceId',
                createdAt: '2023',
                content: RelationshipTemplateContent(
                  onNewRelationship: Request(items: [
                    CreateAttributeRequestItem(
                      mustBeAccepted: true,
                      attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
                    ),
                  ]),
                ),
                secretKey: 'aSecretKey',
                truncatedReference: 'aTruncatedReference',
              ).toJson(),
              'status': 'Active',
              'peer': 'aPeer',
              'peerIdentity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
              'creationContent': const RelationshipCreationContentContainingResponse(
                response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
              ).toJson(),
              'auditLog': [
                {
                  'createdAt': '2023',
                  'createdBy': 'aRequestorAddress',
                  'createdByDevice': 'aRequestorDevice',
                  'reason': 'Creation',
                  'newStatus': 'Pending'
                },
                {
                  'createdAt': '2023',
                  'createdBy': 'aCreatorAddress',
                  'createdByDevice': 'aCreatorDevice',
                  'reason': 'AcceptanceOfCreation',
                  'oldStatus': 'Pending',
                  'newStatus': 'Active'
                }
              ]
            },
          ),
        );
      },
    );
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
              CreateAttributeRequestItem(
                mustBeAccepted: true,
                attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
              ),
            ]),
          ),
          secretKey: 'aSecretKey',
          truncatedReference: 'aTruncatedReference',
        ).toJson(),
        'status': 'Active',
        'peer': 'aPeer',
        'peerIdentity': const IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey').toJson(),
        'creationContent': const RelationshipCreationContentContainingResponse(
          response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
        ).toJson(),
        'auditLog': [
          {
            'createdAt': '2023',
            'createdBy': 'aRequestorAddress',
            'createdByDevice': 'aRequestorDevice',
            'reason': 'Creation',
            'newStatus': 'Pending'
          },
          {
            'createdAt': '2023',
            'createdBy': 'aCreatorAddress',
            'createdByDevice': 'aCreatorDevice',
            'reason': 'AcceptanceOfCreation',
            'oldStatus': 'Pending',
            'newStatus': 'Active'
          }
        ]
      };
      expect(
        RelationshipDTO.fromJson(json),
        equals(
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
                  CreateAttributeRequestItem(
                    mustBeAccepted: true,
                    attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
                  ),
                ]),
              ),
              secretKey: 'aSecretKey',
              truncatedReference: 'aTruncatedReference',
            ),
            status: RelationshipStatus.Active,
            peer: 'aPeer',
            peerIdentity: IdentityDTO(address: 'anAddress', publicKey: 'aPublicKey'),
            creationContent: RelationshipCreationContentContainingResponse(
              response: Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()]),
            ),
            auditLog: [
              RelationshipAuditLogEntryDTO(
                  createdAt: '2023',
                  createdBy: 'aRequestorAddress',
                  createdByDevice: 'aRequestorDevice',
                  reason: RelationshipAuditLogEntryReason.Creation,
                  newStatus: RelationshipStatus.Pending),
              RelationshipAuditLogEntryDTO(
                  createdAt: '2023',
                  createdBy: 'aCreatorAddress',
                  createdByDevice: 'aCreatorDevice',
                  reason: RelationshipAuditLogEntryReason.AcceptanceOfCreation,
                  oldStatus: RelationshipStatus.Pending,
                  newStatus: RelationshipStatus.Active)
            ],
          ),
        ),
      );
    });
  });
}
