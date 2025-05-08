import 'dart:convert';
import 'dart:typed_data';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';

import 'mock_event_bus.dart';

const _expiresAtDuration = Duration(hours: 2);
String generateExpiryString() => DateTime.now().add(_expiresAtDuration).toRuntimeIsoString();

extension ToRuntimeIsoString on DateTime {
  String toRuntimeIsoString() {
    return copyWith(microsecond: 0).toUtc().toIso8601String();
  }
}

final ArbitraryMessageContent emptyMessageContent = ArbitraryMessageContent(const {});

final ArbitraryRelationshipCreationContent emptyRelationshipCreationContent = ArbitraryRelationshipCreationContent(const {});

final ArbitraryRelationshipTemplateContent emptyRelationshipTemplateContent = ArbitraryRelationshipTemplateContent(const {});

Future<RelationshipDTO> establishRelationship({required Session requestor, required Session templator}) async {
  final createTemplateResult = await templator.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
    expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
    content: emptyRelationshipTemplateContent,
  );

  final item = await requestor.transportServices.account.loadItemFromReference(reference: createTemplateResult.value.reference.truncated);

  final template = item.value.relationshipTemplateValue;

  final relationship = await requestor.transportServices.relationships.createRelationship(
    templateId: template.id,
    creationContent: emptyRelationshipCreationContent,
  );

  return relationship.value;
}

Future<RelationshipDTO> establishRelationshipAndSync({required Session requestor, required Session templator}) async {
  await establishRelationship(requestor: requestor, templator: templator);
  return await syncUntilHasRelationship(templator);
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

Future<MessageDTO> syncUntilHasMessageWithNotification(Session session, String notificationId) async {
  int retries = 0;

  do {
    final syncResult = await session.transportServices.account.syncEverything();
    if (syncResult.value.messages.isNotEmpty && syncResult.value.messages.first.toJson()['content']['id'] == notificationId) {
      return syncResult.value.messages.first;
    }

    retries++;
    await Future.delayed(Duration(seconds: 5 * retries));
  } while (retries < 10);

  throw Exception('Could not sync until having a message');
}

Future<List<MessageDTO>> syncUntilHasMessages(Session session, {required int expectedNumberOfMessages}) async {
  final messages = <MessageDTO>[];

  int retries = 0;

  do {
    final syncResult = await session.transportServices.account.syncEverything();
    messages.addAll(syncResult.value.messages);

    if (messages.length >= expectedNumberOfMessages) return messages;

    retries++;
    await Future.delayed(Duration(seconds: 5 * retries));
  } while (retries < 10);

  throw Exception('Could not sync until having $expectedNumberOfMessages messages');
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
    await session1.transportServices.relationships.acceptRelationship(relationshipId: relationship.id);
    await syncUntilHasRelationship(session2);
  }
  return (await session1.transportServices.relationships.getRelationships()).value.first;
}

Future<RelationshipDTO> ensureTerminatedRelationship(Session session1, Session session2) async {
  final session2Address = (await session2.transportServices.account.getIdentityInfo()).value.address;
  List<RelationshipDTO> relationships =
      (await session1.transportServices.relationships.getRelationships(query: {'peer': QueryValue.string(session2Address)})).value;

  if (relationships.isEmpty) {
    await establishRelationshipBetweenSessionsAndSync(session1, session2);
    relationships = (await session1.transportServices.relationships.getRelationships(query: {'peer': QueryValue.string(session2Address)})).value;
  }
  final relationship = relationships.first;
  if (relationships.first.status == RelationshipStatus.Pending) {
    await session1.transportServices.relationships.acceptRelationship(relationshipId: relationship.id);
    await session1.transportServices.relationships.terminateRelationship(relationshipId: relationship.id);
    await syncUntilHasRelationship(session2);
  }
  if (relationships.first.status == RelationshipStatus.Active) {
    await session1.transportServices.relationships.terminateRelationship(relationshipId: relationship.id);
    await syncUntilHasRelationship(session2);
  }
  return (await session1.transportServices.relationships.getRelationships()).value.first;
}

