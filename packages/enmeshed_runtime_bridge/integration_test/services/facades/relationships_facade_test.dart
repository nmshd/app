import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils.dart';

void run(EnmeshedRuntime runtime, ConnectorClient connectorClient) {
  late Session session;

  setUp(() async {
    final account = await runtime.accountServices.createAccount(name: 'relationshipFacade Test');
    session = runtime.getSession(account.id);
  });

  group('RelationshipsFacade: getRelationships', () {
    test('returns a valid list of RelationshipDTOs', () async {
      final expiresAt = DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

      final responseTemplate = await createConnectorTemplate(connectorClient, expiresAt);
      final item = await loadItem(session, responseTemplate.data.truncatedReference);
      final template = item.relationshipTemplateValue;

      final relationshipsBeforeCreate = await session.transportServices.relationships.getRelationships();

      expect(0, relationshipsBeforeCreate.length);

      final relationship = await createRelationship(session, template.id, {'a': 'b'});

      expect(relationship.template.expiresAt, expiresAt);
      expect(relationship.template.content.toJson(), {});
      expect(relationship, isInstanceOf<RelationshipDTO>());

      final relationships = await session.transportServices.relationships.getRelationships();

      expect(relationships.length, 1);
      expect(relationships, isInstanceOf<List<RelationshipDTO>>());
    });
  });

  group('RelationshipsFacade: getRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

      final responseTemplate = await createConnectorTemplate(connectorClient, expiresAt);
      final item = await loadItem(session, responseTemplate.data.truncatedReference);
      final template = item.relationshipTemplateValue;
      final createdRelationship = await createRelationship(session, template.id, {'a': 'b'});

      final relationship = await session.transportServices.relationships.getRelationship(relationshipId: createdRelationship.id);

      expect(createdRelationship.template.expiresAt, expiresAt);
      expect(createdRelationship.template.content.toJson(), {});
      expect(relationship, isInstanceOf<RelationshipDTO>());

      expect(relationship.template.expiresAt, expiresAt);
      expect(relationship.template.content.toJson(), {});
      expect(relationship.id, createdRelationship.id);
      expect(relationship, isInstanceOf<RelationshipDTO>());
    });

    test('throws an exception on empty relationship id', () async {
      const expectedErrorMessage = 'Exception: Error: {\n'
          '  "code": "error.runtime.validation.invalidPropertyValue",\n'
          '  "message": "id must match pattern REL[A-Za-z0-9]{17}"\n'
          '}';

      try {
        await session.transportServices.relationships.getRelationship(relationshipId: '');
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
        expect(e.toString(), expectedErrorMessage);
      }
    });

    test('throws an exception if relationship id does not match the pattern', () async {
      const expectedErrorMessage = 'Exception: Error: {\n'
          '  "code": "error.runtime.validation.invalidPropertyValue",\n'
          '  "message": "id must match pattern REL[A-Za-z0-9]{17}"\n'
          '}';

      try {
        await session.transportServices.relationships.getRelationship(relationshipId: 'id123456789');
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
        expect(e.toString(), expectedErrorMessage);
      }
    });

    test('throws an exception on not existing relationship id', () async {
      const expectedErrorMessage = 'Exception: Error: {\n'
          '  "code": "error.runtime.recordNotFound",\n'
          '  "message": "Ux not found. Make sure the ID exists and the record is not expired."\n'
          '}';

      try {
        await session.transportServices.relationships.getRelationship(relationshipId: 'RELteStILdJnqAA0PiE0');
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
        expect(e.toString(), expectedErrorMessage);
      }
    });
  });

  group('RelationshipsFacade: getRelationshipByAddress', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

      final responseTemplate = await createConnectorTemplate(connectorClient, expiresAt);
      final item = await loadItem(session, responseTemplate.data.truncatedReference);
      final template = item.relationshipTemplateValue;
      final createdRelationship = await createRelationship(session, template.id, {'a': 'b'});
      final relationships = await session.transportServices.relationships.getRelationships();
      final address = relationships.first.peerIdentity.address;

      final relationship = await session.transportServices.relationships.getRelationshipByAddress(address: address);

      expect(createdRelationship.template.expiresAt, expiresAt);
      expect(createdRelationship.template.content.toJson(), {});
      expect(relationship, isInstanceOf<RelationshipDTO>());

      expect(relationship.template.expiresAt, expiresAt);
      expect(relationship.template.content.toJson(), {});
      expect(relationship.id, createdRelationship.id);
      expect(relationship, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: createRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

      final responseTemplate = await createConnectorTemplate(connectorClient, expiresAt);
      final item = await loadItem(session, responseTemplate.data.truncatedReference);
      final template = item.relationshipTemplateValue;

      final relationship = await createRelationship(session, template.id, {'a': 'b'});

      expect(relationship.template.expiresAt, expiresAt);
      expect(relationship.template.content.toJson(), {});
      expect(relationship, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: acceptRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

      final sessionTemplate = await createSessionTemplate(session, expiresAt);
      expect(sessionTemplate, isInstanceOf<RelationshipTemplateDTO>());

      final connectorLoadTemplate = await connectorClient.relationshipTemplates.loadPeerRelationshipTemplateByTruncatedReference(
        sessionTemplate.truncatedReference,
      );
      expect(connectorLoadTemplate, isInstanceOf<ConnectorResponse<RelationshipTemplateDTO>>());

      final relationship = await connectorClient.relationships.createRelationship(templateId: connectorLoadTemplate.data.id, content: {'a': 'b'});
      expect(relationship, isInstanceOf<ConnectorResponse<RelationshipDTO>>());

      final syncResult = await session.transportServices.accounts.syncEverything();
      expect(syncResult, isInstanceOf<SyncEverythingResponse>());

      final relationships = syncResult.relationships;
      final relationshipId = relationships[0].id;
      final relationshipChangeId = relationships[0].changes[0].id;

      final response = await session.transportServices.relationships.acceptRelationshipChange(
        relationshipId: relationshipId,
        changeId: relationshipChangeId,
        content: {'a': 'b'},
      );

      expect(response, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: rejectRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

      final sessionTemplate = await createSessionTemplate(session, expiresAt);
      expect(sessionTemplate, isInstanceOf<RelationshipTemplateDTO>());

      final connectorLoadTemplate = await connectorClient.relationshipTemplates.loadPeerRelationshipTemplateByTruncatedReference(
        sessionTemplate.truncatedReference,
      );
      expect(connectorLoadTemplate, isInstanceOf<ConnectorResponse<RelationshipTemplateDTO>>());

      final relationship = await connectorClient.relationships.createRelationship(templateId: connectorLoadTemplate.data.id, content: {'a': 'b'});
      expect(relationship, isInstanceOf<ConnectorResponse<RelationshipDTO>>());

      final syncResult = await session.transportServices.accounts.syncEverything();
      expect(syncResult, isInstanceOf<SyncEverythingResponse>());

      final relationships = syncResult.relationships;
      final relationshipId = relationships[0].id;
      final relationshipChangeId = relationships[0].changes[0].id;

      final response = await session.transportServices.relationships.rejectRelationshipChange(
        relationshipId: relationshipId,
        changeId: relationshipChangeId,
        content: {'a': 'b'},
      );

      expect(response, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: getAttributesForRelationship', () {
    test('returns a valid list of LocalAttributeDTOs', () async {
      final expiresAt = DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

      final connectorTemplate = await createConnectorTemplate(connectorClient, expiresAt);
      final item = await loadItem(session, connectorTemplate.data.truncatedReference);
      final template = item.relationshipTemplateValue;
      final createdRelationship = await createRelationship(session, template.id, {'a': 'b'});
      final relationship = await session.transportServices.relationships.getRelationship(relationshipId: createdRelationship.id);
      final attribute = await session.consumptionServices.attributes.createAttribute(
        content: const IdentityAttribute(owner: 'address', value: SurnameAttributeValue(value: 'aSurname')).toJson(),
      );

      const fakeRequestReference = 'REQ00000000000000000';
      await session.consumptionServices.attributes.createSharedAttributeCopy(
        attributeId: attribute.id,
        peer: relationship.peer,
        requestReference: fakeRequestReference,
      );
      await session.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: relationship.peer, value: const SurnameAttributeValue(value: 'aPeerSurname')).toJson(),
      );

      final response = await session.transportServices.relationships.getAttributesForRelationship(relationshipId: relationship.id);

      expect(createdRelationship.template.expiresAt, expiresAt);
      expect(createdRelationship.template.content.toJson(), {});
      expect(relationship, isInstanceOf<RelationshipDTO>());

      expect(relationship.template.expiresAt, expiresAt);
      expect(relationship.template.content.toJson(), {});
      expect(relationship.id, createdRelationship.id);
      expect(relationship, isInstanceOf<RelationshipDTO>());

      expect(response, isInstanceOf<List<LocalAttributeDTO>>());
      expect(response.length, 2);
    });
  });
}
