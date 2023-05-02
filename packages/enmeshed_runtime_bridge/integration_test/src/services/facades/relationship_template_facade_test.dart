import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils.dart';

void run(EnmeshedRuntime runtime, ConnectorClient connector) {

  group('RelationshipTemplatesFacade: createOwnRelationshipTemplate', () {
    test('via the bridge with the runtime correctly', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final template = await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      expect(expiresAt, template.expiresAt);
      expect(content, template.content.toJson());
      expect(RelationshipTemplateDTO, template.runtimeType);
    });

    test('via the bridge with the runtime correctly with all properties', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();
      const maxNumberOfAllocations = 1;

      final template = await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
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
    test('via the bridge with the runtime correctly', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final responseTemplate = await connector.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final template = await runtime.currentSession.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByIdAndKey(
        relationshipTemplateId: responseTemplate.data.id,
        secretKey: responseTemplate.data.secretKey,
      );

      expect(responseTemplate.data.id, template.id);
      expect(responseTemplate.data.secretKey, template.secretKey);
      expect(RelationshipTemplateDTO, template.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: loadPeerRelationshipTemplateByReference', () {
    test('via the bridge with the runtime correctly', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final responseTemplate = await connector.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final template = await runtime.currentSession.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByReference(
        reference: responseTemplate.data.truncatedReference,
      );

      expect(responseTemplate.data.truncatedReference, template.truncatedReference);
      expect(RelationshipTemplateDTO, template.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplates', () {
    test('via the bridge with the runtime correctly', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: 1,
      );
      await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: 2,
      );

      final templates = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplates();

      expect(templates.length, greaterThan(1));
      expect(List<RelationshipTemplateDTO>, templates.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplate', () {
    test('via the bridge with the runtime correctly', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: 1,
      );

      await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: DateTime.now().add(const Duration(days: 100)).toRuntimeIsoString(),
        content: content,
        maxNumberOfAllocations: 2,
      );

      final templatesWithQueryExpiresAt = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'expiresAt': QueryValue.string(expiresAt)},
      );

      final templatesWithQueryMnoa = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'maxNumberOfAllocations': QueryValue.string('1')},
      );
      bool isAnyTemplateWithAnotherMnoa1 = false;
      for (final template in templatesWithQueryMnoa) {
        if (template.maxNumberOfAllocations != 1) {
          isAnyTemplateWithAnotherMnoa1 = true;
        }
      }

      expect(templatesWithQueryExpiresAt.length, 1);
      expect(false, isAnyTemplateWithAnotherMnoa1);
      expect(List<RelationshipTemplateDTO>, templatesWithQueryExpiresAt.runtimeType);
      expect(List<RelationshipTemplateDTO>, templatesWithQueryMnoa.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: createQrCodeForOwnTemplate', () {
    test('via the bridge with the runtime correctly', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await runtime.currentSession.transportServices.relationshipTemplates.createQrCodeForOwnTemplate(
        templateId: createdTemplate.id,
      );

      expect(CreateQrCodeResponse, response.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: createTokenQrCodeForOwnTemplate', () {
    test('via the bridge with the runtime correctly', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await runtime.currentSession.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(
        templateId: createdTemplate.id,
      );

      expect(CreateQrCodeResponse, response.runtimeType);
    });

    test('via the bridge with the runtime correctly with all properties', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final response = await runtime.currentSession.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(
        templateId: createdTemplate.id,
        expiresAt: expiresAt,
      );

      expect(CreateQrCodeResponse, response.runtimeType);
    });
  });

  group('RelationshipTemplatesFacade: createTokenForOwnTemplate', () {
    test('via the bridge with the runtime correctly', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final token = await runtime.currentSession.transportServices.relationshipTemplates.createTokenForOwnTemplate(
        templateId: createdTemplate.id,
      );

      expect(TokenDTO, token.runtimeType);
    });

    test('via the bridge with the runtime correctly with all properties', () async {
      final expiresAt = DateTime.now().add(const Duration(days: 365)).toRuntimeIsoString();
      final content = const RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      ).toJson();

      final createdTemplate = await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final token = await runtime.currentSession.transportServices.relationshipTemplates.createTokenForOwnTemplate(
        templateId: createdTemplate.id,
        expiresAt: expiresAt,
        ephemeral: true,
      );

      expect(createdTemplate.expiresAt, token.expiresAt);
      expect(true, token.isEphemeral);
      expect(TokenDTO, token.runtimeType);
    });
  });
}