Future<RelationshipDTO> establishRelationshipBetweenSessionsAndSync(Session session1, Session session2) async {
  final createTemplateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
    expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
    content: emptyRelationshipTemplateContent,
  );
  final connectorLoadTemplateResult = await session2.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(
    reference: createTemplateResult.value.reference.truncated,
  );
  assert(connectorLoadTemplateResult.isSuccess);

  final createRelationshipResult = await session2.transportServices.relationships.createRelationship(
    templateId: connectorLoadTemplateResult.value.id,
    creationContent: emptyRelationshipCreationContent,
  );
  assert(createRelationshipResult.isSuccess);

  return await syncUntilHasRelationship(session1);
}

Future<LocalAttributeDTO> exchangeIdentityAttribute(Session sender, Session recipient, IdentityAttributeValue attributeValue) async {
  final createdAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(value: attributeValue);
  final createdAttribute = createdAttributeResult.value;

  final recipientAddress = (await recipient.transportServices.account.getIdentityInfo()).value.address;

  final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
    attributeId: createdAttribute.id,
    peer: recipientAddress,
  );
  final request = shareAttributeResult.value;

  await syncUntilHasMessage(recipient);

  await recipient.consumptionServices.incomingRequests.accept(
    params: DecideRequestParameters(requestId: request.id, items: [const AcceptRequestItemParameters()]),
  );

  await syncUntilHasMessage(sender);

  final localAttributes = await sender.consumptionServices.attributes.getAttributes(
    query: {'content.@type': QueryValue.string('IdentityAttribute'), 'shareInfo.requestReference': QueryValue.string(request.id)},
  );
  assert(localAttributes.value.isNotEmpty);
  assert(localAttributes.value.first.shareInfo?.requestReference == request.id);

  return localAttributes.value.first;
}

Future<LocalAttributeDTO> exchangeRelationshipAttribute(
  Session sender,
  Session recipient,
  RelationshipAttributeValue attributeValue, {
  bool? isTechnical,
  String? validTo,
}) async {
  final recipientAddress = (await recipient.transportServices.account.getIdentityInfo()).value.address;

  final requestResult = await sender.consumptionServices.attributes.createAndShareRelationshipAttribute(
    value: attributeValue,
    key: 'aKey',
    confidentiality: RelationshipAttributeConfidentiality.public,
    isTechnical: isTechnical,
    validTo: validTo,
    peer: recipientAddress,
  );
  final request = requestResult.value;

  await syncUntilHasMessage(recipient);

  await recipient.consumptionServices.incomingRequests.accept(
    params: DecideRequestParameters(requestId: request.id, items: [const AcceptRequestItemParameters()]),
  );

  await syncUntilHasMessage(sender);

  final localAttributes = await sender.consumptionServices.attributes.getAttributes(
    query: {'content.@type': QueryValue.string('RelationshipAttribute'), 'shareInfo.requestReference': QueryValue.string(request.id)},
  );
  assert(localAttributes.value.isNotEmpty);
  assert(localAttributes.value.first.shareInfo?.requestReference == request.id);

  return localAttributes.value.first;
}

Future<void> exchangeAndAcceptRequestByMessage(
  Session sender,
  Session recipient,
  String senderAddress,
  String recipientAddress,
  Request request,
  List<DecideRequestParametersItem> responseItems,
  MockEventBus eventBus,
) async {
  final createRequestResult = await sender.consumptionServices.outgoingRequests.create(content: request, peer: recipientAddress);
  assert(createRequestResult.isSuccess);

  await sender.transportServices.messages.sendMessage(
    recipients: [recipientAddress],
    content: MessageContentRequest(request: createRequestResult.value.content),
  );
  await syncUntilHasMessage(recipient);

  await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
    eventTargetAddress: recipientAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.ManualDecisionRequired,
  );

  final acceptedRequest = await recipient.consumptionServices.incomingRequests.accept(
    params: DecideRequestParameters(requestId: createRequestResult.value.id, items: responseItems),
  );
  assert(acceptedRequest.isSuccess);

  await eventBus.waitForEvent<MessageSentEvent>(eventTargetAddress: recipientAddress);

  await syncUntilHasMessage(sender);
  await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
    eventTargetAddress: senderAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
  );
}

