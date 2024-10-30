import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

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
    test('should return an empty list when no relationships exists', () async {
      final relationshipsResult = await session1.transportServices.relationships.getRelationships();

      expect(relationshipsResult, isSuccessful<List<RelationshipDTO>>());
      expect(relationshipsResult.value.length, 0);
    });

    test('should return a valid list of relationships', () async {
      final establishedRelationship = await establishRelationship(requestor: session1, templator: session2);

      final relationshipsResult = await session1.transportServices.relationships.getRelationships();

      expect(relationshipsResult, isSuccessful<List<RelationshipDTO>>());
      expect(relationshipsResult.value.length, 1);
      expect(relationshipsResult.value.first.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: getRelationship', () {
    test('should return a valid relationship by entering id', () async {
      final establishedRelationship = await establishRelationship(requestor: session1, templator: session2);

      final relationshipResult = await session1.transportServices.relationships.getRelationship(relationshipId: establishedRelationship.id);

      expect(relationshipResult, isSuccessful<RelationshipDTO>());
      expect(relationshipResult.value.id, establishedRelationship.id);
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
    test('should return a valid relationship by entering address', () async {
      final establishedRelationship = await establishRelationship(requestor: session1, templator: session2);
      final relationships = await session1.transportServices.relationships.getRelationships();

      final relationshipResult = await session1.transportServices.relationships.getRelationshipByAddress(
        address: relationships.value.first.peerIdentity.address,
      );

      expect(relationshipResult, isSuccessful<RelationshipDTO>());
      expect(relationshipResult.value.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: createRelationship', () {
    test('should create a relationship', () async {
      final responseTemplate = await session2.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: generateExpiryString(),
        content: emptyRelationshipTemplateContent,
      );

      final item = await session1.transportServices.account.loadItemFromTruncatedReference(
        reference: responseTemplate.value.truncatedReference,
      );

      final canCreateRelationshipResult = await session1.transportServices.relationships.canCreateRelationship(
        templateId: item.value.relationshipTemplateValue.id,
        creationContent: emptyRelationshipCreationContent,
      );

      expect(canCreateRelationshipResult, isSuccessful<CanCreateRelationshipResponse>());
      expect(canCreateRelationshipResult.value.isSuccess, true);

      final relationshipResult = await session1.transportServices.relationships.createRelationship(
        templateId: item.value.relationshipTemplateValue.id,
        creationContent: emptyRelationshipCreationContent,
      );

      expect(relationshipResult, isSuccessful<RelationshipDTO>());
    });

    test('returns error if templator has active IdentityDeletionProcess', () async {
      final responseTemplate = await session2.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: generateExpiryString(),
        content: emptyRelationshipTemplateContent,
      );

      final item = await session1.transportServices.account.loadItemFromTruncatedReference(
        reference: responseTemplate.value.truncatedReference,
      );

      await session2.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();

      final canCreateResult = await session1.transportServices.relationships.canCreateRelationship(
        templateId: item.value.relationshipTemplateValue.id,
        creationContent: emptyRelationshipCreationContent,
      );

      expect(canCreateResult, isSuccessful<CanCreateRelationshipResponse>());
      expect(canCreateResult.value.isSuccess, false);
      expect((canCreateResult.value as CanCreateRelationshipFailureResponse).code,
          'error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate');
      expect((canCreateResult.value as CanCreateRelationshipFailureResponse).message,
          'The Identity who created the RelationshipTemplate is currently in the process of deleting itself. Thus, it is not possible to establish a Relationship to it.');

      final result = await session1.transportServices.relationships.createRelationship(
        templateId: item.value.relationshipTemplateValue.id,
        creationContent: emptyRelationshipCreationContent,
      );

      expect(result, isFailing('error.transport.relationships.activeIdentityDeletionProcessOfOwnerOfRelationshipTemplate'));
    });
  });

  group('RelationshipsFacade: acceptRelationship', () {
    test('should accept a relationship', () async {
      final establishedRelationship = await establishRelationshipAndSync(requestor: session1, templator: session2);

      final responseResult = await session2.transportServices.relationships.acceptRelationship(relationshipId: establishedRelationship.id);

      expect(responseResult, isSuccessful<RelationshipDTO>());
      expect(responseResult.value.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: rejectRelationship', () {
    test('should reject a relationship', () async {
      final establishedRelationship = await establishRelationshipAndSync(requestor: session1, templator: session2);

      final responseResult = await session2.transportServices.relationships.rejectRelationship(relationshipId: establishedRelationship.id);

      expect(responseResult, isSuccessful<RelationshipDTO>());
      expect(responseResult.value.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: revokeRelationship', () {
    test('should revoke a relationship', () async {
      final establishedRelationship = await establishRelationship(requestor: session1, templator: session2);

      final responseResult = await session1.transportServices.relationships.revokeRelationship(relationshipId: establishedRelationship.id);

      expect(responseResult, isSuccessful<RelationshipDTO>());
      expect(responseResult.value.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: getAttributesForRelationship', () {
    test('should return a valid list of LocalAttributeDTOs', () async {
      final establishedRelationship = await ensureActiveRelationship(session1, session2);

      await exchangeIdentityAttribute(session2, session1, const DisplayNameAttributeValue(value: 'ADisplayName'));
      await exchangeIdentityAttribute(session1, session2, const DisplayNameAttributeValue(value: 'BDisplayName'));

      final responseResult = await session1.transportServices.relationships.getAttributesForRelationship(relationshipId: establishedRelationship.id);

      expect(responseResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(responseResult.value.length, 2);
    });
  });

  group('RelationshipsFacade: terminateRelationship', () {
    test('should terminate a relationship', () async {
      final establishedRelationship = await ensureActiveRelationship(session1, session2);

      final responseResult = await session1.transportServices.relationships.terminateRelationship(relationshipId: establishedRelationship.id);

      expect(responseResult, isSuccessful<RelationshipDTO>());
      expect(responseResult.value.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: requestRelationshipReactivation / acceptRelationshipReactivation', () {
    test('should request the reactivation of a relationship and then accept it', () async {
      final establishedRelationship = await ensureTerminatedRelationship(session1, session2);

      final reactivationRequestResult =
          await session1.transportServices.relationships.requestRelationshipReactivation(relationshipId: establishedRelationship.id);

      expect(reactivationRequestResult, isSuccessful<RelationshipDTO>());
      expect(reactivationRequestResult.value.id, establishedRelationship.id);

      await syncUntilHasRelationship(session2);
      final acceptanceResult =
          await session2.transportServices.relationships.acceptRelationshipReactivation(relationshipId: establishedRelationship.id);
      expect(acceptanceResult, isSuccessful<RelationshipDTO>());
      expect(acceptanceResult.value.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: requestRelationshipReactivation / revokeRelationshipReactivation', () {
    test('should request the reactivation of a relationship and then revoke it', () async {
      final establishedRelationship = await ensureTerminatedRelationship(session1, session2);

      final reactivationRequestResult =
          await session1.transportServices.relationships.requestRelationshipReactivation(relationshipId: establishedRelationship.id);

      expect(reactivationRequestResult, isSuccessful<RelationshipDTO>());
      expect(reactivationRequestResult.value.id, establishedRelationship.id);

      final revocationResult =
          await session1.transportServices.relationships.revokeRelationshipReactivation(relationshipId: establishedRelationship.id);
      expect(revocationResult, isSuccessful<RelationshipDTO>());
      expect(revocationResult.value.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: requestRelationshipReactivation / rejectRelationshipReactivation', () {
    test('should request the reactivation of a relationship and then reject it', () async {
      final establishedRelationship = await ensureTerminatedRelationship(session1, session2);

      final reactivationRequestResult =
          await session1.transportServices.relationships.requestRelationshipReactivation(relationshipId: establishedRelationship.id);

      expect(reactivationRequestResult, isSuccessful<RelationshipDTO>());
      expect(reactivationRequestResult.value.id, establishedRelationship.id);

      await syncUntilHasRelationship(session2);
      final rejectionResult =
          await session2.transportServices.relationships.rejectRelationshipReactivation(relationshipId: establishedRelationship.id);
      expect(rejectionResult, isSuccessful<RelationshipDTO>());
      expect(rejectionResult.value.id, establishedRelationship.id);
    });
  });

  group('RelationshipsFacade: decomposeRelationship', () {
    test('should decompose a relationship', () async {
      final establishedRelationship = await ensureTerminatedRelationship(session1, session2);

      final decompositionResult = await session1.transportServices.relationships.decomposeRelationship(relationshipId: establishedRelationship.id);

      expect(decompositionResult, isSuccessful<void>());
    });
  });
}
