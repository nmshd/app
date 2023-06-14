import 'dart:convert';
import 'dart:typed_data';

import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';

import 'mock_event_bus.dart';

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

  final item = await session.transportServices.account.loadItemFromTruncatedReference(
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
    final syncResult = await session.transportServices.account.syncEverything();
    if (syncResult.value.relationships.isNotEmpty) return syncResult.value.relationships.first;

    retries++;
    await Future.delayed(Duration(seconds: 5 * retries));
  } while (retries < 10);

  throw Exception('Could not sync until having a relationship');
}

Future<MessageDTO> syncUntilHasMessage(Session session) async {
  int retries = 0;

  do {
    final syncResult = await session.transportServices.account.syncEverything();
    if (syncResult.value.messages.isNotEmpty) return syncResult.value.messages.first;

    retries++;
    await Future.delayed(Duration(seconds: 5 * retries));
  } while (retries < 10);

  throw Exception('Could not sync until having a message');
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

Future<RelationshipDTO> ensureActiveRelationship(Session session1, Session session2) async {
  final session2Address = (await session2.transportServices.account.getIdentityInfo()).value.address;
  List<RelationshipDTO> relationships =
      (await session1.transportServices.relationships.getRelationships(query: {'peer': QueryValue.string(session2Address)})).value;

  if (relationships.isEmpty) {
    await establishRelationshipBetweenSessionsAndSync(session1, session2);
    relationships = (await session1.transportServices.relationships.getRelationships(query: {'peer': QueryValue.string(session2Address)})).value;
  }
  if (relationships.first.status == RelationshipStatus.Pending) {
    final relationship = relationships.first;
    await session1.transportServices.relationships.acceptRelationshipChange(
      relationshipId: relationship.id,
      changeId: relationship.changes.first.id,
      content: {},
    );
    await syncUntilHasRelationship(session2);
  }
  return (await session1.transportServices.relationships.getRelationships()).value.first;
}

Future<RelationshipDTO> establishRelationshipBetweenSessionsAndSync(Session session1, Session session2) async {
  final createTemplateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
    expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
    content: {},
  );
  final connectorLoadTemplateResult = await session2.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByReference(
    reference: createTemplateResult.value.truncatedReference,
  );
  assert(connectorLoadTemplateResult.isSuccess);

  final createRelationshipResult = await session2.transportServices.relationships.createRelationship(
    templateId: connectorLoadTemplateResult.value.id,
    content: {'a': 'b'},
  );
  assert(createRelationshipResult.isSuccess);

  return await syncUntilHasRelationship(session1);
}

Future<void> shareAndAcceptPeerAttribute(
  Session sender,
  Session recipient,
  String recipientAddress,
  AbstractAttribute attribute,
) async {
  final createdAttributeResult = await sender.consumptionServices.attributes.createAttribute(content: attribute.toJson());
  final createdAttribute = createdAttributeResult.value;

  final shareAttributeResult = await sender.consumptionServices.attributes.shareAttribute(
    attributeId: createdAttribute.id,
    peer: recipientAddress,
  );
  final sharedAttribute = shareAttributeResult.value;

  await syncUntilHasMessage(recipient);

  await recipient.consumptionServices.incomingRequests.accept(
    params: DecideRequestParameters(requestId: sharedAttribute.id, items: [
      AcceptReadAttributeRequestItemParametersWithNewAttribute(
        newAttribute: attribute,
      ),
    ]),
  );

  await syncUntilHasMessage(sender);
}

Future<LocalAttributeDTO> establishSharedAttributeCopy(Session sender, String senderAddress, String peer, AbstractAttribute attribute) async {
  final createdAttributeResult = await sender.consumptionServices.attributes.createAttribute(content: attribute.toJson());
  final createdAttribute = createdAttributeResult.value;

  final sharedAttributeResult = await sender.consumptionServices.attributes.createSharedAttributeCopy(
    attributeId: createdAttribute.id,
    peer: peer,
    requestReference: 'REQIDXXXXXXXXXXXXXXX',
  );
  final sharedAttribute = sharedAttributeResult.value;

  return sharedAttribute;
}

Future<void> exchangeAndAcceptRequestByMessage(
  Session sender,
  Session recipient,
  String senderAddress,
  String recipientAddress,
  Request request,
  MockEventBus eventBus,
) async {
  final createRequestResult = await sender.consumptionServices.outgoingRequests.create(content: request, peer: recipientAddress);
  assert(createRequestResult.isSuccess);

  await sender.transportServices.messages.sendMessage(recipients: [recipientAddress], content: createRequestResult.value.content.toJson());
  await syncUntilHasMessage(recipient);

  await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
    eventTargetAddress: recipientAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.ManualDecisionRequired,
  );

  final acceptedRequest = await recipient.consumptionServices.incomingRequests.accept(
    params: DecideRequestParameters(requestId: createRequestResult.value.id, items: [
      AcceptReadAttributeRequestItemParametersWithNewAttribute(
        newAttribute: RelationshipAttribute(
          owner: recipientAddress,
          value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aProprietaryStringValue'),
          key: 'website',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      ),
    ]),
  );
  assert(acceptedRequest.isSuccess);

  await eventBus.waitForEvent<MessageSentEvent>(eventTargetAddress: recipientAddress);

  await syncUntilHasMessage(sender);
  await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
    eventTargetAddress: senderAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
  );
}

Future<FileDTO> uploadFile(Session session) async {
  final response = await session.transportServices.files.uploadOwnFile(
    content: Uint8List.fromList(utf8.encode('a String')).toList(),
    filename: 'facades/test.txt',
    mimetype: 'plain',
    expiresAt: generateExpiryString(),
    title: 'aTitle',
  );

  return response.value;
}
