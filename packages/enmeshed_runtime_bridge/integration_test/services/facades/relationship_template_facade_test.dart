import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';
import '../../utils.dart';

void run(EnmeshedRuntime runtime, ConnectorClient connectorClient) {
  late Session session;
  setUpAll(() async {
    final account = await runtime.accountServices.createAccount(name: 'relationshipTemplateFacade Test');
    session = runtime.getSession(account.id);
  });

  group('RelationshipTemplatesFacade: createOwnRelationshipTemplate', () {
    test('returns a valid RelationshipTemplateDTO', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final templateResult = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );
      final template = templateResult.value;

      expect(template, isA<RelationshipTemplateDTO>());
      expect(template.expiresAt, expiresAt);
      expect(template.content.toJson(), content);
    });

    test('returns a valid RelationshipTemplateDTO with all properties', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};
      const maxNumberOfAllocations = 1;

      final templateResult = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: maxNumberOfAllocations,
      );
      final template = templateResult.value;

      expect(template, isA<RelationshipTemplateDTO>());
      expect(template.expiresAt, expiresAt);
      expect(template.content.toJson(), content);
      expect(template.maxNumberOfAllocations, maxNumberOfAllocations);
    });
  });

  group('RelationshipTemplatesFacade: loadPeerRelationshipTemplateByIdAndKey', () {
    test('returns a valid RelationshipTemplateDTO', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final templateResult = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByIdAndKey(
        relationshipTemplateId: responseTemplate.data.id,
        secretKey: responseTemplate.data.secretKey,
      );
      final template = templateResult.value;

      expect(template, isA<RelationshipTemplateDTO>());
      expect(template.expiresAt, expiresAt);
      expect(template.content.toJson(), content);
      expect(template.id, responseTemplate.data.id);
      expect(template.secretKey, responseTemplate.data.secretKey);
    });
  });

  group('RelationshipTemplatesFacade: loadPeerRelationshipTemplateByReference', () {
    test('returns a valid RelationshipTemplateDTO', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final templateResult = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByReference(
        reference: responseTemplate.data.truncatedReference,
      );
      final template = templateResult.value;

      expect(template, isA<RelationshipTemplateDTO>());
      expect(template.expiresAt, expiresAt);
      expect(template.content.toJson(), content);
      expect(template.truncatedReference, responseTemplate.data.truncatedReference);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplates', () {
    test('returns the correct amount of own relationship templates', () async {
      final expiresAt = generateExpiryString();
      final currentTemplates = await session.transportServices.relationshipTemplates.getRelationshipTemplates();

      await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: {'aKey': 'aValue'},
        maxNumberOfAllocations: 1,
      );

      final allTemplates = await session.transportServices.relationshipTemplates.getRelationshipTemplates();

      expect(allTemplates.value, isA<List<RelationshipTemplateDTO>>());
      expect(allTemplates.value.length, greaterThan(currentTemplates.value.length));
    });

    test('returns the correct amount of own relationship templates with all properties', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: 1,
      );

      await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: generateExpiryString(),
        content: content,
        maxNumberOfAllocations: 2,
      );

      final templatesWithQueryExpiresAt = await session.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'expiresAt': QueryValue.string(expiresAt)},
      );

      final templatesWithNoResponse = await session.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'expiresAt': QueryValue.string('2023')},
      );

      final templatesWithQueryMnoa = await session.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'maxNumberOfAllocations': QueryValue.string('1')},
      );

      expect(templatesWithQueryExpiresAt.value.length, 1);
      expect(templatesWithNoResponse.value.length, 0);
      expect(templatesWithQueryMnoa.value.where((e) => e.maxNumberOfAllocations != 1).length, 0);
      expect(templatesWithQueryExpiresAt.value, isA<List<RelationshipTemplateDTO>>());
      expect(templatesWithQueryMnoa.value, isA<List<RelationshipTemplateDTO>>());
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplate', () {
    test('returns a valid RelationshipTemplateDTO', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final template = await session.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: createdTemplate.value.id,
      );

      expect(template.value, isA<RelationshipTemplateDTO>());
      expect(template.value.expiresAt, expiresAt);
      expect(template.value.content.toJson(), content);
    });

    test('throws an exception on empty template id', () async {
      final result = await session.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: '',
      );

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception if template id do not match the pattern', () async {
      final result = await session.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: 'RTLX123456789',
      );

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing template id', () async {
      final result = await session.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: 'RLTXZKg9TestveduKiGs',
      );

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('RelationshipTemplatesFacade: createQrCodeForOwnTemplate', () {
    test('returns a valid CreateQrCodeResponse', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplateResult = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session.transportServices.relationshipTemplates.createQrCodeForOwnTemplate(
        templateId: createdTemplateResult.value.id,
      );

      expect(response.value, isA<CreateQrCodeResponse>());
    });
  });

  group('RelationshipTemplatesFacade: createTokenQrCodeForOwnTemplate', () {
    test('returns a valid CreateQrCodeResponse', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplateResult = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(
        templateId: createdTemplateResult.value.id,
      );

      expect(response.value, isA<CreateQrCodeResponse>());
    });

    test('returns a valid CreateQrCodeResponse with all properties', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplateResult = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(
        templateId: createdTemplateResult.value.id,
        expiresAt: expiresAt,
      );

      expect(response.value, isA<CreateQrCodeResponse>());
    });
  });

  group('RelationshipTemplatesFacade: createTokenForOwnTemplate', () {
    test('returns a valid TokenDTO', () async {
      final expiresAt = generateExpiryString();
      const content = {'aKey': 'aValue'};

      final createdTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final tokenResult = await session.transportServices.relationshipTemplates.createTokenForOwnTemplate(
        templateId: createdTemplate.value.id,
      );
      final token = tokenResult.value;

      expect(token.expiresAt, expiresAt);
      expect(token, isA<TokenDTO>());
    });

    test('returns a valid TokenDTO with all properties', () async {
      final expiresAt = generateExpiryString();
      final createdTemplateResult = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: {'a': 'b'},
      );

      final tokenResult = await session.transportServices.relationshipTemplates.createTokenForOwnTemplate(
        templateId: createdTemplateResult.value.id,
        expiresAt: expiresAt,
        ephemeral: true,
      );
      final token = tokenResult.value;

      expect(token, isA<TokenDTO>());
      expect(token.expiresAt, expiresAt);
      expect(token.expiresAt, createdTemplateResult.value.expiresAt);
      expect(token.isEphemeral, true);
    });
  });
}
