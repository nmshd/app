import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';
import '../../utils.dart';

void run(EnmeshedRuntime runtime) {
  late Session session1;
  late Session session2;

  setUpAll(() async {
    final account1 = await runtime.accountServices.createAccount(name: 'relationshipTemplateFacade Test 1');
    session1 = runtime.getSession(account1.id);

    final account2 = await runtime.accountServices.createAccount(name: 'relationshipTemplateFacade Test 2');
    session2 = runtime.getSession(account2.id);
  });

  group('RelationshipTemplatesFacade: createOwnRelationshipTemplate', () {
    test('should create a template', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final templateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      expect(templateResult, isSuccessful<RelationshipTemplateDTO>());
      expect(templateResult.value.expiresAt, expiresAt);
      expect(templateResult.value.content.toJson(), content);
    });

    test('should create a template with all properties', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};
      const maxNumberOfAllocations = 1;

      final templateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: maxNumberOfAllocations,
      );

      expect(templateResult, isSuccessful<RelationshipTemplateDTO>());
      expect(templateResult.value.expiresAt, expiresAt);
      expect(templateResult.value.content.toJson(), content);
      expect(templateResult.value.maxNumberOfAllocations, maxNumberOfAllocations);
    });
  });

  group('RelationshipTemplatesFacade: loadPeerRelationshipTemplateByIdAndKey', () {
    test('should allow to load template of peer by entering id and key', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final responseTemplate = await session2.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final templateResult = await session1.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByIdAndKey(
        relationshipTemplateId: responseTemplate.value.id,
        secretKey: responseTemplate.value.secretKey,
      );

      expect(templateResult, isSuccessful<RelationshipTemplateDTO>());
      expect(templateResult.value.expiresAt, expiresAt);
      expect(templateResult.value.content.toJson(), content);
      expect(templateResult.value.id, responseTemplate.value.id);
      expect(templateResult.value.secretKey, responseTemplate.value.secretKey);
    });
  });

  group('RelationshipTemplatesFacade: loadPeerRelationshipTemplateByReference', () {
    test('should allow to load template of peer by entering reference', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final responseTemplate = await session2.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final templateResult = await session1.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByReference(
        reference: responseTemplate.value.truncatedReference,
      );

      expect(templateResult, isSuccessful<RelationshipTemplateDTO>());
      expect(templateResult.value.expiresAt, expiresAt);
      expect(templateResult.value.content.toJson(), content);
      expect(templateResult.value.truncatedReference, responseTemplate.value.truncatedReference);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplates', () {
    test('should return the correct amount of own relationship templates', () async {
      final expiresAt = generateExpiryString();
      final currentTemplates = await session1.transportServices.relationshipTemplates.getRelationshipTemplates();

      expect(currentTemplates, isSuccessful<List<RelationshipTemplateDTO>>());

      await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: {'aKey': 'aValue'},
        maxNumberOfAllocations: 1,
      );

      final allTemplates = await session1.transportServices.relationshipTemplates.getRelationshipTemplates();

      expect(allTemplates, isSuccessful<List<RelationshipTemplateDTO>>());
      expect(allTemplates.value.length, greaterThan(currentTemplates.value.length));
    });

    test('should return the correct amount of own relationship templates with all properties', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: 1,
      );

      await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: generateExpiryString(),
        content: content,
        maxNumberOfAllocations: 2,
      );

      final templatesWithQueryExpiresAt = await session1.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'expiresAt': QueryValue.string(expiresAt)},
      );

      expect(templatesWithQueryExpiresAt, isSuccessful<List<RelationshipTemplateDTO>>());

      final templatesWithNoResponse = await session1.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'expiresAt': QueryValue.string('2023')},
      );

      expect(templatesWithNoResponse, isSuccessful<List<RelationshipTemplateDTO>>());

      final templatesWithQueryMnoa = await session1.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'maxNumberOfAllocations': QueryValue.string('1')},
      );

      expect(templatesWithQueryMnoa, isSuccessful<List<RelationshipTemplateDTO>>());
      expect(templatesWithQueryExpiresAt.value.length, 1);
      expect(templatesWithNoResponse.value.length, 0);
      expect(templatesWithQueryMnoa.value.where((e) => e.maxNumberOfAllocations != 1).length, 0);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplate', () {
    test('should return a valid relationship template', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplate = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final template = await session1.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: createdTemplate.value.id,
      );

      expect(template, isSuccessful<RelationshipTemplateDTO>());
      expect(template.value.expiresAt, expiresAt);
      expect(template.value.content.toJson(), content);
    });

    test('throws an exception on empty template id', () async {
      final result = await session1.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: '',
      );

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception if template id do not match the pattern', () async {
      final result = await session1.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: 'RTLX123456789',
      );

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing template id', () async {
      final result = await session1.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: 'RLTXZKg9TestveduKiGs',
      );

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('RelationshipTemplatesFacade: createQrCodeForOwnTemplate', () {
    test('should return a valid CreateQrCodeResponse', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session1.transportServices.relationshipTemplates.createQrCodeForOwnTemplate(
        templateId: createdTemplateResult.value.id,
      );

      expect(response, isSuccessful<CreateQrCodeResponse>());
    });
  });

  group('RelationshipTemplatesFacade: createTokenQrCodeForOwnTemplate', () {
    test('should return a valid CreateQrCodeResponse', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session1.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(
        templateId: createdTemplateResult.value.id,
      );

      expect(response, isSuccessful<CreateQrCodeResponse>());
    });

    test('should return a valid CreateQrCodeResponse with all properties', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session1.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(
        templateId: createdTemplateResult.value.id,
        expiresAt: expiresAt,
      );

      expect(response, isSuccessful<CreateQrCodeResponse>());
    });
  });

  group('RelationshipTemplatesFacade: createTokenForOwnTemplate', () {
    test('should return a valid TokenDTO', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplate = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final tokenResult = await session1.transportServices.relationshipTemplates.createTokenForOwnTemplate(
        templateId: createdTemplate.value.id,
      );

      expect(tokenResult, isSuccessful<TokenDTO>());
      expect(tokenResult.value.expiresAt, expiresAt);
    });

    test('should return a valid TokenDTO with all properties', () async {
      final expiresAt = generateExpiryString();
      final createdTemplateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: {'a': 'b'},
      );

      final tokenResult = await session1.transportServices.relationshipTemplates.createTokenForOwnTemplate(
        templateId: createdTemplateResult.value.id,
        expiresAt: expiresAt,
        ephemeral: true,
      );

      expect(tokenResult, isSuccessful<TokenDTO>());
      expect(tokenResult.value.expiresAt, expiresAt);
      expect(tokenResult.value.expiresAt, createdTemplateResult.value.expiresAt);
      expect(tokenResult.value.isEphemeral, true);
    });
  });
}