Future<LocalAttributeDTO> acceptIncomingShareAttributeRequest(
  Session sender,
  Session recipient,
  String senderAddress,
  String recipientAddress,
  LocalRequestDTO request,
  MockEventBus eventBus,
) async {
  await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
    eventTargetAddress: senderAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.Open,
  );

  await syncUntilHasMessage(recipient);

  await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
    eventTargetAddress: recipientAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.ManualDecisionRequired,
  );

  final acceptRequestResult = await recipient.consumptionServices.incomingRequests.accept(
    params: DecideRequestParameters(requestId: request.id, items: [const AcceptRequestItemParameters()]),
  );

  assert(acceptRequestResult.isSuccess);

  await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
    eventTargetAddress: recipientAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
  );

  await syncUntilHasMessage(sender);

  final attributesResult = await recipient.consumptionServices.attributes.getAttributes();
  final attributes = attributesResult.value;

  final attributeResult = await recipient.consumptionServices.attributes.getAttribute(attributeId: attributes.first.id);

  return attributeResult.value;
}

Future<LocalAttributeDTO> executeFullCreateAndShareRelationshipAttributeFlow(
  Session sender,
  Session recipient,
  String senderAddress,
  String recipientAddress,
  RelationshipAttributeValue attributeValue,
  MockEventBus eventBus,
) async {
  final requestResult = await sender.consumptionServices.attributes.createAndShareRelationshipAttribute(
    value: attributeValue,
    key: 'aKey',
    confidentiality: RelationshipAttributeConfidentiality.public,
    peer: recipientAddress,
  );
  final request = requestResult.value;

  await syncUntilHasMessage(recipient);

  await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
    eventTargetAddress: recipientAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.ManualDecisionRequired,
  );

  await recipient.consumptionServices.incomingRequests.accept(
    params: DecideRequestParameters(requestId: request.id, items: [const AcceptRequestItemParameters()]),
  );

  final responseMessage = await syncUntilHasMessage(sender);
  final sharedAttributeId = responseMessage.content.toJson()['response']['items'][0]['attributeId'];

  await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
    eventTargetAddress: senderAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
  );

  final senderOwnSharedAttributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: sharedAttributeId);
  return senderOwnSharedAttributeResult.value;
}

Future<LocalAttributeDTO> executeFullRequestAndShareThirdPartyRelationshipAttributeFlow(
  Session sender,
  Session recipient,
  String senderAddress,
  String recipientAddress,
  String thirdPartyAddress,
  RequestItem requestItem,
  String sourceRelationshipAttributeId,
  MockEventBus eventBus,
) async {
  final localRequestDTOResult = await recipient.consumptionServices.outgoingRequests.create(
    content: Request(items: [requestItem]),
    peer: senderAddress,
  );
  assert(localRequestDTOResult.isSuccess);

  await recipient.transportServices.messages.sendMessage(
    recipients: [senderAddress],
    content: MessageContentRequest(request: localRequestDTOResult.value.content),
  );
  await syncUntilHasMessage(sender);

  await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
    eventTargetAddress: senderAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.ManualDecisionRequired,
  );

  final responseItems = [AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: sourceRelationshipAttributeId)];
  final acceptedRequest = await sender.consumptionServices.incomingRequests.accept(
    params: DecideRequestParameters(requestId: localRequestDTOResult.value.id, items: responseItems),
  );
  assert(acceptedRequest.isSuccess);

  await eventBus.waitForEvent<MessageSentEvent>(eventTargetAddress: senderAddress);

  final responseMessage = await syncUntilHasMessage(recipient);
  await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
    eventTargetAddress: recipientAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
  );

  final thirdPartyRelationshipAttributeId = responseMessage.content.toJson()['response']['items'][0]['attributeId'];

  await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
    eventTargetAddress: recipientAddress,
    predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
  );

  final senderOwnSharedAttributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: thirdPartyRelationshipAttributeId);
  return senderOwnSharedAttributeResult.value;
}

