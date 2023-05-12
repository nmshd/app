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
    test('returns an empty list when no Relationships exists', () async {
      final relationships = await session.transportServices.relationships.getRelationships();

      expect(relationships, isInstanceOf<List<RelationshipDTO>>());
      expect(relationships.length, 0);
    });

    test('returns a valid list of RelationshipDTOs', () async {
      final establishedRelationship = await establishRelationship(session, connectorClient);

      final relationships = await session.transportServices.relationships.getRelationships();

      expect(relationships.length, 1);
      expect(relationships, isInstanceOf<List<RelationshipDTO>>());
      expect(relationships.first.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: getRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationship(session, connectorClient);

      final relationship = await session.transportServices.relationships.getRelationship(relationshipId: establishedRelationship.id);

      expect(relationship.id, establishedRelationship.id);
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
          '  "message": "Relationship not found. Make sure the ID exists and the record is not expired."\n'
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
      final establishedRelationship = await establishRelationship(session, connectorClient);
      final relationships = await session.transportServices.relationships.getRelationships();

      final relationship = await session.transportServices.relationships.getRelationshipByAddress(address: relationships.first.peerIdentity.address);

      expect(relationship.id, establishedRelationship.id);
      expect(relationship, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: createRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
        content: {},
      );

      final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
        reference: responseTemplate.data.truncatedReference,
      );

      final relationship = await session.transportServices.relationships.createRelationship(
        templateId: item.relationshipTemplateValue.id,
        content: {},
      );

      expect(relationship, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: acceptRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationshipAndSync(session, connectorClient);

      final response = await session.transportServices.relationships.acceptRelationshipChange(
        relationshipId: establishedRelationship.id,
        changeId: establishedRelationship.changes.first.id,
        content: {'a': 'b'},
      );

      expect(response.id, establishedRelationship.id);
      expect(response, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: rejectRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationshipAndSync(session, connectorClient);

      final response = await session.transportServices.relationships.rejectRelationshipChange(
        relationshipId: establishedRelationship.id,
        changeId: establishedRelationship.changes.first.id,
        content: {'a': 'b'},
      );

      expect(response.id, establishedRelationship.id);
      expect(response, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: getAttributesForRelationship', () {
    test('returns a valid list of LocalAttributeDTOs', () async {
      final establishedRelationship = await establishRelationship(session, connectorClient);

      final attribute = await session.consumptionServices.attributes.createAttribute(
        content: const IdentityAttribute(owner: 'address', value: SurnameAttributeValue(value: 'aSurname')).toJson(),
      );

      const fakeRequestReference = 'REQ00000000000000000';
      await session.consumptionServices.attributes.createSharedAttributeCopy(
        attributeId: attribute.id,
        peer: establishedRelationship.peer,
        requestReference: fakeRequestReference,
      );

      await session.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: establishedRelationship.peer, value: const SurnameAttributeValue(value: 'aPeerSurname')).toJson(),
      );

      final response = await session.transportServices.relationships.getAttributesForRelationship(relationshipId: establishedRelationship.id);

      expect(response, isInstanceOf<List<LocalAttributeDTO>>());
      expect(response.length, 2);
    });
  });
}
