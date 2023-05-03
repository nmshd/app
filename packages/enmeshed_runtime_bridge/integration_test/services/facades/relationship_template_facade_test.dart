import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils.dart';

void run(EnmeshedRuntime runtime, ConnectorClient connectorClient) {
  late Session session;
  setUpAll(() async {
    final account = await runtime.accountServices.createAccount(name: 'relationshipTemplateFacade Test');
    session = runtime.getSession(account.id);
  });

  group('RelationshipTemplatesFacade: createOwnRelationshipTemplate', () {
    test('returns a valid RelationshipTemplateDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final template = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      expect(expiresAt, template.expiresAt);
      expect(content, template.content.toJson());
      expect(RelationshipTemplateDTO, template.runtimeType);
    });

    test('returns a valid RelationshipTemplateDTO with all properties', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();
      const maxNumberOfAllocations = 1;

      final template = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: maxNumberOfAllocations,
      );

      expect(expiresAt, template.expiresAt);
      expect(content, template.content.toJson());
      expect(maxNumberOfAllocations, template.maxNumberOfAllocations);
      expect(RelationshipTemplateDTO, template.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: loadPeerRelationshipTemplateByIdAndKey', () {
    test('returns a valid RelationshipTemplateDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final template = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByIdAndKey(
        relationshipTemplateId: responseTemplate.data.id,
        secretKey: responseTemplate.data.secretKey,
      );

      expect(expiresAt, template.expiresAt);
      expect(content, template.content.toJson());
      expect(responseTemplate.data.id, template.id);
      expect(responseTemplate.data.secretKey, template.secretKey);
      expect(RelationshipTemplateDTO, template.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: loadPeerRelationshipTemplateByReference', () {
    test('returns a valid RelationshipTemplateDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final template = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByReference(
        reference: responseTemplate.data.truncatedReference,
      );

      expect(expiresAt, template.expiresAt);
      expect(content, template.content.toJson());
      expect(responseTemplate.data.truncatedReference, template.truncatedReference);
      expect(RelationshipTemplateDTO, template.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplates', () {
    test('returns the correct amount of own relationship templates', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final currentTemplates = await session.transportServices.relationshipTemplates.getRelationshipTemplates();

      await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: 1,
      );

      final allTemplates = await session.transportServices.relationshipTemplates.getRelationshipTemplates();

      expect(allTemplates.length, greaterThan(currentTemplates.length));
      expect(List<RelationshipTemplateDTO>, allTemplates.runtimeType);
    });

    test('returns the correct amount of own relationship templates with all properties', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: 1,
      );

      await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: DateTime.now().add(const Duration(days: 100)).toRuntimeIsoString(),
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
      bool isAnyTemplateWithAnotherMnoa1 = false;
      for (final template in templatesWithQueryMnoa) {
        if (template.maxNumberOfAllocations != 1) {
          isAnyTemplateWithAnotherMnoa1 = true;
        }
      }

      expect(templatesWithQueryExpiresAt.length, 1);
      expect(templatesWithNoResponse.length, 0);
      expect(false, isAnyTemplateWithAnotherMnoa1);
      expect(List<RelationshipTemplateDTO>, templatesWithQueryExpiresAt.runtimeType);
      expect(List<RelationshipTemplateDTO>, templatesWithQueryMnoa.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplate', () {
    test('returns a valid RelationshipTemplateDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final template = await session.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: createdTemplate.id,
      );

      expect(expiresAt, template.expiresAt);
      expect(content, template.content.toJson());
      expect(RelationshipTemplateDTO, template.runtimeType);
    });

    test('throws an exception on empty template id', () async {
      const expectedErrorMessage = 'Exception: Error: {\n'
          '  "code": "error.runtime.validation.invalidPropertyValue",\n'
          '  "message": "id must match pattern RLT[A-Za-z0-9]{17}"\n'
          '}';

      try {
        await session.transportServices.relationshipTemplates.getRelationshipTemplate(
          relationshipTemplateId: '',
        );
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
        expect(e.toString(), expectedErrorMessage);
      }
    });

    test('throws an exception if template id do not match the pattern', () async {
      const expectedErrorMessage = 'Exception: Error: {\n'
          '  "code": "error.runtime.validation.invalidPropertyValue",\n'
          '  "message": "id must match pattern RLT[A-Za-z0-9]{17}"\n'
          '}';

      try {
        await session.transportServices.relationshipTemplates.getRelationshipTemplate(
          relationshipTemplateId: 'RTLX123456789',
        );
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
        expect(e.toString(), expectedErrorMessage);
      }
    });

    test('throws an exception on not existing template id', () async {
      const expectedErrorMessage = 'Exception: Error: {\n'
          '  "code": "error.runtime.recordNotFound",\n'
          '  "message": "em not found. Make sure the ID exists and the record is not expired."\n'
          '}';

      try {
        await session.transportServices.relationshipTemplates.getRelationshipTemplate(
          relationshipTemplateId: 'RLTXZKg9TestveduKiGs',
        );
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
        expect(e.toString(), expectedErrorMessage);
      }
    });
  });

  group('RelationshipTemplatesFacade: createQrCodeForOwnTemplate', () {
    test('returns a valid CreateQrCodeResponse', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session.transportServices.relationshipTemplates.createQrCodeForOwnTemplate(
        templateId: createdTemplate.id,
      );

      expect(CreateQrCodeResponse, response.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: createTokenQrCodeForOwnTemplate', () {
    test('returns a valid CreateQrCodeResponse', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(
        templateId: createdTemplate.id,
      );

      expect(CreateQrCodeResponse, response.runtimeType);
    });

    test('returns a valid CreateQrCodeResponse with all properties', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await session.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(
        templateId: createdTemplate.id,
        expiresAt: expiresAt,
      );

      expect(CreateQrCodeResponse, response.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: createTokenForOwnTemplate', () {
    test('returns a valid TokenDTO', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final token = await session.transportServices.relationshipTemplates.createTokenForOwnTemplate(
        templateId: createdTemplate.id,
      );

      expect(expiresAt, token.expiresAt);
      expect(TokenDTO, token.runtimeType);
    });

    test('returns a valid TokenDTO with all properties', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final token = await session.transportServices.relationshipTemplates.createTokenForOwnTemplate(
        templateId: createdTemplate.id,
        expiresAt: expiresAt,
        ephemeral: true,
      );

      expect(expiresAt, token.expiresAt);
      expect(createdTemplate.expiresAt, token.expiresAt);
      expect(true, token.isEphemeral);
      expect(TokenDTO, token.runtimeType);
    });
  });
}
