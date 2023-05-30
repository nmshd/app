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
      final relationshipsResult = await session.transportServices.relationships.getRelationships();

      final relationships = relationshipsResult.value;

      expect(relationships, isA<List<RelationshipDTO>>());
      expect(relationships.length, 0);
    });

    test('returns a valid list of RelationshipDTOs', () async {
      final establishedRelationship = await establishRelationship(session, connectorClient);

      final relationshipsResult = await session.transportServices.relationships.getRelationships();

      final relationships = relationshipsResult.value;

      expect(relationships.length, 1);
      expect(relationships, isA<List<RelationshipDTO>>());
      expect(relationships.first.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: getRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationship(session, connectorClient);

      final relationshipResult = await session.transportServices.relationships.getRelationship(relationshipId: establishedRelationship.id);

      final relationship = relationshipResult.value;

      expect(relationship.id, establishedRelationship.id);
      expect(relationship, isA<RelationshipDTO>());
    });

    test('throws an exception on empty relationship id', () async {
      final result = await session.transportServices.relationships.getRelationship(relationshipId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception if relationship id does not match the pattern', () async {
      final result = await session.transportServices.relationships.getRelationship(relationshipId: 'id123456789');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception on not existing relationship id', () async {
      final result = await session.transportServices.relationships.getRelationship(relationshipId: 'RELteStILdJnqAA0PiE0');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('RelationshipsFacade: getRelationshipByAddress', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationship(session, connectorClient);
      final relationships = await session.transportServices.relationships.getRelationships();

      final relationshipResult = await session.transportServices.relationships.getRelationshipByAddress(
        address: relationships.value.first.peerIdentity.address,
      );

      final relationship = relationshipResult.value;

      expect(relationship.id, establishedRelationship.id);
      expect(relationship, isA<RelationshipDTO>());
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

      final relationshipResult = await session.transportServices.relationships.createRelationship(
        templateId: item.relationshipTemplateValue.id,
        content: {},
      );

      final relationship = relationshipResult.value;

      expect(relationship, isA<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: acceptRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationshipAndSync(session, connectorClient);

      final responseResult = await session.transportServices.relationships.acceptRelationshipChange(
        relationshipId: establishedRelationship.id,
        changeId: establishedRelationship.changes.first.id,
        content: {'a': 'b'},
      );

      final response = responseResult.value;

      expect(response.id, establishedRelationship.id);
      expect(response, isA<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: rejectRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationshipAndSync(session, connectorClient);

      final responseResult = await session.transportServices.relationships.rejectRelationshipChange(
        relationshipId: establishedRelationship.id,
        changeId: establishedRelationship.changes.first.id,
        content: {'a': 'b'},
      );

      final response = responseResult.value;

      expect(response.id, establishedRelationship.id);
      expect(response, isA<RelationshipDTO>());
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

      final responseResult = await session.transportServices.relationships.getAttributesForRelationship(relationshipId: establishedRelationship.id);

      final response = responseResult.value;

      expect(response, isA<List<LocalAttributeDTO>>());
      expect(response.length, 2);
    });
  });
}
