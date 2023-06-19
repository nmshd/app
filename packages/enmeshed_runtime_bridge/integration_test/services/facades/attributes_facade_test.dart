import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';
import '../../mock_event_bus.dart';
import '../../utils.dart';

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account1;
  late Session sender;
  late LocalAccountDTO account2;
  late Session recipient;
  late MockEventBus eventBus;

  setUpAll(() async {
    account1 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 1');
    sender = runtime.getSession(account1.id);
    account2 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 2');
    recipient = runtime.getSession(account2.id);

    eventBus = runtime.eventBus as MockEventBus;

    await ensureActiveRelationship(sender, recipient);
  });

  setUp(() async {
    await sender.consumptionServices.attributes.createAttribute(
      content: IdentityAttribute(owner: account1.address, value: const SurnameAttributeValue(value: 'aSurname')).toJson(),
    );

    await sender.consumptionServices.attributes.createAttribute(
      content: IdentityAttribute(owner: account1.address, value: const GivenNameAttributeValue(value: 'aGivenName')).toJson(),
    );
  });

  tearDown(() async {
    final senderAttributesResult = await sender.consumptionServices.attributes.getAttributes();
    for (final attribute in senderAttributesResult.value) {
      await sender.consumptionServices.attributes.deleteAttribute(attributeId: attribute.id);
    }

    final recipientAttributesResult = await recipient.consumptionServices.attributes.getAttributes();
    for (final attribute in recipientAttributesResult.value) {
      await recipient.consumptionServices.attributes.deleteAttribute(attributeId: attribute.id);
    }
  });

  group('AttributesFacade: createAttribute', () {
    test('should create an attribute', () async {
      final attributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: account1.address, value: const CityAttributeValue(value: 'aCity')).toJson(),
      );

      expect(attributeResult, isSuccessful<LocalAttributeDTO>());
      expect(attributeResult.value.content.toJson()['@type'], 'IdentityAttribute');
      expect(attributeResult.value.content.toJson()['value']['value'], 'aCity');
    });
  });

  group('AttributesFacade: createSharedAttributeCopy', () {
    test('should allow to create a shared copy', () async {
      final nationalityParams = IdentityAttribute(owner: account1.address, value: const NationalityAttributeValue(value: 'DE'));

      final attributeResult = await sender.consumptionServices.attributes.createAttribute(content: nationalityParams.toJson());
      final attribute = attributeResult.value;

      final sharedNationalityResult = await sender.consumptionServices.attributes.createSharedAttributeCopy(
        attributeId: attribute.id,
        peer: 'id1A35CharacterLongAddressXXXXXXXXX',
        requestReference: 'REQIDXXXXXXXXXXXXXXX',
      );

      expect(sharedNationalityResult, isSuccessful<LocalAttributeDTO>());
      expect(sharedNationalityResult.value.content, nationalityParams);
      expect(sharedNationalityResult.value.content.toJson()['value'], nationalityParams.value.toJson());
      expect(sharedNationalityResult.value.shareInfo?.peer, 'id1A35CharacterLongAddressXXXXXXXXX');
    });
  });

  group('AttributesFacade: deleteAttribute', () {
    test('should delete the attributes successfully', () async {
      final attributesBeforeDeleteResult = await sender.consumptionServices.attributes.getAttributes();
      final attributesBeforeDelete = attributesBeforeDeleteResult.value;

      await sender.consumptionServices.attributes.deleteAttribute(attributeId: attributesBeforeDelete.first.id);

      final attributesAfterDeleteResult = await sender.consumptionServices.attributes.getAttributes();
      final attributesAfterDelete = attributesAfterDeleteResult.value;

      expect(attributesBeforeDelete.length, 2);
      expect(attributesAfterDelete.length, 1);
    });
  });

  group('AttributesFacade: getPeerAttributes', () {
    test('should return a valid list of peer attributes', () async {
      final attribute = IdentityAttribute(owner: account1.address, value: const PhoneNumberAttributeValue(value: '012345678910'));

      await shareAndAcceptPeerAttribute(sender, recipient, account2.address, attribute);

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(peer: account1.address);

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());

      final attributeContents = recipientAttributesResult.value.map((e) => e.content);

      expect(recipientAttributesResult.value.length, 1);
      expect(attributeContents, contains(attribute));
    });

    test('should return just non technical peer attributes when hideTechnical=true', () async {
      final attribute = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        isTechnical: true,
      );

      await shareAndAcceptPeerAttribute(sender, recipient, account2.address, attribute);

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(
        peer: account1.address,
        hideTechnical: true,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 0);
    });

    test('should return also technical peer attributes when hideTechnical=false', () async {
      final attribute = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        isTechnical: true,
      );

      await shareAndAcceptPeerAttribute(sender, recipient, account2.address, attribute);

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(
        peer: account1.address,
        hideTechnical: false,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 1);
    });

    test('should return just valid peer attributes when onlyValid=true', () async {
      final attribute = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      await shareAndAcceptPeerAttribute(sender, recipient, account2.address, attribute);

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(
        peer: account1.address,
        onlyValid: true,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 0);
    });

    test('should return also expired peer attributes when onlyValid=false', () async {
      final attribute = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      await shareAndAcceptPeerAttribute(sender, recipient, account2.address, attribute);

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(
        peer: account1.address,
        onlyValid: false,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 1);
    });

    test('should return a valid list of LocalAttributeDTOs with all properties', () async {
      final attribute = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        validTo: DateTime.now().toRuntimeIsoString(),
        isTechnical: true,
      );

      await shareAndAcceptPeerAttribute(sender, recipient, account2.address, attribute);

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(
        peer: account1.address,
        onlyValid: true,
        hideTechnical: true,
      );

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(recipientAttributesResult.value.length, 0);
    });
  });

  group('AttributesFacade: getSharedToPeerAttributes', () {
    test('should return a valid list of shared to peer attributes', () async {
      final nationalityParams = IdentityAttribute(owner: account1.address, value: const NationalityAttributeValue(value: 'DE'));
      const peer = 'id1A35CharacterLongAddressXXXXXXXXX';

      final sharedNationality = await establishSharedAttributeCopy(sender, account1.address, peer, nationalityParams);

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getSharedToPeerAttributes(peer: peer);

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 1);

      expect(sharedNationality.content.toJson()['value'], nationalityParams.value.toJson());
      expect(sharedNationality.shareInfo?.peer, peer);
    });

    test('should return just non technical shared to peer attributes when hideTechnical=true', () async {
      final proprietaryBooleanParams = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        isTechnical: true,
      );

      const peer = 'id1A35CharacterLongAddressXXXXXXXXX';

      final sharedproprietaryBoolean = await establishSharedAttributeCopy(sender, account1.address, peer, proprietaryBooleanParams);

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getSharedToPeerAttributes(
        peer: peer,
        hideTechnical: true,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 0);

      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });

    test('should return also technical shared to peer attributes when hideTechnical=false', () async {
      final proprietaryBooleanParams = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        isTechnical: true,
      );

      const peer = 'id1A35CharacterLongAddressXXXXXXXXX';

      final sharedproprietaryBoolean = await establishSharedAttributeCopy(sender, account1.address, peer, proprietaryBooleanParams);

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getSharedToPeerAttributes(
        peer: peer,
        hideTechnical: false,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 1);

      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });

    test('should return just valid shared to peer attributes when onlyValid=true', () async {
      final proprietaryBooleanParams = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      const peer = 'id1A35CharacterLongAddressXXXXXXXXX';

      final sharedproprietaryBoolean = await establishSharedAttributeCopy(sender, account1.address, peer, proprietaryBooleanParams);

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getSharedToPeerAttributes(
        peer: peer,
        onlyValid: true,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 0);

      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });

    test('should return also expired shared to peer attributes when onlyValid=false', () async {
      final proprietaryBooleanParams = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      const peer = 'id1A35CharacterLongAddressXXXXXXXXX';

      final sharedproprietaryBoolean = await establishSharedAttributeCopy(sender, account1.address, peer, proprietaryBooleanParams);

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getSharedToPeerAttributes(
        peer: peer,
        onlyValid: false,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 1);

      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });

    test('should return a valid list of non technical LocalAttributeDTOs with all properties', () async {
      final proprietaryBooleanParams = RelationshipAttribute(
        owner: account1.address,
        value: const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        validTo: DateTime.now().toRuntimeIsoString(),
        isTechnical: true,
      );

      const peer = 'id1A35CharacterLongAddressXXXXXXXXX';

      final sharedproprietaryBoolean = await establishSharedAttributeCopy(sender, account1.address, peer, proprietaryBooleanParams);

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getSharedToPeerAttributes(
        peer: peer,
        onlyValid: true,
        hideTechnical: true,
      );

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 0);

      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
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
      await sender.consumptionServices.attributes.createAttribute(
        content: RelationshipAttribute(
          owner: account1.address,
          value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
          isTechnical: true,
        ).toJson(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(
        query: {'content.value.@type': QueryValue.string('ProprietaryString')},
      );

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 1);
    });

    test('should return just non technical attributes when hideTechnical=true', () async {
      await sender.consumptionServices.attributes.createAttribute(
        content: RelationshipAttribute(
          owner: account1.address,
          value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
          isTechnical: true,
        ).toJson(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(hideTechnical: true);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 2);
    });

    test('should return also technical attributes when hideTechnical=false', () async {
      await sender.consumptionServices.attributes.createAttribute(
        content: RelationshipAttribute(
          owner: account1.address,
          value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
          isTechnical: true,
        ).toJson(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(hideTechnical: false);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 3);
    });

    test('should return just valid attributes when onlyValid=true', () async {
      await sender.consumptionServices.attributes.createAttribute(
        content: RelationshipAttribute(
          owner: account1.address,
          value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
          validTo: DateTime.now().toRuntimeIsoString(),
        ).toJson(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(onlyValid: true);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 2);
    });

    test('should return also expired attributes when onlyValid=false', () async {
      await sender.consumptionServices.attributes.createAttribute(
        content: RelationshipAttribute(
          owner: account1.address,
          value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
          validTo: DateTime.now().toRuntimeIsoString(),
        ).toJson(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(onlyValid: false);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 3);
    });

    test('should return a valid list of LocalAttributeDTOs with all properties', () async {
      await sender.consumptionServices.attributes.createAttribute(
        content: RelationshipAttribute(
          owner: account1.address,
          value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
          validTo: DateTime.now().toRuntimeIsoString(),
          isTechnical: true,
        ).toJson(),
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
      final identityAttributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: account1.address, value: const PhoneNumberAttributeValue(value: '012345678910')).toJson(),
      );
      final identityAttribute = identityAttributeResult.value;

      final relationshipAttributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: RelationshipAttribute(
          owner: account1.address,
          value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aProprietaryStringValue'),
          key: 'phone',
          confidentiality: RelationshipAttributeConfidentiality.protected,
        ).toJson(),
      );
      final relationshipAttribute = relationshipAttributeResult.value;

      final receivedAttributesResult = await sender.consumptionServices.attributes.executeIdentityAttributeQuery(
        query: const IdentityAttributeQuery(valueType: 'PhoneNumber'),
      );

      expect(receivedAttributesResult, isSuccessful<List<LocalAttributeDTO>>());

      final attributeIds = receivedAttributesResult.value.map((v) => v.id);

      expect(receivedAttributesResult.value.length, 1);
      expect(attributeIds, isNot(contains(relationshipAttribute.id)));
      expect(attributeIds, contains(identityAttribute.id));
      expect(receivedAttributesResult.value.first, identityAttribute);
    });
  });

  group('AttributesFacade: executeRelationshipAttributeQuery', () {
    test('should allow to execute a relationshipAttributeQuery', () async {
      final relationshipAttributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: RelationshipAttribute(
          owner: account1.address,
          value: const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ).toJson(),
      );
      final relationshipAttribute = relationshipAttributeResult.value;

      final attributesResult = await sender.consumptionServices.attributes.executeRelationshipAttributeQuery(
        query: RelationshipAttributeQuery(
          key: 'aKey',
          owner: account1.address,
          attributeCreationHints: const RelationshipAttributeCreationHints(
            title: 'aTitle',
            valueType: 'ProprietaryBoolean',
            confidentiality: 'public',
          ),
        ),
      );

      expect(relationshipAttributeResult, isSuccessful<LocalAttributeDTO>());
      expect(attributesResult.value.id, relationshipAttribute.id);
    });
  });

  group('AttributesFacade: executeThirdPartyRelationshipAttributeQuery', () {
    test('should allow to execute a thirdPartyRelationshipAttributeQuery', () async {
      await exchangeAndAcceptRequestByMessage(
        sender,
        recipient,
        account1.address,
        account2.address,
        Request(items: [
          CreateAttributeRequestItem(
            mustBeAccepted: true,
            attribute: RelationshipAttribute(
              owner: account1.address,
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
        query: ThirdPartyRelationshipAttributeQuery(key: 'website', owner: account1.address, thirdParty: [account1.address]),
      );

      expect(receivedAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(receivedAttributeResult.value.length, 1);
    });
  });

  group('AttributesFacade: succeedAttribute', () {
    test('should allow to succeed an attribute', () async {
      final successorDate = DateTime.now();

      final displayNameParams = IdentityAttribute(owner: account1.address, value: const DisplayNameAttributeValue(value: 'aDisplayName'));

      final attributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: displayNameParams.toJson(),
      );
      final attribute = attributeResult.value;

      final createSuccessorParams = IdentityAttribute(
        owner: account1.address,
        value: const DisplayNameAttributeValue(value: 'aNewDisplayName'),
        validFrom: successorDate.toRuntimeIsoString(),
      );

      final successorResult = await sender.consumptionServices.attributes.succeedAttribute(
        successorContent: createSuccessorParams.toJson(),
        succeeds: attribute.id,
      );

      expect(successorResult, isSuccessful<LocalAttributeDTO>());

      final succeededAttributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: attribute.id);
      final succeededAttribute = succeededAttributeResult.value;

      final succeessorAttributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: successorResult.value.id);
      final succeessorAttribute = succeessorAttributeResult.value;

      final allAttributesResult = await sender.consumptionServices.attributes.getAttributes();
      final allAttributes = allAttributesResult.value;

      final currentAttributesResult = await sender.consumptionServices.attributes.getAttributes(onlyValid: true);
      final currentAttributes = currentAttributesResult.value;

      final allAttributesIds = allAttributes.map((e) => e.id);
      final currentAttributesIds = currentAttributes.map((e) => e.id);

      expect(succeededAttribute.content.validTo, successorDate.subtract(const Duration(milliseconds: 1)).toRuntimeIsoString());
      expect(succeessorAttribute.content.validFrom, successorDate.toRuntimeIsoString());
      expect(allAttributesIds, contains(succeededAttribute.id));
      expect(currentAttributesIds, isNot(contains(succeededAttribute.id)));
      expect(currentAttributesIds, contains(succeessorAttribute.id));
    });
  });

  group('AttributesFacade: updateAttribute', () {
    test('should updated an attribute', () async {
      final addressResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(
          owner: account1.address,
          value: const StreetAddressAttributeValue(
            recipient: 'aRecipient',
            street: 'aStreet',
            houseNumber: 'aHouseNumber',
            zipCode: 'aZipCode',
            city: 'aCity',
            country: 'DE',
            state: 'aState',
          ),
        ).toJson(),
      );
      final address = addressResult.value;

      final updatedParams = IdentityAttribute(
        owner: account1.address,
        value: const StreetAddressAttributeValue(
          recipient: 'aNewRecipient',
          street: 'aNewStreet',
          houseNumber: 'aNewHouseNumber',
          zipCode: 'aNewZipCode',
          city: 'aNewCity',
          country: 'DE',
          state: 'aNewState',
        ),
      );

      final newAddressResult = await sender.consumptionServices.attributes.updateAttribute(
        attributeId: address.id,
        content: updatedParams.toJson(),
      );

      expect(newAddressResult, isSuccessful<LocalAttributeDTO>());
      expect(newAddressResult.value.content, updatedParams);
    });
  });

  group('AttributesFacade: shareAttribute', () {
    test('should allow to share an attribute', () async {
      final recipientAddress = account2.address;
      final attribute = IdentityAttribute(owner: account1.address, value: const PhoneNumberAttributeValue(value: '012345678910'));

      final identityAttributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: attribute.toJson(),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      expect(shareAttributeResult, isSuccessful<LocalRequestDTO>());

      await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
        eventTargetAddress: account1.address,
        predicate: (e) => e.newStatus == LocalRequestStatus.Open,
      );

      await syncUntilHasMessage(recipient);

      final event = await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(eventTargetAddress: recipientAddress);

      final acceptRequestResult = await recipient.consumptionServices.incomingRequests.accept(
        params: DecideRequestParameters(
          requestId: shareAttributeResult.value.id,
          items: [AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute)],
        ),
      );

      expect(acceptRequestResult, isSuccessful<LocalRequestDTO>());

      await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
        eventTargetAddress: recipientAddress,
        predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(peer: account1.address);
      final recipientAttributes = recipientAttributesResult.value;

      final attributeContents = recipientAttributes.map((v) => v.content);

      expect(event.request.id, shareAttributeResult.value.id);
      expect(attributeContents, contains(identityAttribute.content));
    });

    test('should allow to share an attribute with all properties', () async {
      final recipientAddress = account2.address;
      final attribute = IdentityAttribute(owner: account1.address, value: const PhoneNumberAttributeValue(value: '012345678910'));

      final identityAttributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: attribute.toJson(),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
        requestTitle: 'aRequestTitle',
        requestDescription: 'aRequestDescription',
        requestMetadata: {'a': 'b'},
        requestItemTitle: 'aRequestItemTitle',
        requestItemDescription: 'aRequestItemDescription',
      );

      expect(shareAttributeResult, isSuccessful<LocalRequestDTO>());

      await eventBus.waitForEvent<OutgoingRequestStatusChangedEvent>(
        eventTargetAddress: account1.address,
        predicate: (e) => e.newStatus == LocalRequestStatus.Open,
      );

      await syncUntilHasMessage(recipient);

      final event = await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(eventTargetAddress: recipientAddress);

      final acceptRequestResult = await recipient.consumptionServices.incomingRequests.accept(
        params: DecideRequestParameters(
          requestId: shareAttributeResult.value.id,
          items: [AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute)],
        ),
      );

      expect(acceptRequestResult, isSuccessful<LocalRequestDTO>());

      await eventBus.waitForEvent<IncomingRequestStatusChangedEvent>(
        eventTargetAddress: recipientAddress,
        predicate: (e) => e.newStatus == LocalRequestStatus.Completed,
      );

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(peer: account1.address);
      final recipientAttributes = recipientAttributesResult.value;

      final attributeContents = recipientAttributes.map((v) => v.content);

      expect(event.request.id, shareAttributeResult.value.id);
      expect(attributeContents, contains(identityAttribute.content));
      expect(event.request.content.title, 'aRequestTitle');
      expect(event.request.content.description, 'aRequestDescription');
      expect(event.request.content.metadata, {'a': 'b'});
      expect(event.request.content.items.first.title, 'aRequestItemTitle');
      expect(event.request.content.items.first.description, 'aRequestItemDescription');
    });
  });
}
