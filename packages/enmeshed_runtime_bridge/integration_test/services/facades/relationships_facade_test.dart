import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';
import '../../utils.dart';

void run(EnmeshedRuntime runtime) {
  late Session session1;
  late Session session2;

  setUp(() async {
    final account1 = await runtime.accountServices.createAccount(name: 'relationshipFacade Test 1');
    session1 = runtime.getSession(account1.id);

    final account2 = await runtime.accountServices.createAccount(name: 'relationshipFacade Test 2');
    session2 = runtime.getSession(account2.id);
  });

  group('RelationshipsFacade: getRelationships', () {
    test('returns an empty list when no Relationships exists', () async {
      final relationshipsResult = await session1.transportServices.relationships.getRelationships();

      final relationships = relationshipsResult.value;

      expect(relationships, isA<List<RelationshipDTO>>());
      expect(relationships.length, 0);
    });

    test('returns a valid list of RelationshipDTOs', () async {
      final establishedRelationship = await establishRelationship(session1, session2);

      final relationshipsResult = await session1.transportServices.relationships.getRelationships();

      final relationships = relationshipsResult.value;

      expect(relationships.length, 1);
      expect(relationships, isA<List<RelationshipDTO>>());
      expect(relationships.first.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: getRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationship(session1, session2);

      final relationshipResult = await session1.transportServices.relationships.getRelationship(relationshipId: establishedRelationship.id);

      final relationship = relationshipResult.value;

      expect(relationship.id, establishedRelationship.id);
      expect(relationship, isA<RelationshipDTO>());
    });

    test('throws an exception on empty relationship id', () async {
      final result = await session1.transportServices.relationships.getRelationship(relationshipId: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception if relationship id does not match the pattern', () async {
      final result = await session1.transportServices.relationships.getRelationship(relationshipId: 'id123456789');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing relationship id', () async {
      final result = await session1.transportServices.relationships.getRelationship(relationshipId: 'RELteStILdJnqAA0PiE0');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('RelationshipsFacade: getRelationshipByAddress', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationship(session1, session2);
      final relationships = await session1.transportServices.relationships.getRelationships();

      final relationshipResult = await session1.transportServices.relationships.getRelationshipByAddress(
        address: relationships.value.first.peerIdentity.address,
      );

      final relationship = relationshipResult.value;

      expect(relationship.id, establishedRelationship.id);
      expect(relationship, isA<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: createRelationship', () {
    test('returns a valid RelationshipDTO', () async {
      final responseTemplate = await session2.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: generateExpiryString(),
        content: {},
      );

      final item = await session1.transportServices.account.loadItemFromTruncatedReference(
        reference: responseTemplate.value.truncatedReference,
      );

      final relationshipResult = await session1.transportServices.relationships.createRelationship(
        templateId: item.value.relationshipTemplateValue.id,
        content: {},
      );

      final relationship = relationshipResult.value;

      expect(relationship, isA<RelationshipDTO>());
    });
  });

  group('RelationshipsFacade: acceptRelationshipChange', () {
    test('returns a valid RelationshipDTO', () async {
      final establishedRelationship = await establishRelationshipAndSync(session1, session2);

      final responseResult = await session1.transportServices.relationships.acceptRelationshipChange(
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
      final establishedRelationship = await establishRelationshipAndSync(session1, session2);

      final responseResult = await session1.transportServices.relationships.rejectRelationshipChange(
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
      final establishedRelationship = await establishRelationship(session1, session2);

      final attribute = await session1.consumptionServices.attributes.createAttribute(
        content: const IdentityAttribute(owner: 'address', value: SurnameAttributeValue(value: 'aSurname')).toJson(),
      );

      const fakeRequestReference = 'REQ00000000000000000';
      await session1.consumptionServices.attributes.createSharedAttributeCopy(
        attributeId: attribute.value.id,
        peer: establishedRelationship.peer,
        requestReference: fakeRequestReference,
      );

      await session1.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: establishedRelationship.peer, value: const SurnameAttributeValue(value: 'aPeerSurname')).toJson(),
      );

      final responseResult = await session1.transportServices.relationships.getAttributesForRelationship(relationshipId: establishedRelationship.id);

      final response = responseResult.value;

      expect(response, isA<List<LocalAttributeDTO>>());
      expect(response.length, 2);
    });
  });
}
