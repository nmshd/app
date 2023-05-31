import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';

const _expiresAtDuration = Duration(hours: 1);
String generateExpiryString() => DateTime.now().add(_expiresAtDuration).toRuntimeIsoString();

extension ToRuntimeIsoString on DateTime {
  String toRuntimeIsoString() {
    return copyWith(microsecond: 0).toUtc().toIso8601String();
  }
}

Future<RelationshipDTO> establishRelationship(Session session, ConnectorClient connectorClient) async {
  final responseTemplate = await connectorClient.relationshipTemplates.createOwnRelationshipTemplate(
    expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
    content: {},
  );

  final item = await session.transportServices.accounts.loadItemFromTruncatedReference(
    reference: responseTemplate.data.truncatedReference,
  );

  final template = item.value.relationshipTemplateValue;

  final relationship = await session.transportServices.relationships.createRelationship(
    templateId: template.id,
    content: {'a': 'b'},
  );

  return relationship.value;
}

Future<RelationshipDTO> syncUntilHasRelationship(Session session) async {
  int retries = 0;

  do {
    final syncResult = await session.transportServices.accounts.syncEverything();
    if (syncResult.value.relationships.isNotEmpty) return syncResult.value.relationships.first;

    retries++;
    await Future.delayed(Duration(seconds: 5 * retries));
  } while (retries < 10);

  throw Exception('Could not sync until having a relationship');
}

Future<RelationshipDTO> establishRelationshipAndSync(Session session, ConnectorClient connectorClient) async {
  final createTemplateResult = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
    expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
    content: {},
  );

  final connectorLoadTemplateResult = await connectorClient.relationshipTemplates.loadPeerRelationshipTemplateByTruncatedReference(
    createTemplateResult.value.truncatedReference,
  );
  assert(connectorLoadTemplateResult.hasData);

  final createRelationshipResult = await connectorClient.relationships.createRelationship(
    templateId: connectorLoadTemplateResult.data.id,
    content: {'a': 'b'},
  );
  assert(createRelationshipResult.hasData);

  return await syncUntilHasRelationship(session);
}
