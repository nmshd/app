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
    test('''returns a valid list of RelationshipDTO's''', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
        reference: responseTemplate.data.truncatedReference,
      );

      final template = item.relationshipTemplateValue;

      final relationshipsBeforeCreate = await session.transportServices.relationships.getRelationships();

      expect(0, relationshipsBeforeCreate.length);

      final relationship = await session.transportServices.relationships.createRelationship(
        templateId: template.id,
        content: {'City': 'aCity'},
      );

      expect(expiresAt, relationship.template.expiresAt);
      expect(content, relationship.template.content.toJson());
      expect(RelationshipDTO, relationship.runtimeType);

      final relationships = await session.transportServices.relationships.getRelationships();

      expect(1, relationships.length);
      expect(List<RelationshipDTO>, relationships.runtimeType);
    });
  });

  group('RelationshipsFacade: getRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
        reference: responseTemplate.data.truncatedReference,
      );

      final template = item.relationshipTemplateValue;

      final createdRelationship = await session.transportServices.relationships.createRelationship(
        templateId: template.id,
        content: {'City': 'aCity'},
      );

      final relationship = await session.transportServices.relationships.getRelationship(relationshipId: createdRelationship.id);

      expect(expiresAt, createdRelationship.template.expiresAt);
      expect(content, createdRelationship.template.content.toJson());
      expect(RelationshipDTO, createdRelationship.runtimeType);

      expect(expiresAt, relationship.template.expiresAt);
      expect(content, relationship.template.content.toJson());
      expect(relationship.id, createdRelationship.id);
      expect(RelationshipDTO, relationship.runtimeType);
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
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
        reference: responseTemplate.data.truncatedReference,
      );

      final template = item.relationshipTemplateValue;

      final createdRelationship = await session.transportServices.relationships.createRelationship(
        templateId: template.id,
        content: {'City': 'aCity'},
      );

      final relationships = await session.transportServices.relationships.getRelationships();
      final address = relationships.first.peerIdentity.address;

      final relationship = await session.transportServices.relationships.getRelationshipByAddress(address: address);

      expect(expiresAt, createdRelationship.template.expiresAt);
      expect(content, createdRelationship.template.content.toJson());
      expect(RelationshipDTO, createdRelationship.runtimeType);

      expect(expiresAt, relationship.template.expiresAt);
      expect(content, relationship.template.content.toJson());
      expect(relationship.id, createdRelationship.id);
      expect(RelationshipDTO, relationship.runtimeType);
    });
  });

  group('RelationshipsFacade: createRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
        reference: responseTemplate.data.truncatedReference,
      );

      final template = item.relationshipTemplateValue;

      final relationship = await session.transportServices.relationships.createRelationship(
        templateId: template.id,
        content: {'City': 'aCity'},
      );

      expect(expiresAt, relationship.template.expiresAt);
      expect(content, relationship.template.content.toJson());
      expect(RelationshipDTO, relationship.runtimeType);
    });
  });

  group('RelationshipsFacade: acceptRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();

      final sessionTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(expiresAt: expiresAt, content: {});
      expect(RelationshipTemplateDTO, sessionTemplate.runtimeType);

      final connectorLoadTemplate = await connectorClient.relationshipTemplates.loadPeerRelationshipTemplateByTruncatedReference(
        sessionTemplate.truncatedReference,
      );
      expect(ConnectorResponse<RelationshipTemplateDTO>, connectorLoadTemplate.runtimeType);

      final relationship = await connectorClient.relationships.createRelationship(templateId: connectorLoadTemplate.data.id, content: {'a': 'b'});
      expect(ConnectorResponse<RelationshipDTO>, relationship.runtimeType);

      final syncResult = await session.transportServices.accounts.syncEverything();
      expect(SyncEverythingResponse, syncResult.runtimeType);

      final relationships = syncResult.relationships;
      final relationshipId = relationships[0].id;
      final relationshipChangeId = relationships[0].changes[0].id;

      final response = await session.transportServices.relationships
          .acceptRelationshipChange(relationshipId: relationshipId, changeId: relationshipChangeId, content: {'a': 'b'});

      expect(RelationshipDTO, response.runtimeType);
    });
  });

  group('RelationshipsFacade: rejectRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();

      final sessionTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(expiresAt: expiresAt, content: {});
      expect(RelationshipTemplateDTO, sessionTemplate.runtimeType);

      final connectorLoadTemplate = await connectorClient.relationshipTemplates.loadPeerRelationshipTemplateByTruncatedReference(
        sessionTemplate.truncatedReference,
      );
      expect(ConnectorResponse<RelationshipTemplateDTO>, connectorLoadTemplate.runtimeType);

      final relationship = await connectorClient.relationships.createRelationship(templateId: connectorLoadTemplate.data.id, content: {'a': 'b'});
      expect(ConnectorResponse<RelationshipDTO>, relationship.runtimeType);

      final syncResult = await session.transportServices.accounts.syncEverything();
      expect(SyncEverythingResponse, syncResult.runtimeType);

      final relationships = syncResult.relationships;
      final relationshipId = relationships[0].id;
      final relationshipChangeId = relationships[0].changes[0].id;

      final response = await session.transportServices.relationships
          .rejectRelationshipChange(relationshipId: relationshipId, changeId: relationshipChangeId, content: {'a': 'b'});

      expect(RelationshipDTO, response.runtimeType);
    });
  });

  group('RelationshipsFacade: getAttributesForRelationship', () {
    test('''returns a valid list of LocalAttributeDTO's''', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final connectorTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );
      final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
        reference: connectorTemplate.data.truncatedReference,
      );
      final template = item.relationshipTemplateValue;

      final createdRelationship = await session.transportServices.relationships.createRelationship(
        templateId: template.id,
        content: {'City': 'aCity'},
      );

      final relationship = await session.transportServices.relationships.getRelationship(relationshipId: createdRelationship.id);

      final attribute = await session.consumptionServices.attributes.createAttribute(
        content: const IdentityAttribute(owner: 'address', value: SurnameAttributeValue(value: 'aSurname')).toJson(),
      );

      const fakeRequestReference = 'REQ00000000000000000';
      await session.consumptionServices.attributes
          .createSharedAttributeCopy(attributeId: attribute.id, peer: relationship.peer, requestReference: fakeRequestReference);

      await session.consumptionServices.attributes
          .createAttribute(content: IdentityAttribute(owner: relationship.peer, value: const SurnameAttributeValue(value: 'aPeerSurname')).toJson());

      final response = await session.transportServices.relationships.getAttributesForRelationship(relationshipId: relationship.id);

      expect(expiresAt, createdRelationship.template.expiresAt);
      expect(content, createdRelationship.template.content.toJson());
      expect(RelationshipDTO, createdRelationship.runtimeType);

      expect(expiresAt, relationship.template.expiresAt);
      expect(content, relationship.template.content.toJson());
      expect(relationship.id, createdRelationship.id);
      expect(RelationshipDTO, relationship.runtimeType);

      expect(List<LocalAttributeDTO>, response.runtimeType);
      expect(2, response.length);
    });
  });
}
