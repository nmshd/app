import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';

extension ToRuntimeIsoString on DateTime {
  String toRuntimeIsoString() {
    return copyWith(microsecond: 0).toUtc().toIso8601String();
  }
}

Future<ConnectorResponse<RelationshipTemplateDTO>> createConnectorTemplate(
  ConnectorClient connectorClient,
  String expiresAt, [
  Map<String, dynamic> content = const {},
]) async {
  final template = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
    expiresAt: expiresAt,
    content: content,
  );

  return template;
}

Future<RelationshipTemplateDTO> createSessionTemplate(
  Session session,
  String expiresAt, [
  Map<String, dynamic> content = const {},
]) async {
  final template = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
    expiresAt: expiresAt,
    content: content,
  );

  return template;
}

Future<LoadItemFromTruncatedReferenceResponse> loadItem(Session session, String truncatedReference) async {
  final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
    reference: truncatedReference,
  );

  return item;
}

Future<RelationshipDTO> createRelationship(
  Session session,
  String templateId, [
  Map<String, dynamic> content = const {},
]) async {
  final relationship = await session.transportServices.relationships.createRelationship(
    templateId: templateId,
    content: content,
  );

  return relationship;
}
