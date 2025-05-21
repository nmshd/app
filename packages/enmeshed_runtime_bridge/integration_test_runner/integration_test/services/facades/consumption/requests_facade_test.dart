import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../mock_event_bus.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  final eventBus = runtime.eventBus as MockEventBus;

  group('[Requests Facade]', () {
    group('Requests Complete flow with Messages:', () {
      group('Accept Request', () {
        late LocalAccountDTO account1;
        late Session sender;
        late LocalAccountDTO account2;
        late Session recipient;

        late LocalRequestDTO sLocalRequest;
        late LocalRequestDTO rLocalRequest;

        setUpAll(() async {
          account1 = await runtime.accountServices.createAccount(name: 'requestFacade Test 1');
          sender = runtime.getSession(account1.id);
          account2 = await runtime.accountServices.createAccount(name: 'requestFacade Test 2');
          recipient = runtime.getSession(account2.id);

          await ensureActiveRelationship(sender, recipient);
        });

        test('sender: create an outgoing Request in status Draft', () async {
          final result = await sender.consumptionServices.outgoingRequests.create(
            content: const Request(
              items: [ReadAttributeRequestItem(mustBeAccepted: false, query: IdentityAttributeQuery(valueType: 'City'))],
            ),
            peer: (await recipient.transportServices.account.getIdentityInfo()).value.address,
          );

          expect(result, isSuccessful<LocalRequestDTO>());

          sLocalRequest = (await sender.consumptionServices.outgoingRequests.getRequest(requestId: result.value.id)).value;

          final triggeredEvent = await eventBus.waitForEvent<OutgoingRequestCreatedEvent>(eventTargetAddress: account1.address!);

          expect(triggeredEvent.data.id, sLocalRequest.id);

          expect(sLocalRequest.status, LocalRequestStatus.Draft);
          expect(sLocalRequest.content.items.length, 1);
          expect(sLocalRequest.content.items.first, isA<ReadAttributeRequestItem>());
          expect((sLocalRequest.content.items.first as ReadAttributeRequestItem).mustBeAccepted, false);
        });

        test('sender: send the outgoing Request via Message', () async {
          final result = await sender.transportServices.messages.sendMessage(
            recipients: [(await recipient.transportServices.account.getIdentityInfo()).value.address],
            content: MessageContentRequest(request: sLocalRequest.content),
          );

          expect(result, isSuccessful<MessageDTO>());

          await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
            eventTargetAddress: account1.address!,
            predicate: (e) => e.newStatus == LocalRequestStatus.Open && e.request.id == sLocalRequest.id,
          );
        });

        test('recipient: sync the Message with the Request', () async {
          await syncUntilHasMessage(recipient);

          final triggeredEvent = await eventBus.waitForEvent<IncomingRequestReceivedEvent>(eventTargetAddress: account2.address!);

          expect(triggeredEvent.data.id, sLocalRequest.id);

          final requests = await recipient.consumptionServices.incomingRequests.getRequests();

          expect(requests.value.length, 1);

          rLocalRequest = requests.value.first;
        });

        test('recipient: call canAccept for incoming Request', () async {
          final result = await recipient.consumptionServices.incomingRequests.canAccept(
            params: DecideRequestParameters(
              requestId: rLocalRequest.id,
              items: [
                AcceptReadAttributeRequestItemParametersWithNewAttribute(
                  newAttribute: IdentityAttribute(
                    owner: account2.address!,
                    value: const CityAttributeValue(value: 'aCity'),
                  ),
                ),
              ],
            ),
          );

          expect(result, isSuccessful<RequestValidationResultDTO>());
          expect(result.value.items.length, 1);
          expect(result.value.items.first.isSuccess, true);
          expect(result.value.items.first.items.length, 0);
        });

        test('recipient: accept incoming Request', () async {
          final result = await recipient.consumptionServices.incomingRequests.accept(
            params: DecideRequestParameters(
              requestId: rLocalRequest.id,
              items: [
                AcceptReadAttributeRequestItemParametersWithNewAttribute(
                  newAttribute: IdentityAttribute(
                    owner: account2.address!,
                    value: const CityAttributeValue(value: 'aCity'),
                  ),
                ),
              ],
            ),
          );

          final triggeredIncomingEvent = await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(eventTargetAddress: account2.address!);

          expect(result, isSuccessful<LocalRequestDTO>());

          rLocalRequest = result.value;

          expect(result.value.status, LocalRequestStatus.Decided);
          expect(result.value.response, isA<LocalResponseDTO>());
          expect(result.value.response!.content, isA<Response>());

          expect(triggeredIncomingEvent.oldStatus, LocalRequestStatus.ManualDecisionRequired);
          expect(triggeredIncomingEvent.newStatus, LocalRequestStatus.Decided);
        });

        test('sender: sync Message with ResponseWrapper', () async {
          final result = await syncUntilHasMessage(sender);

          expect(result.content.toJson()['@type'], 'ResponseWrapper');
          expect((result.content as ResponseWrapper).response.toJson()['@type'], 'Response');
          expect((result.content as ResponseWrapper).response.result, ResponseResult.Accepted);
        });
      });

      group('Reject Request', () {
        late LocalAccountDTO account1;
        late Session sender;
        late LocalAccountDTO account2;
        late Session recipient;

        late LocalRequestDTO sLocalRequest;
        late LocalRequestDTO rLocalRequest;

        setUpAll(() async {
          account1 = await runtime.accountServices.createAccount(name: 'requestFacade Test 1');
          sender = runtime.getSession(account1.id);
          account2 = await runtime.accountServices.createAccount(name: 'requestFacade Test 2');
          recipient = runtime.getSession(account2.id);

          await ensureActiveRelationship(sender, recipient);
        });

        test('sender: create an outgoing Request in status Draft', () async {
          final result = await sender.consumptionServices.outgoingRequests.create(
            content: const Request(
              items: [ReadAttributeRequestItem(mustBeAccepted: false, query: IdentityAttributeQuery(valueType: 'City'))],
            ),
            peer: (await recipient.transportServices.account.getIdentityInfo()).value.address,
          );

          expect(result, isSuccessful<LocalRequestDTO>());

          sLocalRequest = (await sender.consumptionServices.outgoingRequests.getRequest(requestId: result.value.id)).value;

          final triggeredEvent = await eventBus.waitForEvent<OutgoingRequestCreatedEvent>(eventTargetAddress: account1.address!);

          expect(triggeredEvent.data.id, sLocalRequest.id);

          expect(sLocalRequest.status, LocalRequestStatus.Draft);
          expect(sLocalRequest.content.items.length, 1);
          expect(sLocalRequest.content.items.first, isA<ReadAttributeRequestItem>());
          expect((sLocalRequest.content.items.first as ReadAttributeRequestItem).mustBeAccepted, false);
        });

        test('sender: send the outgoing Request via Message', () async {
          final result = await sender.transportServices.messages.sendMessage(
            recipients: [(await recipient.transportServices.account.getIdentityInfo()).value.address],
            content: MessageContentRequest(request: sLocalRequest.content),
          );

          expect(result, isSuccessful<MessageDTO>());

          await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
            eventTargetAddress: account1.address!,
            predicate: (e) => e.newStatus == LocalRequestStatus.Open && e.request.id == sLocalRequest.id,
          );
        });

        test('recipient: sync the Message with the Request', () async {
          await syncUntilHasMessage(recipient);

          final triggeredEvent = await eventBus.waitForEvent<IncomingRequestReceivedEvent>(eventTargetAddress: account2.address!);

          expect(triggeredEvent.data.id, sLocalRequest.id);

          final requests = await recipient.consumptionServices.incomingRequests.getRequests();

          expect(requests.value.length, 1);

          rLocalRequest = requests.value.first;
        });

        test('recipient: call canReject for incoming Request', () async {
          final result = await recipient.consumptionServices.incomingRequests.canReject(
            params: DecideRequestParameters(requestId: rLocalRequest.id, items: [const RejectRequestItemParameters()]),
          );

          expect(result, isSuccessful<RequestValidationResultDTO>());
          expect(result.value.items.length, 1);
          expect(result.value.items.first.isSuccess, true);
          expect(result.value.items.first.items.length, 0);
        });

        test('recipient: reject incoming Request', () async {
          final result = await recipient.consumptionServices.incomingRequests.reject(
            params: DecideRequestParameters(requestId: rLocalRequest.id, items: [const RejectRequestItemParameters()]),
          );

          final triggeredIncomingEvent = await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(eventTargetAddress: account2.address!);

          expect(result, isSuccessful<LocalRequestDTO>());

          rLocalRequest = result.value;

          expect(result.value.status, LocalRequestStatus.Decided);
          expect(result.value.response, isA<LocalResponseDTO>());
          expect(result.value.response!.content, isA<Response>());

          expect(triggeredIncomingEvent.oldStatus, LocalRequestStatus.ManualDecisionRequired);
          expect(triggeredIncomingEvent.newStatus, LocalRequestStatus.Decided);
        });

        test('sender: sync Message with ResponseWrapper', () async {
          final result = await syncUntilHasMessage(sender);

          expect(result.content.toJson()['@type'], 'ResponseWrapper');
          expect((result.content as ResponseWrapper).response.toJson()['@type'], 'Response');
          expect((result.content as ResponseWrapper).response.result, ResponseResult.Rejected);
        });
      });
    });

    group('Requests Complete flow with Relationship Template:', () {
      group('Accept Request', () {
        late LocalAccountDTO account1;
        late Session sender;
        late LocalAccountDTO account2;
        late Session recipient;

        late RelationshipTemplateDTO sRelationshipTemplate;
        late LocalRequestDTO rLocalRequest;

        setUpAll(() async {
          account1 = await runtime.accountServices.createAccount(name: 'requestFacade Test 1');
          sender = runtime.getSession(account1.id);
          account2 = await runtime.accountServices.createAccount(name: 'requestFacade Test 2');
          recipient = runtime.getSession(account2.id);
        });

        test('sender: create a Relationship Template with the Request', () async {
          final result = await sender.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
            expiresAt: generateExpiryString(),
            content: const RelationshipTemplateContent(
              onNewRelationship: Request(
                items: [ReadAttributeRequestItem(mustBeAccepted: false, query: IdentityAttributeQuery(valueType: 'City'))],
              ),
            ),
          );

          expect(result, isSuccessful<RelationshipTemplateDTO>());

          sRelationshipTemplate = result.value;
        });

        test('recipient: load the Relationship Template with the Request', () async {
          final result = await recipient.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(
            reference: sRelationshipTemplate.reference.truncated,
          );

          expect(result, isSuccessful<RelationshipTemplateDTO>());

          final triggeredEvent = await eventBus.waitForEvent<IncomingRequestReceivedEvent>(eventTargetAddress: account2.address!);

          final rLocalRequests = await recipient.consumptionServices.incomingRequests.getRequests();

          expect(rLocalRequests, isSuccessful<List<LocalRequestDTO>>());
          expect(rLocalRequests.value.length, 1);

          rLocalRequest = (await recipient.consumptionServices.incomingRequests.getRequest(requestId: rLocalRequests.value.first.id)).value;

          expect(rLocalRequest.status, LocalRequestStatus.ManualDecisionRequired);
          expect(triggeredEvent.data.id, rLocalRequest.id);
        });

        test('recipient: call canAccept for incoming Request', () async {
          final result = await recipient.consumptionServices.incomingRequests.canAccept(
            params: DecideRequestParameters(
              requestId: rLocalRequest.id,
              items: [
                AcceptReadAttributeRequestItemParametersWithNewAttribute(
                  newAttribute: IdentityAttribute(
                    owner: account2.address!,
                    value: const CityAttributeValue(value: 'aCity'),
                  ),
                ),
              ],
            ),
          );

          expect(result, isSuccessful<RequestValidationResultDTO>());
          expect(result.value.items.length, 1);
          expect(result.value.items.first.isSuccess, true);
          expect(result.value.items.first.items.length, 0);
        });

        test('recipient: accept incoming Request', () async {
          final result = await recipient.consumptionServices.incomingRequests.accept(
            params: DecideRequestParameters(
              requestId: rLocalRequest.id,
              items: [
                AcceptReadAttributeRequestItemParametersWithNewAttribute(
                  newAttribute: IdentityAttribute(
                    owner: account2.address!,
                    value: const CityAttributeValue(value: 'aCity'),
                  ),
                ),
              ],
            ),
          );

          final triggeredEvent = await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(eventTargetAddress: account2.address!);

          expect(result, isSuccessful<LocalRequestDTO>());

          rLocalRequest = result.value;

          expect(result.value.status, LocalRequestStatus.Decided);
          expect(result.value.response, isA<LocalResponseDTO>());
          expect(result.value.response!.content.result, ResponseResult.Accepted);

          expect(triggeredEvent.oldStatus, LocalRequestStatus.ManualDecisionRequired);
          expect(triggeredEvent.newStatus, LocalRequestStatus.Decided);
        });

        test('sender: sync Relationship', () async {
          final result = await syncUntilHasRelationship(sender);

          expect((result.template.content as RelationshipTemplateContent).onNewRelationship.items.length, 1);
          expect((result.template.content as RelationshipTemplateContent).onNewRelationship.items.first, rLocalRequest.content.items.first);
        });
      });

      group('Reject Request', () {
        late LocalAccountDTO account1;
        late Session sender;
        late LocalAccountDTO account2;
        late Session recipient;

        late RelationshipTemplateDTO sRelationshipTemplate;
        late LocalRequestDTO rLocalRequest;

        setUpAll(() async {
          account1 = await runtime.accountServices.createAccount(name: 'requestFacade Test 1');
          sender = runtime.getSession(account1.id);
          account2 = await runtime.accountServices.createAccount(name: 'requestFacade Test 2');
          recipient = runtime.getSession(account2.id);
        });

        test('sender: create a Relationship Template with the Request', () async {
          final result = await sender.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
            expiresAt: generateExpiryString(),
            content: const RelationshipTemplateContent(
              onNewRelationship: Request(
                items: [ReadAttributeRequestItem(mustBeAccepted: false, query: IdentityAttributeQuery(valueType: 'City'))],
              ),
            ),
          );

          expect(result, isSuccessful<RelationshipTemplateDTO>());

          sRelationshipTemplate = result.value;
        });

        test('recipient: load the Relationship Template with the Request', () async {
          final result = await recipient.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(
            reference: sRelationshipTemplate.reference.truncated,
          );

          expect(result, isSuccessful<RelationshipTemplateDTO>());

          final triggeredEvent = await eventBus.waitForEvent<IncomingRequestReceivedEvent>(eventTargetAddress: account2.address!);

          final rLocalRequests = await recipient.consumptionServices.incomingRequests.getRequests();

          expect(rLocalRequests, isSuccessful<List<LocalRequestDTO>>());
          expect(rLocalRequests.value.length, 1);

          rLocalRequest = (await recipient.consumptionServices.incomingRequests.getRequest(requestId: rLocalRequests.value.first.id)).value;

          expect(rLocalRequest.status, LocalRequestStatus.ManualDecisionRequired);
          expect(triggeredEvent.data.id, rLocalRequest.id);
        });

        test('recipient: call canReject for incoming Request', () async {
          final result = await recipient.consumptionServices.incomingRequests.canReject(
            params: DecideRequestParameters(requestId: rLocalRequest.id, items: [const RejectRequestItemParameters()]),
          );

          expect(result, isSuccessful<RequestValidationResultDTO>());
          expect(result.value.items.length, 1);
          expect(result.value.items.first.isSuccess, true);
          expect(result.value.items.first.items.length, 0);
        });

        test('recipient: reject incoming Request', () async {
          final result = await recipient.consumptionServices.incomingRequests.reject(
            params: DecideRequestParameters(requestId: rLocalRequest.id, items: [const RejectRequestItemParameters()]),
          );

          final triggeredEvent = await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(eventTargetAddress: account2.address!);

          expect(result, isSuccessful<LocalRequestDTO>());

          rLocalRequest = result.value;

          expect(result.value.status, LocalRequestStatus.Decided);
          expect(result.value.response, isA<LocalResponseDTO>());
          expect(result.value.response!.content.result, ResponseResult.Rejected);

          expect(triggeredEvent.oldStatus, LocalRequestStatus.ManualDecisionRequired);
          expect(triggeredEvent.newStatus, LocalRequestStatus.Decided);
        });
      });
    });

    group('other facade methods', () {
      late LocalAccountDTO account1;
      late Session sender;
      late LocalAccountDTO account2;
      late Session recipient;

      setUpAll(() async {
        account1 = await runtime.accountServices.createAccount(name: 'requestFacade Test 3');
        sender = runtime.getSession(account1.id);
        account2 = await runtime.accountServices.createAccount(name: 'requestFacade Test 4');
        recipient = runtime.getSession(account2.id);

        await ensureActiveRelationship(sender, recipient);
      });

      test('delete incoming request', () async {
        final result = await sender.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
          expiresAt: generateExpiryString(),
          content: const RelationshipTemplateContent(
            onNewRelationship: Request(
              items: [ReadAttributeRequestItem(mustBeAccepted: false, query: IdentityAttributeQuery(valueType: 'City'))],
            ),
            onExistingRelationship: Request(
              items: [ReadAttributeRequestItem(mustBeAccepted: false, query: IdentityAttributeQuery(valueType: 'City'))],
            ),
          ),
        );

        expect(result, isSuccessful<RelationshipTemplateDTO>());

        final sRelationshipTemplate = result.value;

        final loadTemplateResult = await recipient.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(
          reference: sRelationshipTemplate.reference.truncated,
        );

        expect(loadTemplateResult, isSuccessful<RelationshipTemplateDTO>());

        final triggeredEvent = await eventBus.waitForEvent<IncomingRequestReceivedEvent>(eventTargetAddress: account2.address!);

        final deleteResult = await recipient.consumptionServices.incomingRequests.delete(requestId: triggeredEvent.data.id);
        expect(deleteResult, isFailingVoidResult('error.consumption.requests.canOnlyDeleteIncomingRequestThatIsExpired'));
      });
    });
  });
}
