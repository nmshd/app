import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';

extension ToRuntimeIsoString on DateTime {
  String toRuntimeIsoString() {
    return copyWith(microsecond: 0).toUtc().toIso8601String();
  }
}

Future<RelationshipDTO> establishRelationship(
  Session session,
  ConnectorClient connectorClient, [
  String? expiresAt,
]) async {
  expiresAt ??= DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

  final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
    expiresAt: expiresAt,
    content: {},
  );

  final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
    reference: responseTemplate.data.truncatedReference,
  );

  final template = item.relationshipTemplateValue;

  final relationship = await session.transportServices.relationships.createRelationship(
    templateId: template.id,
    content: {'a': 'b'},
  );

  return relationship;
}

Future<RelationshipDTO> syncUntilHasRelationship(Session session) async {
  int retries = 0;

  do {
    final syncResult = await session.transportServices.accounts.syncEverything();
    if (syncResult.relationships.isNotEmpty) return syncResult.relationships[0];

    retries++;
    await Future.delayed(Duration(seconds: 5 * retries));
  } while (retries < 10);

  throw Exception('Could not sync until having a relationship');
}

Future<RelationshipDTO> establishRelationshipAndSync(
  Session session,
  ConnectorClient connectorClient, [
  String? expiresAt,
]) async {
  expiresAt ??= DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString();

  final sessionTemplate = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(expiresAt: expiresAt, content: {});

  final connectorLoadTemplateResult = await connectorClient.relationshipTemplates.loadPeerRelationshipTemplateByTruncatedReference(
    sessionTemplate.truncatedReference,
  );
  assert(connectorLoadTemplateResult.hasData);

  final createRelationshipResult = await connectorClient.relationships.createRelationship(
    templateId: connectorLoadTemplateResult.data.id,
    content: {'a': 'b'},
  );
  assert(createRelationshipResult.hasData);

  return await syncUntilHasRelationship(session);
}
