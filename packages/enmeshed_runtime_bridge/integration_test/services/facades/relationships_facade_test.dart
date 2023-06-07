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
    testWidgets('returns an empty list when no Relationships exists', (_) async {
      final relationshipsResult = await session.transportServices.relationships.getRelationships();

      final relationships = relationshipsResult.value;

      expect(relationships, isInstanceOf<List<RelationshipDTO>>());
      expect(relationships.length, 0);
    });

    testWidgets('returns a valid list of RelationshipDTOs', (_) async {
      final establishedRelationship = await establishRelationship(session, connectorClient);

      final relationshipsResult = await session.transportServices.relationships.getRelationships();

      final relationships = relationshipsResult.value;

      expect(relationships.length, 1);
      expect(relationships, isInstanceOf<List<RelationshipDTO>>());
      expect(relationships.first.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: getRelationship', () {
    testWidgets('returns a valid RelationshipDTO', (_) async {
      final establishedRelationship = await establishRelationship(session, connectorClient);

      final relationshipResult = await session.transportServices.relationships.getRelationship(relationshipId: establishedRelationship.id);

      final relationship = relationshipResult.value;

      expect(relationship.id, establishedRelationship.id);
      expect(relationship, isInstanceOf<RelationshipDTO>());
    });

    testWidgets('throws an exception on empty relationship id', (_) async {
      final result = await session.transportServices.relationships.getRelationship(relationshipId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception if relationship id does not match the pattern', (_) async {
      final result = await session.transportServices.relationships.getRelationship(relationshipId: 'id123456789');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception on not existing relationship id', (_) async {
      final result = await session.transportServices.relationships.getRelationship(relationshipId: 'RELteStILdJnqAA0PiE0');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('RelationshipsFacade: getRelationshipByAddress', () {
    testWidgets('returns a valid RelationshipDTO', (_) async {
      final establishedRelationship = await establishRelationship(session, connectorClient);
      final relationships = await session.transportServices.relationships.getRelationships();

      final relationshipResult = await session.transportServices.relationships.getRelationshipByAddress(
        address: relationships.value.first.peerIdentity.address,
      );

      final relationship = relationshipResult.value;

      expect(relationship.id, establishedRelationship.id);
      expect(relationship, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: createRelationship', () {
    testWidgets('returns a valid RelationshipDTO', (_) async {
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

      expect(relationship, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: acceptRelationshipChange', () {
    testWidgets('returns a valid RelationshipDTO', (_) async {
      final establishedRelationship = await establishRelationshipAndSync(session, connectorClient);

      final responseResult = await session.transportServices.relationships.acceptRelationshipChange(
        relationshipId: establishedRelationship.id,
        changeId: establishedRelationship.changes.first.id,
        content: {'a': 'b'},
      );

      final response = responseResult.value;

      expect(response.id, establishedRelationship.id);
      expect(response, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: rejectRelationshipChange', () {
    testWidgets('returns a valid RelationshipDTO', (_) async {
      final establishedRelationship = await establishRelationshipAndSync(session, connectorClient);

      final responseResult = await session.transportServices.relationships.rejectRelationshipChange(
        relationshipId: establishedRelationship.id,
        changeId: establishedRelationship.changes.first.id,
        content: {'a': 'b'},
      );

      final response = responseResult.value;

      expect(response.id, establishedRelationship.id);
      expect(response, isInstanceOf<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: getAttributesForRelationship', () {
    testWidgets('returns a valid list of LocalAttributeDTOs', (_) async {
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

      expect(response, isInstanceOf<List<LocalAttributeDTO>>());
      expect(response.length, 2);
    });
  });
}
