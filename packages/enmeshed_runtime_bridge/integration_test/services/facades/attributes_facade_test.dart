import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';
import '../../utils.dart';

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account1;
  late Session sender;
  late LocalAccountDTO account2;
  late Session recipient;

  setUpAll(() async {
    account1 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 1');
    sender = runtime.getSession(account1.id);
    account2 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 2');
    recipient = runtime.getSession(account2.id);

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
    testWidgets('returns a valid LocalAttributeDTO', (_) async {
      final attributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: account1.address, value: const CityAttributeValue(value: 'aCity')).toJson(),
      );
      final attribute = attributeResult.value;

      expect(attribute, isA<LocalAttributeDTO>());
      expect(attribute.content.toJson()['@type'], 'IdentityAttribute');
      expect(attribute.content.toJson()['value']['value'], 'aCity');
    });
  });

  group('AttributesFacade: createSharedAttributeCopy', () {
    testWidgets('returns a valid LocalAttributeDTO', (_) async {
      final nationalityParams = IdentityAttribute(owner: account1.address, value: const NationalityAttributeValue(value: 'DE'));

      final attributeResult = await sender.consumptionServices.attributes.createAttribute(content: nationalityParams.toJson());
      final attribute = attributeResult.value;

      final sharedNationalityResult = await sender.consumptionServices.attributes.createSharedAttributeCopy(
        attributeId: attribute.id,
        peer: 'id1A35CharacterLongAddressXXXXXXXXX',
        requestReference: 'REQIDXXXXXXXXXXXXXXX',
      );
      final sharedNationality = sharedNationalityResult.value;

      expect(sharedNationalityResult.isSuccess, true);
      expect(sharedNationality, isA<LocalAttributeDTO>());
      expect(sharedNationality.content.toJson()['value'], nationalityParams.value.toJson());
      expect(sharedNationality.shareInfo?.peer, 'id1A35CharacterLongAddressXXXXXXXXX');
    });
  });

  group('AttributesFacade: deleteAttribute', () {
    testWidgets('deletes the attributes successfully', (_) async {
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
    testWidgets('returns a valid list of LocalAttributeDTOs', (_) async {
      final attribute = IdentityAttribute(owner: account1.address, value: const PhoneNumberAttributeValue(value: '012345678910'));

      await shareAndAcceptPeerAttribute(sender, recipient, account2.address, attribute);

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerAttributes(peer: account1.address);
      final recipientAttributes = recipientAttributesResult.value;

      final attributeContents = recipientAttributes.map((e) => e.content);

      expect(recipientAttributes, isA<List<LocalAttributeDTO>>());
      expect(recipientAttributes.length, 1);
      expect(attributeContents, contains(attribute));
    });

    testWidgets('returns just non technical peer attributes when hideTechnical=true', (_) async {
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
      final recipientAttributes = recipientAttributesResult.value;

      expect(recipientAttributes, isA<List<LocalAttributeDTO>>());
      expect(recipientAttributes.length, 0);
    });

    testWidgets('returns also technical peer attributes when hideTechnical=false', (_) async {
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
      final recipientAttributes = recipientAttributesResult.value;

      expect(recipientAttributes, isA<List<LocalAttributeDTO>>());
      expect(recipientAttributes.length, 1);
    });

    testWidgets('returns just valid peer attributes when onlyValid=true', (_) async {
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
      final recipientAttributes = recipientAttributesResult.value;

      expect(recipientAttributes, isA<List<LocalAttributeDTO>>());
      expect(recipientAttributes.length, 0);
    });

    testWidgets('returns also expired peer attributes when onlyValid=false', (_) async {
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
      final recipientAttributes = recipientAttributesResult.value;

      expect(recipientAttributes, isA<List<LocalAttributeDTO>>());
      expect(recipientAttributes.length, 1);
    });

    testWidgets('returns a valid list of LocalAttributeDTOs with all properties', (_) async {
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
      final recipientAttributes = recipientAttributesResult.value;

      expect(recipientAttributes, isA<List<LocalAttributeDTO>>());
      expect(recipientAttributes.length, 0);
    });
  });

  group('AttributesFacade: getSharedToPeerAttributes', () {
    testWidgets('returns a valid list of LocalAttributeDTOs', (_) async {
      final nationalityParams = IdentityAttribute(owner: account1.address, value: const NationalityAttributeValue(value: 'DE'));
      const peer = 'id1A35CharacterLongAddressXXXXXXXXX';

      final sharedNationality = await establishSharedAttributeCopy(sender, account1.address, peer, nationalityParams);

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getSharedToPeerAttributes(peer: peer);
      final sharedToPeerAttributes = sharedToPeerAttributeResult.value;

      expect(sharedToPeerAttributes, isA<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributes.length, 1);

      expect(sharedNationality, isA<LocalAttributeDTO>());
      expect(sharedNationality.content.toJson()['value'], nationalityParams.value.toJson());
      expect(sharedNationality.shareInfo?.peer, peer);
    });

    testWidgets('returns just non technical shared to peer attributes when hideTechnical=true', (_) async {
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
      final sharedToPeerAttributes = sharedToPeerAttributeResult.value;

      expect(sharedToPeerAttributes, isA<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributes.length, 0);

      expect(sharedproprietaryBoolean, isA<LocalAttributeDTO>());
      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });

    testWidgets('returns also technical shared to peer attributes when hideTechnical=false', (_) async {
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
      final sharedToPeerAttributes = sharedToPeerAttributeResult.value;

      expect(sharedToPeerAttributes, isA<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributes.length, 1);

      expect(sharedproprietaryBoolean, isA<LocalAttributeDTO>());
      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });

    testWidgets('returns just valid shared to peer attributes when onlyValid=true', (_) async {
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
      final sharedToPeerAttributes = sharedToPeerAttributeResult.value;

      expect(sharedToPeerAttributes, isA<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributes.length, 0);

      expect(sharedproprietaryBoolean, isA<LocalAttributeDTO>());
      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });

    testWidgets('returns also expired shared to peer attributes when onlyValid=false', (_) async {
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
      final sharedToPeerAttributes = sharedToPeerAttributeResult.value;

      expect(sharedToPeerAttributes, isA<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributes.length, 1);

      expect(sharedproprietaryBoolean, isA<LocalAttributeDTO>());
      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });

    testWidgets('returns a valid list of non technical LocalAttributeDTOs with all properties', (_) async {
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
      final sharedToPeerAttributes = sharedToPeerAttributeResult.value;

      expect(sharedToPeerAttributes, isA<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributes.length, 0);

      expect(sharedproprietaryBoolean, isA<LocalAttributeDTO>());
      expect(sharedproprietaryBoolean.content.toJson()['value'], proprietaryBooleanParams.value.toJson());
      expect(sharedproprietaryBoolean.shareInfo?.peer, peer);
    });
  });

  group('AttributesFacade: getAttribute', () {
    testWidgets('returns a valid LocalAttributeDTO', (_) async {
      final attributesResult = await sender.consumptionServices.attributes.getAttributes();
      final attributes = attributesResult.value;

      final attributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: attributes.first.id);
      final attribute = attributeResult.value;

      expect(attribute, isA<LocalAttributeDTO>());
      expect(attribute.id, attributes.first.id);
      expect(attribute.content, attributes.first.content);
    });

    testWidgets('throws an exception if file id does not match the pattern', (_) async {
      final result = await sender.consumptionServices.attributes.getAttribute(attributeId: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    testWidgets('throws an exception on not existing file id', (_) async {
      final result = await sender.consumptionServices.attributes.getAttribute(attributeId: 'ATTz9TeStNBIzsgGVvv8');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('AttributesFacade: getAttributes', () {
    testWidgets('returns a valid list of LocalAttributeDTOs', (_) async {
      final attributesResult = await sender.consumptionServices.attributes.getAttributes();
      final attributes = attributesResult.value;

      expect(attributes, isA<List<LocalAttributeDTO>>());
      expect(attributes.length, 2);
    });

    testWidgets('returns a valid list of queried LocalAttributeDTOs', (_) async {
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
      final attributes = attributesResult.value;

      expect(attributes, isA<List<LocalAttributeDTO>>());
      expect(attributes.length, 1);
    });

    testWidgets('returns just non technical attributes when hideTechnical=true', (_) async {
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
      final attributes = attributesResult.value;

      expect(attributes, isA<List<LocalAttributeDTO>>());
      expect(attributes.length, 2);
    });

    testWidgets('returns also technical attributes when hideTechnical=false', (_) async {
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
      final attributes = attributesResult.value;

      expect(attributes, isA<List<LocalAttributeDTO>>());
      expect(attributes.length, 3);
    });

    testWidgets('returns just valid attributes when onlyValid=true', (_) async {
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
      final attributes = attributesResult.value;

      expect(attributes, isA<List<LocalAttributeDTO>>());
      expect(attributes.length, 2);
    });

    testWidgets('returns also expired attributes when onlyValid=false', (_) async {
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
      final attributes = attributesResult.value;

      expect(attributes, isA<List<LocalAttributeDTO>>());
      expect(attributes.length, 3);
    });

    testWidgets('returns a valid list of LocalAttributeDTOs with all properties', (_) async {
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
      final attributes = attributesResult.value;

      expect(attributes, isA<List<LocalAttributeDTO>>());
      expect(attributes.length, 1);
    });
  });

  group('AttributesFacade: executeIdentityAttributeQuery', () {
    testWidgets('returns a valid list of LocalAttributeDTOs', (_) async {
      final identityAttributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: account1.address, value: const PhoneNumberAttributeValue(value: '012345678910')).toJson(),
      );
      final identityAttribute = identityAttributeResult.value;

      final attributesResult = await sender.consumptionServices.attributes.executeIdentityAttributeQuery(
        query: const IdentityAttributeQuery(valueType: 'PhoneNumber'),
      );
      final attributes = attributesResult.value;

      expect(attributes, isA<List<LocalAttributeDTO>>());
      expect(attributes.length, 1);
      expect(attributes.first.id, identityAttribute.id);
    });
  });

  group('AttributesFacade: executeRelationshipAttributeQuery', () {
    testWidgets('returns a valid list of LocalAttributeDTOs', (_) async {
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

      final attributes = attributesResult.value;

      expect(attributes, isA<LocalAttributeDTO>());
      expect(attributes.id, relationshipAttribute.id);
    });
  });

  group('AttributesFacade: executeThirdPartyRelationshipAttributeQuery', () {
    testWidgets('returns a valid list of LocalAttributeDTOs', (_) async {
      await exchangeAndAcceptRequestByMessage(
        sender,
        recipient,
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
      );

      final receivedAttributeResult = await recipient.consumptionServices.attributes.executeThirdPartyRelationshipAttributeQuery(
        query: ThirdPartyRelationshipAttributeQuery(key: 'website', owner: account1.address, thirdParty: [account1.address]),
      );
      final receivedAttribute = receivedAttributeResult.value;

      expect(receivedAttribute, isA<List<LocalAttributeDTO>>());
      expect(receivedAttribute.length, 1);
    });
  });

  group('AttributesFacade: succeedAttribute', () {
    testWidgets('returns a valid list of LocalAttributeDTOs', (_) async {
      final successorDate = DateTime.now();

      final attributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: account1.address, value: const DisplayNameAttributeValue(value: 'aDisplayName')).toJson(),
      );
      final attribute = attributeResult.value;

      final successorResult = await sender.consumptionServices.attributes.succeedAttribute(
        successorContent: IdentityAttribute(
          owner: account1.address,
          value: const DisplayNameAttributeValue(value: 'aNewDisplayName'),
          validFrom: successorDate.toRuntimeIsoString(),
        ).toJson(),
        succeeds: attribute.id,
      );
      final successor = successorResult.value;

      final succeededAttributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: attribute.id);
      final succeededAttribute = succeededAttributeResult.value;

      final succeessorAttributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: successor.id);
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
    testWidgets('returns a valid LocalAttributeDTO', (_) async {
      final attributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: account1.address, value: const CityAttributeValue(value: 'aCity')).toJson(),
      );
      final attribute = attributeResult.value;

      final updatedCityAttribute = IdentityAttribute(owner: account1.address, value: const CityAttributeValue(value: 'aNewCity'));

      final updatedAttributeResult = await sender.consumptionServices.attributes.updateAttribute(
        attributeId: attribute.id,
        content: updatedCityAttribute.toJson(),
      );
      final updatedAttribute = updatedAttributeResult.value;

      expect(updatedAttribute, isA<LocalAttributeDTO>());
      expect(updatedAttribute.content, updatedCityAttribute);
    });
  });

  group('AttributesFacade: shareAttribute', () {
    testWidgets('returns a valid LocalRequestDTO', (_) async {
      final recipientAddress = await recipient.transportServices.account.getIdentityInfo();

      final identityAttributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: account1.address, value: const PhoneNumberAttributeValue(value: '012345678910')).toJson(),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress.value.address,
      );
      final shareAttribute = shareAttributeResult.value;

      await syncUntilHasMessage(recipient);

      final request = (await recipient.consumptionServices.incomingRequests.getRequests()).value.last;

      expect(shareAttribute, isA<LocalRequestDTO>());
      expect(shareAttribute.id, request.id);
      expect(shareAttribute.peer, account2.address);
      expect(shareAttribute.content, request.content);
    });

    testWidgets('returns a valid LocalRequestDTO with all properties', (_) async {
      final recipientAddress = await recipient.transportServices.account.getIdentityInfo();

      final identityAttributeResult = await sender.consumptionServices.attributes.createAttribute(
        content: IdentityAttribute(owner: account1.address, value: const PhoneNumberAttributeValue(value: '012345678910')).toJson(),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress.value.address,
        requestTitle: 'aRequestTitle',
        requestDescription: 'aRequestDescription',
        requestMetadata: {'a': 'b'},
        requestItemTitle: 'aRequestItemTitle',
        requestItemDescription: 'aRequestItemDescription',
      );
      final shareAttribute = shareAttributeResult.value;

      await syncUntilHasMessage(recipient);

      final request = (await recipient.consumptionServices.incomingRequests.getRequests()).value.last;

      expect(shareAttribute, isA<LocalRequestDTO>());
      expect(shareAttribute.id, request.id);
      expect(shareAttribute.peer, account2.address);
      expect(shareAttribute.content, request.content);
    });
  });
}
