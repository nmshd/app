import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipTemplateDTO toJson', () {
    test('is correctly converted', () {
      const dto = RelationshipTemplateDTO(
        id: 'anId',
        isOwn: true,
        createdBy: 'aCreatorAddress',
        createdByDevice: 'aCreatorDeviceId',
        createdAt: '2023',
        content: RelationshipTemplateContent(
          onNewRelationship: Request(items: [
            CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity'))),
          ]),
        ),
        secretKey: 'aSecretKey',
        truncatedReference: 'aTruncatedReference',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isOwn': true,
          'createdBy': 'aCreatorAddress',
          'createdByDevice': 'aCreatorDeviceId',
          'createdAt': '2023',
          'content': const RelationshipTemplateContent(
            onNewRelationship: Request(
              items: [CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')))],
            ),
          ).toJson(),
          'secretKey': 'aSecretKey',
          'truncatedReference': 'aTruncatedReference',
        }),
      );
    });

    test('is correctly converted with property "expiresAt"', () {
      const dto = RelationshipTemplateDTO(
        id: 'anId',
        isOwn: true,
        createdBy: 'aCreatorAddress',
        createdByDevice: 'aCreatorDeviceId',
        createdAt: '2023',
        content: RelationshipTemplateContent(
          onNewRelationship: Request(items: [
            CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity'))),
          ]),
        ),
        secretKey: 'aSecretKey',
        expiresAt: '2024',
        truncatedReference: 'aTruncatedReference',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isOwn': true,
          'createdBy': 'aCreatorAddress',
          'createdByDevice': 'aCreatorDeviceId',
          'createdAt': '2023',
          'content': const RelationshipTemplateContent(
            onNewRelationship: Request(
              items: [CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')))],
            ),
          ).toJson(),
          'expiresAt': '2024',
          'secretKey': 'aSecretKey',
          'truncatedReference': 'aTruncatedReference',
        }),
      );
    });

    test('is correctly converted with property "maxNumberOfAllocations"', () {
      const dto = RelationshipTemplateDTO(
        id: 'anId',
        isOwn: true,
        createdBy: 'aCreatorAddress',
        createdByDevice: 'aCreatorDeviceId',
        createdAt: '2023',
        content: RelationshipTemplateContent(
          onNewRelationship: Request(items: [
            CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity'))),
          ]),
        ),
        maxNumberOfAllocations: 1,
        secretKey: 'aSecretKey',
        truncatedReference: 'aTruncatedReference',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isOwn': true,
          'createdBy': 'aCreatorAddress',
          'createdByDevice': 'aCreatorDeviceId',
          'createdAt': '2023',
          'content': const RelationshipTemplateContent(
            onNewRelationship: Request(
              items: [CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')))],
            ),
          ).toJson(),
          'maxNumberOfAllocations': 1,
          'secretKey': 'aSecretKey',
          'truncatedReference': 'aTruncatedReference',
        }),
      );
    });

    test('is correctly converted with properties "expiresAt" and "maxNumberOfAllocations"', () {
      const dto = RelationshipTemplateDTO(
        id: 'anId',
        isOwn: true,
        createdBy: 'aCreatorAddress',
        createdByDevice: 'aCreatorDeviceId',
        createdAt: '2023',
        content: RelationshipTemplateContent(
          onNewRelationship: Request(items: [
            CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity'))),
          ]),
        ),
        expiresAt: '2024',
        maxNumberOfAllocations: 1,
        secretKey: 'aSecretKey',
        truncatedReference: 'aTruncatedReference',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'isOwn': true,
          'createdBy': 'aCreatorAddress',
          'createdByDevice': 'aCreatorDeviceId',
          'createdAt': '2023',
          'content': const RelationshipTemplateContent(
            onNewRelationship: Request(
              items: [CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')))],
            ),
          ).toJson(),
          'expiresAt': '2024',
          'maxNumberOfAllocations': 1,
          'secretKey': 'aSecretKey',
          'truncatedReference': 'aTruncatedReference',
        }),
      );
    });
  });

  group('RelationshipTemplateDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'isOwn': true,
        'createdBy': 'aCreatorAddress',
        'createdByDevice': 'aCreatorDeviceId',
        'createdAt': '2023',
        'content': const RelationshipTemplateContent(
          onNewRelationship: Request(
            items: [CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')))],
          ),
        ).toJson(),
        'secretKey': 'aSecretKey',
        'truncatedReference': 'aTruncatedReference',
      };
      expect(
        RelationshipTemplateDTO.fromJson(json),
        equals(const RelationshipTemplateDTO(
          id: 'anId',
          isOwn: true,
          createdBy: 'aCreatorAddress',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipTemplateContent(
            onNewRelationship: Request(items: [
              CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity'))),
            ]),
          ),
          secretKey: 'aSecretKey',
          truncatedReference: 'aTruncatedReference',
        )),
      );
    });

    test('is correctly converted with property "expiresAt"', () {
      final json = {
        'id': 'anId',
        'isOwn': true,
        'createdBy': 'aCreatorAddress',
        'createdByDevice': 'aCreatorDeviceId',
        'createdAt': '2023',
        'content': const RelationshipTemplateContent(
          onNewRelationship: Request(
            items: [CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')))],
          ),
        ).toJson(),
        'expiresAt': '2024',
        'secretKey': 'aSecretKey',
        'truncatedReference': 'aTruncatedReference',
      };
      expect(
        RelationshipTemplateDTO.fromJson(json),
        equals(const RelationshipTemplateDTO(
          id: 'anId',
          isOwn: true,
          createdBy: 'aCreatorAddress',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipTemplateContent(
            onNewRelationship: Request(items: [
              CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity'))),
            ]),
          ),
          expiresAt: '2024',
          secretKey: 'aSecretKey',
          truncatedReference: 'aTruncatedReference',
        )),
      );
    });

    test('is correctly converted with property "maxNumberOfAllocations"', () {
      final json = {
        'id': 'anId',
        'isOwn': true,
        'createdBy': 'aCreatorAddress',
        'createdByDevice': 'aCreatorDeviceId',
        'createdAt': '2023',
        'content': const RelationshipTemplateContent(
          onNewRelationship: Request(
            items: [CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')))],
          ),
        ).toJson(),
        'maxNumberOfAllocations': 1,
        'secretKey': 'aSecretKey',
        'truncatedReference': 'aTruncatedReference',
      };
      expect(
        RelationshipTemplateDTO.fromJson(json),
        equals(const RelationshipTemplateDTO(
          id: 'anId',
          isOwn: true,
          createdBy: 'aCreatorAddress',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipTemplateContent(
            onNewRelationship: Request(items: [
              CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity'))),
            ]),
          ),
          maxNumberOfAllocations: 1,
          secretKey: 'aSecretKey',
          truncatedReference: 'aTruncatedReference',
        )),
      );
    });

    test('is correctly converted with properties "expiresAt" and "maxNumberOfAllocations"', () {
      final json = {
        'id': 'anId',
        'isOwn': true,
        'createdBy': 'aCreatorAddress',
        'createdByDevice': 'aCreatorDeviceId',
        'createdAt': '2023',
        'content': const RelationshipTemplateContent(
          onNewRelationship: Request(
            items: [CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')))],
          ),
        ).toJson(),
        'expiresAt': '2024',
        'maxNumberOfAllocations': 1,
        'secretKey': 'aSecretKey',
        'truncatedReference': 'aTruncatedReference',
      };
      expect(
        RelationshipTemplateDTO.fromJson(json),
        equals(const RelationshipTemplateDTO(
          id: 'anId',
          isOwn: true,
          createdBy: 'aCreatorAddress',
          createdByDevice: 'aCreatorDeviceId',
          createdAt: '2023',
          content: RelationshipTemplateContent(
            onNewRelationship: Request(items: [
              CreateAttributeRequestItem(mustBeAccepted: true, attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity'))),
            ]),
          ),
          expiresAt: '2024',
          maxNumberOfAllocations: 1,
          secretKey: 'aSecretKey',
          truncatedReference: 'aTruncatedReference',
        )),
      );
    });
  });
}