Future<void> waitForRecipientToReceiveNotification(
  Session sender,
  Session recipient,
  String senderAddress,
  String recipientAddress,
  String notificationId,
  String successorId,
  MockEventBus eventBus,
) async {
  await syncUntilHasMessageWithNotification(recipient, notificationId);

  await eventBus.waitForEvent<OwnSharedAttributeSucceededEvent>(eventTargetAddress: senderAddress, predicate: (e) => e.successor.id == successorId);

  await eventBus.waitForEvent<PeerSharedAttributeSucceededEvent>(
    eventTargetAddress: recipientAddress,
    predicate: (e) => e.successor.id == successorId,
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

Future<RelationshipDTO> getRelationship(Session session) async {
  final response = await session.transportServices.relationships.getRelationships();
  assert(response.isSuccess);
  assert(response.value.length == 1);

  return response.value.first;
}

class FakeUIBridge implements UIBridge {
  final requestAccountSelectionCalls = List<(List<LocalAccountDTO>, String?, String?)>.empty(growable: true);
  bool get requestAccountSelectionCalled => requestAccountSelectionCalls.isNotEmpty;

  final showDeviceOnboardingCalls = List<DeviceSharedSecret>.empty(growable: true);
  bool get showDeviceOnboardingCalled => showDeviceOnboardingCalls.isNotEmpty;

  final showErrorCalls = List<(UIBridgeError, LocalAccountDTO?)>.empty(growable: true);
  bool get showErrorCalled => showErrorCalls.isNotEmpty;

  final showFileCalls = List<(LocalAccountDTO, FileDVO)>.empty(growable: true);
  bool get showFileCalled => showFileCalls.isNotEmpty;

  final showMessageCalls = List<(LocalAccountDTO, IdentityDVO, MessageDVO)>.empty(growable: true);
  bool get showMessageCalled => showMessageCalls.isNotEmpty;

  final showRelationshipCalls = List<(LocalAccountDTO, IdentityDVO)>.empty(growable: true);
  bool get showRelationshipCalled => showRelationshipCalls.isNotEmpty;

  final showRequestCalls = List<(LocalAccountDTO, LocalRequestDVO)>.empty(growable: true);
  bool get showRequestCalled => showRequestCalls.isNotEmpty;

  final enterPasswordCalls = List<(UIBridgePasswordType, int?, int?, int?)>.empty(growable: true);
  bool get enterPasswordCalled => enterPasswordCalls.isNotEmpty;

  void reset() {
    requestAccountSelectionCalls.clear();
    showDeviceOnboardingCalls.clear();
    showErrorCalls.clear();
    showFileCalls.clear();
    showMessageCalls.clear();
    showRelationshipCalls.clear();
    showRequestCalls.clear();
  }

  @override
  Future<LocalAccountDTO?> requestAccountSelection(List<LocalAccountDTO> possibleAccounts, [String? title, String? description]) async {
    requestAccountSelectionCalls.add((possibleAccounts, title, description));

    return null;
  }

  @override
  Future<void> showDeviceOnboarding(DeviceSharedSecret deviceOnboardingInfo) async => showDeviceOnboardingCalls.add(deviceOnboardingInfo);

  @override
  Future<void> showError(UIBridgeError error, [LocalAccountDTO? account]) async => showErrorCalls.add((error, account));

  @override
  Future<void> showFile(LocalAccountDTO account, FileDVO file) async => showFileCalls.add((account, file));

  @override
  Future<void> showMessage(LocalAccountDTO account, IdentityDVO relationship, MessageDVO message) async =>
      showMessageCalls.add((account, relationship, message));

  @override
  Future<void> showRelationship(LocalAccountDTO account, IdentityDVO relationship) async => showRelationshipCalls.add((account, relationship));

  @override
  Future<void> showRequest(LocalAccountDTO account, LocalRequestDVO request) async => showRequestCalls.add((account, request));

  @override
  Future<String> enterPassword({required UIBridgePasswordType passwordType, int? pinLength, int? attempt, int? passwordLocationIndicator}) async {
    enterPasswordCalls.add((passwordType, pinLength, attempt, passwordLocationIndicator));

    return switch (passwordType) {
      UIBridgePasswordType.pin => '0' * pinLength!,
      UIBridgePasswordType.password => 'password',
    };
  }
}
