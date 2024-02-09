import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../mock_event_bus.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account1;
  late Session sender;
  late LocalAccountDTO account2;
  late Session recipient;
  late MockEventBus eventBus;

  setUp(() async {
    account1 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 1');
    sender = runtime.getSession(account1.id);
    account2 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 2');
    recipient = runtime.getSession(account2.id);

    eventBus = runtime.eventBus as MockEventBus;

    await ensureActiveRelationship(sender, recipient);

    await sender.consumptionServices.attributes.createIdentityAttribute(value: const SurnameAttributeValue(value: 'aSurname'));
    await sender.consumptionServices.attributes.createIdentityAttribute(value: const GivenNameAttributeValue(value: 'aGivenName'));
  });

  group('AttributesFacade: createAttribute', () {
    test('should create an attribute', () async {
      final attributeResult = await sender.consumptionServices.attributes.createIdentityAttribute(value: const CityAttributeValue(value: 'aCity'));

      expect(attributeResult, isSuccessful<LocalAttributeDTO>());
      expect(attributeResult.value.content.toJson()['@type'], 'IdentityAttribute');
      expect(attributeResult.value.content.toJson()['value']['value'], 'aCity');
    });
  });

  group('AttributesFacade: getPeerSharedAttributes', () {
    test('should return a valid list of peer attributes', () async {
      final sharedAttribute = await exchangeIdentityAttribute(sender, recipient, const PhoneNumberAttributeValue(value: '012345678910'));

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(peer: account1.address!);

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());

      expect(recipientAttributesResult.value.length, 1);
      expect(recipientAttributesResult.value.first.id, sharedAttribute.id);
    });

    test('should return just non technical peer attributes when hideTechnical=true', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        isTechnical: true,
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(
        peer: account1.address!,
        hideTechnical: true,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 0);
    });

    test('should return also technical peer attributes when hideTechnical=false', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        isTechnical: true,
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(
        peer: account1.address!,
        hideTechnical: false,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 1);
    });

    test('should return just valid peer attributes when onlyValid=true', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(
        peer: account1.address!,
        onlyValid: true,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 0);
    });

    test('should return also expired peer attributes when onlyValid=false', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(
        peer: account1.address!,
        onlyValid: false,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 1);
    });

    test('should return a valid list of LocalAttributeDTOs with all properties', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        validTo: DateTime.now().toRuntimeIsoString(),
        isTechnical: true,
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(
        peer: account1.address!,
        onlyValid: true,
        hideTechnical: true,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 0);
    });
  });

  group('AttributesFacade: getOwnSharedAttributes', () {
    test('should return a valid list of shared to peer attributes', () async {
      final peer = account2.address!;

      await exchangeIdentityAttribute(sender, recipient, const NationalityAttributeValue(value: 'DE'));

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getOwnSharedAttributes(peer: peer);

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 1);

      final sharedNationality = sharedToPeerAttributeResult.value.first;

      expect(sharedNationality.content.toJson()['value'], {'@type': 'Nationality', 'value': 'DE'});
      expect(sharedNationality.shareInfo?.peer, peer);
    });

    test('should return just non technical shared to peer attributes when hideTechnical=true', () async {
      final peer = account2.address!;

      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        isTechnical: true,
      );

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getOwnSharedAttributes(
        peer: peer,
        hideTechnical: true,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 0);
    });

    test('should return also technical shared to peer attributes when hideTechnical=false', () async {
      final peer = account2.address!;

      final shared = await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        isTechnical: true,
      );

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getOwnSharedAttributes(
        peer: peer,
        hideTechnical: false,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 1);

      expect(sharedToPeerAttributeResult.value.first.content.toJson()['value'], shared.contentAsRelationshipAttribute.value.toJson());
      expect(sharedToPeerAttributeResult.value.first.shareInfo?.peer, peer);
    });

    test('should return just valid shared to peer attributes when onlyValid=true', () async {
      final peer = account2.address!;

      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getOwnSharedAttributes(
        peer: peer,
        onlyValid: true,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 0);
    });

    test('should return also expired shared to peer attributes when onlyValid=false', () async {
      final peer = account2.address!;

      final sharedproprietaryBoolean = await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getOwnSharedAttributes(
        peer: peer,
        onlyValid: false,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 1);

      expect(
        sharedToPeerAttributeResult.value.first.content.toJson()['value'],
        sharedproprietaryBoolean.contentAsRelationshipAttribute.value.toJson(),
      );
      expect(sharedToPeerAttributeResult.value.first.shareInfo?.peer, peer);
    });

    test('should return a valid list of non technical LocalAttributeDTOs with all properties', () async {
      final peer = account2.address!;

      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        validTo: DateTime.now().toRuntimeIsoString(),
        isTechnical: true,
      );

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getOwnSharedAttributes(
        peer: peer,
        onlyValid: true,
        hideTechnical: true,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 0);
    });
  });

  group('AttributesFacade: getAttribute', () {
    test('should return a valid LocalAttributeDTO', () async {
      final attributesResult = await sender.consumptionServices.attributes.getAttributes();
      final attributes = attributesResult.value;

      final attributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: attributes.first.id);

      expect(attributeResult, isSuccessful<LocalAttributeDTO>());
      expect(attributeResult.value.id, attributes.first.id);
      expect(attributeResult.value.content, attributes.first.content);
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await sender.consumptionServices.attributes.getAttribute(attributeId: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing file id', () async {
      final result = await sender.consumptionServices.attributes.getAttribute(attributeId: 'ATTz9TeStNBIzsgGVvv8');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('AttributesFacade: getAttributes', () {
    test('should return a valid list of LocalAttributeDTOs', () async {
      final attributesResult = await sender.consumptionServices.attributes.getAttributes();

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 2);
    });

    test('should return a valid list of queried LocalAttributeDTOs', () async {
      await exchangeRelationshipAttribute(sender, recipient, const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'));

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(
        query: {'content.value.@type': QueryValue.string('ProprietaryString')},
      );

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 1);
    });

    test('should return just non technical attributes when hideTechnical=true', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        isTechnical: true,
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(hideTechnical: true);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 2);
    });

    test('should return also technical attributes when hideTechnical=false', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        isTechnical: true,
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(hideTechnical: false);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 3);
    });

    test('should return just valid attributes when onlyValid=true', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(onlyValid: true);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 2);
    });

    test('should return also expired attributes when onlyValid=false', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(onlyValid: false);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 3);
    });

    test('should return a valid list of LocalAttributeDTOs with all properties', () async {
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        validTo: DateTime.now().toRuntimeIsoString(),
        isTechnical: true,
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(
        query: {'content.value.@type': QueryValue.string('Surname')},
        onlyValid: true,
        hideTechnical: true,
      );

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 1);
    });
  });

  group('AttributesFacade: executeIdentityAttributeQuery', () {
    test('should allow to execute an identityAttributeQuery', () async {
      final identityAttributeResult = await sender.consumptionServices.attributes.createIdentityAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
      );

      final receivedAttributesResult = await sender.consumptionServices.attributes.executeIdentityAttributeQuery(
        query: const IdentityAttributeQuery(valueType: 'PhoneNumber'),
      );

      expect(receivedAttributesResult, isSuccessful<List<LocalAttributeDTO>>());

      final attributeIds = receivedAttributesResult.value.map((v) => v.id);

      expect(receivedAttributesResult.value.length, 1);
      expect(attributeIds, contains(identityAttribute.id));
      expect(receivedAttributesResult.value.first, identityAttribute);
    });
  });

  group('AttributesFacade: executeRelationshipAttributeQuery', () {
    test('should allow to execute a relationshipAttributeQuery', () async {
      final relationshipAttribute = await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
      );

      final attributesResult = await sender.consumptionServices.attributes.executeRelationshipAttributeQuery(
        query: RelationshipAttributeQuery(
          key: 'aKey',
          owner: account1.address!,
          attributeCreationHints: const RelationshipAttributeCreationHints(
            title: 'aTitle',
            valueType: 'ProprietaryBoolean',
            confidentiality: 'public',
          ),
        ),
      );

      expect(attributesResult, isSuccessful<LocalAttributeDTO>());
      expect(attributesResult.value.id, relationshipAttribute.id);
    });
  });

  group('AttributesFacade: executeThirdPartyRelationshipAttributeQuery', () {
    test('should allow to execute a thirdPartyRelationshipAttributeQuery', () async {
      await exchangeAndAcceptRequestByMessage(
        sender,
        recipient,
        account1.address!,
        account2.address!,
        Request(items: [
          CreateAttributeRequestItem(
            mustBeAccepted: true,
            attribute: RelationshipAttribute(
              owner: account1.address!,
              value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aProprietaryStringValue'),
              key: 'website',
              confidentiality: RelationshipAttributeConfidentiality.public,
              validTo: generateExpiryString(),
            ),
          ),
        ]),
        eventBus,
      );

      final receivedAttributeResult = await recipient.consumptionServices.attributes.executeThirdPartyRelationshipAttributeQuery(
        query: ThirdPartyRelationshipAttributeQuery(key: 'website', owner: account1.address!, thirdParty: [account1.address!]),
      );

      expect(receivedAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(receivedAttributeResult.value.length, 1);
    });
  });

  group('AttributesFacade: shareIdentityAttribute', () {
    test('should allow to share an attribute', () async {
      final recipientAddress = account2.address!;

      final identityAttributeResult = await sender.consumptionServices.attributes.createIdentityAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareIdentityAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      expect(shareAttributeResult, isSuccessful<LocalRequestDTO>());

      await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
        eventTargetAddress: account1.address!,
        predicate: (e) => e.newStatus == LocalRequestStatus.Open,
      );

      await syncUntilHasMessage(recipient);

      final event = await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(eventTargetAddress: recipientAddress);

      final acceptRequestResult = await recipient.consumptionServices.incomingRequests.accept(
        params: DecideRequestParameters(
          requestId: shareAttributeResult.value.id,
          items: [AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: identityAttributeResult.value.content)],
        ),
      );

      expect(acceptRequestResult, isSuccessful<LocalRequestDTO>());

      await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
        eventTargetAddress: recipientAddress,
        predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(peer: account1.address!);
      final recipientAttributes = recipientAttributesResult.value;

      final attributeContents = recipientAttributes.map((v) => v.content);

      expect(event.request.id, shareAttributeResult.value.id);
      expect(attributeContents, contains(identityAttribute.content));
    });

    test('should allow to share an attribute with all properties', () async {
      final recipientAddress = account2.address!;

      final identityAttributeResult = await sender.consumptionServices.attributes.createIdentityAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareIdentityAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
        requestMetadata: (
          title: 'aRequestTitle',
          description: 'aRequestDescription',
          metadata: {'a': 'b'},
          expiresAt: null,
          // requestItemTitle: 'aRequestItemTitle',
          // requestItemDescription: 'aRequestItemDescription'
        ),
      );

      expect(shareAttributeResult, isSuccessful<LocalRequestDTO>());

      await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
        eventTargetAddress: account1.address!,
        predicate: (e) => e.newStatus == LocalRequestStatus.Open,
      );

      await syncUntilHasMessage(recipient);

      final event = await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(eventTargetAddress: recipientAddress);

      final acceptRequestResult = await recipient.consumptionServices.incomingRequests.accept(
        params: DecideRequestParameters(
          requestId: shareAttributeResult.value.id,
          items: [AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: identityAttributeResult.value.content)],
        ),
      );

      expect(acceptRequestResult, isSuccessful<LocalRequestDTO>());

      await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
        eventTargetAddress: recipientAddress,
        predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(peer: account1.address!);
      final recipientAttributes = recipientAttributesResult.value;

      final attributeContents = recipientAttributes.map((v) => v.content);

      expect(event.request.id, shareAttributeResult.value.id);
      expect(attributeContents, contains(identityAttribute.content));
      expect(event.request.content.title, 'aRequestTitle');
      expect(event.request.content.description, 'aRequestDescription');
      expect(event.request.content.metadata, {'a': 'b'});
      // expect(event.request.content.items.first.title, 'aRequestItemTitle');
      // expect(event.request.content.items.first.description, 'aRequestItemDescription');
    });
  });
}
