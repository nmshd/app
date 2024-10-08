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
  late LocalAccountDTO account3;
  late Session thirdParty;
  late MockEventBus eventBus;

  setUp(() async {
    account1 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 1');
    sender = runtime.getSession(account1.id);
    account2 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 2');
    recipient = runtime.getSession(account2.id);
    account3 = await runtime.accountServices.createAccount(name: 'attributesFacade Test 3');
    thirdParty = runtime.getSession(account3.id);

    eventBus = runtime.eventBus as MockEventBus;

    await ensureActiveRelationship(sender, recipient);
    await ensureActiveRelationship(sender, thirdParty);
  });

  group('AttributesFacade: createRepositoryAttribute', () {
    test('should create an identity attribute', () async {
      final attributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(value: const CityAttributeValue(value: 'aCity'));

      expect(attributeResult, isSuccessful<LocalAttributeDTO>());
      expect(attributeResult.value.content.toJson()['@type'], 'IdentityAttribute');
      expect(attributeResult.value.content.toJson()['value']['value'], 'aCity');
    });
  });

  group('AttributesFacade: getPeerSharedAttributes', () {
    test('should return a valid list of peer shared', () async {
      final sharedAttribute = await exchangeIdentityAttribute(sender, recipient, const PhoneNumberAttributeValue(value: '012345678910'));

      final recipientAttributesResult = await recipient.consumptionServices.attributes.getPeerSharedAttributes(peer: account1.address!);

      expect(recipientAttributesResult, isSuccessful<List<LocalAttributeDTO>>());

      expect(recipientAttributesResult.value.length, 1);
      expect(recipientAttributesResult.value.first.id, sharedAttribute.id);
    });

    test('should return just non technical peer shared when hideTechnical=true', () async {
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

    test('should return also technical peer shared when hideTechnical=false', () async {
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

    test('should return just valid peer shared when onlyValid=true', () async {
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

    test('should return also expired peer shared when onlyValid=false', () async {
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
    test('should return a valid list of own shared attributes', () async {
      final peer = account2.address!;

      await exchangeIdentityAttribute(sender, recipient, const NationalityAttributeValue(value: 'DE'));

      final sharedToPeerAttributeResult = await sender.consumptionServices.attributes.getOwnSharedAttributes(peer: peer);

      expect(sharedToPeerAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(sharedToPeerAttributeResult.value.length, 1);

      final sharedNationality = sharedToPeerAttributeResult.value.first;

      expect(sharedNationality.content.toJson()['value'], {'@type': 'Nationality', 'value': 'DE'});
      expect(sharedNationality.shareInfo?.peer, peer);
    });

    test('should return just non technical own shared attributes when hideTechnical=true', () async {
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

    test('should return also technical own shared attributes when hideTechnical=false', () async {
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

    test('should return just valid own shared attributes when onlyValid=true', () async {
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

    test('should return also expired own shared attributes when onlyValid=false', () async {
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

  group('AttributesFacade: getRepositoryAttributes', () {
    test('should return a valid list of repository attributes', () async {
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const GivenNameAttributeValue(value: 'aGivenName'));
      exchangeIdentityAttribute(sender, recipient, const SurnameAttributeValue(value: 'aSurname'));

      final repositoryAttributesResult = await sender.consumptionServices.attributes.getRepositoryAttributes();
      expect(repositoryAttributesResult, isSuccessful<List<LocalAttributeDTO>>());

      expect(repositoryAttributesResult.value.length, 2);
      expect(repositoryAttributesResult.value.every((e) => e.shareInfo == null), true);
    });

    test('should return only default repository attributes', () async {
      final defaultAttribute =
          (await sender.consumptionServices.attributes.createRepositoryAttribute(value: const GivenNameAttributeValue(value: 'aDefaultGivenName')))
              .value;
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const GivenNameAttributeValue(value: 'anotherGivenName'));

      final repositoryAttributesResult =
          await sender.consumptionServices.attributes.getRepositoryAttributes(query: {'isDefault': QueryValue.string('true')});
      expect(repositoryAttributesResult, isSuccessful<List<LocalAttributeDTO>>());

      expect(repositoryAttributesResult.value[0], defaultAttribute);
      expect(repositoryAttributesResult.value[0].isDefault, true);
    });
  });

  group('AttributesFacade: getAttribute', () {
    test('should return a valid LocalAttributeDTO', () async {
      final attributesResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const SurnameAttributeValue(value: 'aSurname'),
      );
      final attribute = attributesResult.value;

      final attributeResult = await sender.consumptionServices.attributes.getAttribute(attributeId: attribute.id);

      expect(attributeResult, isSuccessful<LocalAttributeDTO>());
      expect(attributeResult.value.id, attribute.id);
      expect(attributeResult.value.content, attribute.content);
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
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const SurnameAttributeValue(value: 'aSurname'));
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const GivenNameAttributeValue(value: 'aGivenName'));
      final attributesResult = await sender.consumptionServices.attributes.getAttributes();

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 2);
    });

    test('should return a valid list of queried LocalAttributeDTOs', () async {
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const SurnameAttributeValue(value: 'aSurname'));
      await exchangeRelationshipAttribute(sender, recipient, const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'));

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(
        query: {'content.value.@type': QueryValue.string('ProprietaryString')},
      );

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 1);
    });

    test('should return just non technical attributes when hideTechnical=true', () async {
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const SurnameAttributeValue(value: 'aSurname'));
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        isTechnical: true,
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(hideTechnical: true);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 1);
    });

    test('should return also technical attributes when hideTechnical=false', () async {
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const SurnameAttributeValue(value: 'aSurname'));
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        isTechnical: true,
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(hideTechnical: false);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 2);
    });

    test('should return just valid attributes when onlyValid=true', () async {
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const SurnameAttributeValue(value: 'aSurname'));
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(onlyValid: true);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 1);
    });

    test('should return also expired attributes when onlyValid=false', () async {
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const SurnameAttributeValue(value: 'aSurname'));
      await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
        validTo: DateTime.now().toRuntimeIsoString(),
      );

      final attributesResult = await sender.consumptionServices.attributes.getAttributes(onlyValid: false);

      expect(attributesResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(attributesResult.value.length, 2);
    });

    test('should return a valid list of LocalAttributeDTOs with all properties', () async {
      await sender.consumptionServices.attributes.createRepositoryAttribute(value: const SurnameAttributeValue(value: 'aSurname'));
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

  group('AttributesFacade: getVersionsOfAttribute', () {
    test('should get all versions of a repository attribute', () async {
      final recipientAddress = account2.address!;

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'First Name'),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        shareAttributeResult.value,
        eventBus,
      );

      final succeededAttribute1Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: identityAttribute.id,
        value: const GivenNameAttributeValue(value: 'Second Name'),
      );

      final succeededAttribute2Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: succeededAttribute1Result.value.successor.id,
        value: const GivenNameAttributeValue(value: 'Third Name'),
      );

      final attributeVersion1 = (await sender.consumptionServices.attributes.getAttribute(attributeId: identityAttribute.id)).value;
      final attributeVersion2 =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: succeededAttribute1Result.value.successor.id)).value;
      final attributeVersion3 =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: succeededAttribute2Result.value.successor.id)).value;

      final attributeVersions = [attributeVersion1, attributeVersion2, attributeVersion3];

      await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttribute2Result.value.successor.id,
        peer: recipientAddress,
      );

      for (final version in attributeVersions) {
        final result = await sender.consumptionServices.attributes.getVersionsOfAttribute(attributeId: version.id);

        expect(result, isSuccessful<List<LocalAttributeDTO>>());
        expect(result.value.length, 3);
        expect(result.value, [attributeVersion3, attributeVersion2, attributeVersion1]);
      }
    }, timeout: const Timeout(Duration(seconds: 60)));
  });

  group('AttributesFacade: getSharedVersionsOfAttribute', () {
    test('should get only latest shared versions of a repository attribute', () async {
      final recipientAddress = account2.address!;
      final List<LocalAttributeDTO> versions = [];

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'First Name'),
      );
      final identityAttribute = identityAttributeResult.value;
      versions.add(identityAttribute);

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        shareAttributeResult.value,
        eventBus,
      );

      final succeededAttribute1Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: identityAttribute.id,
        value: const GivenNameAttributeValue(value: 'Second Name'),
      );
      versions.add(succeededAttribute1Result.value.successor);

      final succeededAttribute2Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: succeededAttribute1Result.value.successor.id,
        value: const GivenNameAttributeValue(value: 'Third Name'),
      );
      versions.add(succeededAttribute2Result.value.successor);

      final notifyRequestResult = await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttribute2Result.value.successor.id,
        peer: recipientAddress,
      );

      await waitForRecipientToReceiveNotification(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        notifyRequestResult.value.notificationId,
        notifyRequestResult.value.successor.id,
        eventBus,
      );

      final attributeVersion3 = notifyRequestResult.value.successor;

      for (final version in versions) {
        final result = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(
          attributeId: version.id,
          onlyLatestVersions: true,
        );
        expect(result, isSuccessful<List<LocalAttributeDTO>>());
        expect(result.value.length, 1);
        expect(result.value.first, attributeVersion3);
      }
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('should get only latest shared to peer versions of a repository attribute with property onlyLatestVersions: true', () async {
      final recipientAddress = account2.address!;
      final List<LocalAttributeDTO> versions = [];

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'First Name'),
      );
      final identityAttribute = identityAttributeResult.value;
      versions.add(identityAttribute);

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        shareAttributeResult.value,
        eventBus,
      );

      final succeededAttribute1Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: identityAttribute.id,
        value: const GivenNameAttributeValue(value: 'Second Name'),
      );
      versions.add(succeededAttribute1Result.value.successor);

      final succeededAttribute2Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: succeededAttribute1Result.value.successor.id,
        value: const GivenNameAttributeValue(value: 'Third Name'),
      );
      versions.add(succeededAttribute2Result.value.successor);

      final notifyRequestResult = await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttribute2Result.value.successor.id,
        peer: recipientAddress,
      );

      await waitForRecipientToReceiveNotification(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        notifyRequestResult.value.notificationId,
        notifyRequestResult.value.successor.id,
        eventBus,
      );

      final attributeVersion3 = notifyRequestResult.value.successor;

      for (final version in versions) {
        final result = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(
          attributeId: version.id,
          onlyLatestVersions: true,
        );
        expect(result, isSuccessful<List<LocalAttributeDTO>>());
        expect(result.value.length, 1);
        expect(result.value.first, attributeVersion3);
      }
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('should get all shared to peer versions of a repository attribute with property onlyLatestVersions: false', () async {
      final recipientAddress = account2.address!;
      final List<LocalAttributeDTO> versions = [];

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'First Name'),
      );
      final identityAttribute = identityAttributeResult.value;
      versions.add(identityAttribute);

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        shareAttributeResult.value,
        eventBus,
      );

      final succeededAttribute1Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: identityAttribute.id,
        value: const GivenNameAttributeValue(value: 'Second Name'),
      );
      versions.add(succeededAttribute1Result.value.successor);

      final succeededAttribute2Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: succeededAttribute1Result.value.successor.id,
        value: const GivenNameAttributeValue(value: 'Third Name'),
      );
      versions.add(succeededAttribute2Result.value.successor);

      final notifyRequestResult = await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttribute2Result.value.successor.id,
        peer: recipientAddress,
      );

      await waitForRecipientToReceiveNotification(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        notifyRequestResult.value.notificationId,
        notifyRequestResult.value.successor.id,
        eventBus,
      );

      final attributeVersion1 = notifyRequestResult.value.predecessor;
      final attributeVersion3 = notifyRequestResult.value.successor;

      for (final version in versions) {
        final result = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(
          attributeId: version.id,
          onlyLatestVersions: false,
        );

        expect(result, isSuccessful<List<LocalAttributeDTO>>());
        expect(result.value.length, 2);
        expect(result.value, [attributeVersion3, attributeVersion1]);
      }
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('should get only latest shared versions of a repository attribute for a specific peer', () async {
      final recipient2 = runtime.getSession(account3.id);

      final recipient1Address = account2.address!;
      final recipient2Address = account3.address!;
      final List<LocalAttributeDTO> versions = [];

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'First Name'),
      );
      final identityAttribute = identityAttributeResult.value;
      versions.add(identityAttribute);

      final shareAttributeToRecipient1Result = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipient1Address,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipient1Address,
        shareAttributeToRecipient1Result.value,
        eventBus,
      );

      final shareAttributeToRecipient2Result = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipient2Address,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient2,
        account1.address!,
        recipient2Address,
        shareAttributeToRecipient2Result.value,
        eventBus,
      );

      final succeededAttribute1Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: identityAttribute.id,
        value: const GivenNameAttributeValue(value: 'Second Name'),
      );
      versions.add(succeededAttribute1Result.value.successor);

      final notifyRecipient2RequestResult = await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttribute1Result.value.successor.id,
        peer: recipient2Address,
      );

      await waitForRecipientToReceiveNotification(
        sender,
        recipient2,
        account1.address!,
        recipient2Address,
        notifyRecipient2RequestResult.value.notificationId,
        notifyRecipient2RequestResult.value.successor.id,
        eventBus,
      );

      final succeededAttribute2Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: succeededAttribute1Result.value.successor.id,
        value: const GivenNameAttributeValue(value: 'Third Name'),
      );
      versions.add(succeededAttribute2Result.value.successor);

      final notifyRecipient1RequestResult = await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttribute2Result.value.successor.id,
        peer: recipient1Address,
      );

      await waitForRecipientToReceiveNotification(
        sender,
        recipient,
        account1.address!,
        recipient1Address,
        notifyRecipient1RequestResult.value.notificationId,
        notifyRecipient1RequestResult.value.successor.id,
        eventBus,
      );

      final attributeVersion2 = notifyRecipient2RequestResult.value.successor;
      final attributeVersion3 = notifyRecipient1RequestResult.value.successor;

      for (final version in versions) {
        final result1 = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(
          attributeId: version.id,
          peers: [recipient1Address],
        );

        expect(result1, isSuccessful<List<LocalAttributeDTO>>());
        expect(result1.value.length, 1);
        expect(result1.value, [attributeVersion3]);

        final result2 = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(
          attributeId: version.id,
          peers: [recipient2Address],
        );

        expect(result2, isSuccessful<List<LocalAttributeDTO>>());
        expect(result2.value.length, 1);
        expect(result2.value, [attributeVersion2]);
      }
    }, timeout: const Timeout(Duration(seconds: 90)));

    test('should get all shared to peer versions of a repository attribute for a specific peer', () async {
      final recipient2 = runtime.getSession(account3.id);

      final recipient1Address = account2.address!;
      final recipient2Address = account3.address!;
      final List<LocalAttributeDTO> versions = [];

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'First Name'),
      );
      final identityAttribute = identityAttributeResult.value;
      versions.add(identityAttribute);

      final shareAttributeToRecipient1Result = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipient1Address,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipient1Address,
        shareAttributeToRecipient1Result.value,
        eventBus,
      );

      final shareAttributeToRecipient2Result = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipient2Address,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient2,
        account1.address!,
        recipient2Address,
        shareAttributeToRecipient2Result.value,
        eventBus,
      );

      final succeededAttribute1Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: identityAttribute.id,
        value: const GivenNameAttributeValue(value: 'Second Name'),
      );
      versions.add(succeededAttribute1Result.value.successor);

      final notifyRecipient2RequestResult = await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttribute1Result.value.successor.id,
        peer: recipient2Address,
      );

      await waitForRecipientToReceiveNotification(
        sender,
        recipient2,
        account1.address!,
        recipient2Address,
        notifyRecipient2RequestResult.value.notificationId,
        notifyRecipient2RequestResult.value.successor.id,
        eventBus,
      );

      final succeededAttribute2Result = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: succeededAttribute1Result.value.successor.id,
        value: const GivenNameAttributeValue(value: 'Third Name'),
      );
      versions.add(succeededAttribute2Result.value.successor);

      final notifyRecipient1RequestResult = await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttribute2Result.value.successor.id,
        peer: recipient1Address,
      );

      await waitForRecipientToReceiveNotification(
        sender,
        recipient,
        account1.address!,
        recipient1Address,
        notifyRecipient1RequestResult.value.notificationId,
        notifyRecipient1RequestResult.value.successor.id,
        eventBus,
      );

      final attributeVersion1R1 = notifyRecipient1RequestResult.value.predecessor;
      final attributeVersion1R2 = notifyRecipient2RequestResult.value.predecessor;
      final attributeVersion2 = notifyRecipient2RequestResult.value.successor;
      final attributeVersion3 = notifyRecipient1RequestResult.value.successor;

      for (final version in versions) {
        final result1 = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(
          attributeId: version.id,
          peers: [recipient1Address],
          onlyLatestVersions: false,
        );

        expect(result1, isSuccessful<List<LocalAttributeDTO>>());
        expect(result1.value.length, 2);
        expect(result1.value, [attributeVersion3, attributeVersion1R1]);

        final result2 = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(
          attributeId: version.id,
          peers: [recipient2Address],
          onlyLatestVersions: false,
        );

        expect(result2, isSuccessful<List<LocalAttributeDTO>>());
        expect(result2.value.length, 2);
        expect(result2.value, [attributeVersion2, attributeVersion1R2]);
      }
    }, timeout: const Timeout(Duration(seconds: 90)));

    test('should get all shared third party relationship attributes of a source relationship attribute', () async {
      final senderAddress = account1.address!;
      final recipientAddress = account2.address!;
      final thirdPartyAddress = account3.address!;

      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final senderOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        sender,
        thirdParty,
        senderAddress,
        thirdPartyAddress,
        attributeValue,
        eventBus,
      );

      final query = ThirdPartyRelationshipAttributeQuery(
        key: 'aKey',
        owner: ThirdPartyRelationshipAttributeQueryOwner.recipient,
        thirdParty: [thirdPartyAddress],
      );
      final requestItem = ReadAttributeRequestItem(mustBeAccepted: true, query: query);

      final senderThirdPartyOwnedRelationshipAttribute = await executeFullRequestAndShareThirdPartyRelationshipAttributeFlow(
          sender, recipient, senderAddress, recipientAddress, thirdPartyAddress, requestItem, senderOwnSharedRelationshipAttribute.id, eventBus);

      final result = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(attributeId: senderOwnSharedRelationshipAttribute.id);

      expect(result, isSuccessful<List<LocalAttributeDTO>>());
      expect(result.value.length, 1);
      expect(result.value[0], senderThirdPartyOwnedRelationshipAttribute);
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('should return an empty list if a relationship attribute without associated third party relationship attributes is queried', () async {
      final senderAddress = account1.address!;
      final recipientAddress = account2.address!;

      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final senderOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        sender,
        recipient,
        senderAddress,
        recipientAddress,
        attributeValue,
        eventBus,
      );

      final result = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(attributeId: senderOwnSharedRelationshipAttribute.id);

      expect(result, isSuccessful<List<LocalAttributeDTO>>());
      expect(result.value.length, 0);
    });

    test('should return an empty list if a repository attribute without shared copies is queried', () async {
      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'First Name'),
      );
      final identityAttribute = identityAttributeResult.value;

      final result = await sender.consumptionServices.attributes.getSharedVersionsOfAttribute(
        attributeId: identityAttribute.id,
      );
      expect(result, isSuccessful<List<LocalAttributeDTO>>());
      expect(result.value.length, 0);
    }, timeout: const Timeout(Duration(seconds: 60)));
  });

  group('AttributesFacade: executeIdentityAttributeQuery', () {
    test('should allow to execute an identityAttributeQuery', () async {
      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
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
    test('should allow to execute a RelationshipAttributeQuery', () async {
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
        [const AcceptRequestItemParameters()],
        eventBus,
      );

      final receivedAttributeResult = await recipient.consumptionServices.attributes.executeThirdPartyRelationshipAttributeQuery(
        query: ThirdPartyRelationshipAttributeQuery(
          key: 'website',
          owner: ThirdPartyRelationshipAttributeQueryOwner.thirdParty,
          thirdParty: [account1.address!],
        ),
      );

      expect(receivedAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(receivedAttributeResult.value.length, 1);
    });
  });

  group('AttributesFacade: executeIQLQuery', () {
    test('should allow to execute an IQLQuery', () async {
      await recipient.consumptionServices.attributes.createRepositoryAttribute(value: const SurnameAttributeValue(value: 'aSurname'));

      final receivedAttributeResult = await recipient.consumptionServices.attributes.executeIQLQuery(query: const IQLQuery(queryString: 'Surname'));

      expect(receivedAttributeResult, isSuccessful<List<LocalAttributeDTO>>());
      expect(receivedAttributeResult.value.length, 1);

      expect(receivedAttributeResult.value.first.contentAsIdentityAttribute.value.atType, 'Surname');
    });
  });

  group('AttributesFacade: succeedRepositoryAttribute', () {
    test('should succeed an identity attribute', () async {
      final attributesResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const SurnameAttributeValue(value: 'aSurname'),
      );
      final attribute = attributesResult.value;

      final succeededAttributeResult = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: attribute.id,
        value: const SurnameAttributeValue(value: 'aNewSurname'),
      );
      final succeededAttribute = succeededAttributeResult.value;

      expect(succeededAttributeResult, isSuccessful<SucceedRepositoryAttributeResponse>());
      expect(succeededAttribute.successor.content.toJson()['@type'], 'IdentityAttribute');
      expect(succeededAttribute.successor.content.toJson()['value']['value'], 'aNewSurname');
      expect(succeededAttribute.predecessor.content.toJson()['value']['value'], attribute.content.toJson()['value']['value']);
    });

    test('should succeed an identity attribute with properties "tags", "validFrom" and "validTo"', () async {
      final attributesResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const SurnameAttributeValue(value: 'aSurname'),
      );
      final attribute = attributesResult.value;

      final succeededAttributeResult = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: attribute.id,
        value: const SurnameAttributeValue(value: 'aNewSurname'),
        tags: ['tag1', 'tag2', 'tag3'],
        validFrom: DateTime(2023).toRuntimeIsoString(),
        validTo: DateTime(2025).toRuntimeIsoString(),
      );
      final succeededAttribute = succeededAttributeResult.value;

      expect(succeededAttributeResult, isSuccessful<SucceedRepositoryAttributeResponse>());
      expect(succeededAttribute.successor.content.toJson()['@type'], 'IdentityAttribute');
      expect(succeededAttribute.successor.content.toJson()['value']['value'], 'aNewSurname');
      expect(succeededAttribute.successor.content.toJson()['tags'], ['tag1', 'tag2', 'tag3']);
      expect(succeededAttribute.successor.content.toJson()['validFrom'], DateTime(2023).toRuntimeIsoString());
      expect(succeededAttribute.successor.content.toJson()['validTo'], DateTime(2025).toRuntimeIsoString());
    });
  });

  group('AttributesFacade: shareRepositoryAttribute', () {
    test('should allow to share an attribute', () async {
      final recipientAddress = account2.address!;

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
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

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
        requestMetadata: (
          title: 'aRequestTitle',
          description: 'aRequestDescription',
          metadata: {'a': 'b'},
          expiresAt: null,
        ),
        requestItemMetadata: (
          title: 'aRequestItemTitle',
          description: 'aRequestItemDescription',
          metadata: null,
          requireManualDecision: null,
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
      expect(event.request.content.items.first.title, 'aRequestItemTitle');
      expect(event.request.content.items.first.description, 'aRequestItemDescription');
    });
  });

  group('AttributesFacade: notifyPeerAboutRepositoryAttributeSuccession', () {
    test('should successfully notify peer about attribute succession', () async {
      final recipientAddress = account2.address!;

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        shareAttributeResult.value,
        eventBus,
      );

      final succeededAttributeResult = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: identityAttribute.id,
        value: const PhoneNumberAttributeValue(value: '109876543210'),
      );
      final succeededAttribute = succeededAttributeResult.value;

      final notificationResult = await sender.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: succeededAttributeResult.value.successor.id,
        peer: recipientAddress,
      );
      final notification = notificationResult.value;

      expect(notificationResult, isSuccessful<NotifyPeerAboutRepositoryAttributeSuccessionResponse>());
      expect(notification.predecessor.content, succeededAttribute.predecessor.content);
      expect(notification.successor.content, succeededAttribute.successor.content);
    });
  });

  group('AttributesFacade: createAndShareRelationshipAttribute', () {
    test('should create and share relationship attribute', () async {
      final recipientAddress = account2.address!;
      final requestResult = await sender.consumptionServices.attributes.createAndShareRelationshipAttribute(
        value: const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue'),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        peer: recipientAddress,
      );
      final request = requestResult.value;

      expect(requestResult, isSuccessful<LocalRequestDTO>());
      expect(request.content.items.first.toJson()['attribute']['value']['@type'], 'ProprietaryString');
      expect(request.content.items.first.toJson()['attribute']['value']['title'], 'aTitle');
      expect(request.content.items.first.toJson()['attribute']['value']['value'], 'aValue');

      final attribute = await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        requestResult.value,
        eventBus,
      );

      expect(attribute.content.toJson()['value']['title'], 'aTitle');
      expect(attribute.content.toJson()['value']['value'], 'aValue');
    });

    test('should create and share relationship attribute with all properties', () async {
      final recipientAddress = account2.address!;
      final requestResult = await sender.consumptionServices.attributes.createAndShareRelationshipAttribute(
        value: const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
        peer: recipientAddress,
        isTechnical: true,
        validFrom: '2023',
        validTo: '2025',
        requestMetadata: (
          title: 'aRequestTitle',
          description: 'aRequestDescription',
          metadata: {'a': 'b'},
          expiresAt: null,
        ),
        requestItemMetadata: (
          title: 'aRequestItemTitle',
          description: 'aRequestItemDescription',
          metadata: null,
          requireManualDecision: null,
        ),
      );
      final request = requestResult.value;

      expect(requestResult, isSuccessful<LocalRequestDTO>());
      expect(request.content.items.first.toJson()['attribute']['value']['@type'], 'ProprietaryBoolean');
      expect(request.content.items.first.toJson()['attribute']['value']['title'], 'aTitle');
      expect(request.content.items.first.toJson()['attribute']['value']['value'], true);
      expect(request.content.items.first.title, 'aRequestItemTitle');
      expect(request.content.items.first.description, 'aRequestItemDescription');
      expect(request.content.metadata, {'a': 'b'});

      final attribute = await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        requestResult.value,
        eventBus,
      );

      expect(attribute.content.toJson()['value']['@type'], 'ProprietaryBoolean');
      expect(attribute.content.toJson()['value']['title'], 'aTitle');
      expect(attribute.content.toJson()['value']['value'], true);
    });
  });

  group('AttributesFacade: succeedRelationshipAttributeAndNotifyPeer', () {
    test('should succeed a relationship attribute and notify peer', () async {
      final recipientAddress = account2.address!;
      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');
      const succeededAttributeValue = ProprietaryStringAttributeValue(title: 'another title', value: 'another value');

      final senderOwnSharedAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        attributeValue,
        eventBus,
      );

      final result = await sender.consumptionServices.attributes.succeedRelationshipAttributeAndNotifyPeer(
        predecessorId: senderOwnSharedAttribute.id,
        value: succeededAttributeValue,
      );

      expect(result, isSuccessful<SucceedRelationshipAttributeAndNotifyPeerResponse>());

      await waitForRecipientToReceiveNotification(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        result.value.notificationId,
        result.value.successor.id,
        eventBus,
      );

      final senderPredecessor = result.value.predecessor;
      final senderSuccessor = result.value.successor;
      final recipientPredecessor = (await recipient.consumptionServices.attributes.getAttribute(attributeId: senderPredecessor.id)).value;
      final recipientSuccessor = (await recipient.consumptionServices.attributes.getAttribute(attributeId: senderSuccessor.id)).value;

      expect(senderSuccessor.content, recipientSuccessor.content);
      expect(senderSuccessor.shareInfo!.notificationReference, recipientSuccessor.shareInfo!.notificationReference);
      expect(senderSuccessor.shareInfo!.peer, recipientAddress);
      expect(recipientSuccessor.shareInfo!.peer, account1.address);
      expect(senderSuccessor.succeeds, senderPredecessor.id);
      expect(recipientSuccessor.succeeds, recipientPredecessor.id);
      expect(senderPredecessor.succeededBy, senderSuccessor.id);
      expect(recipientPredecessor.succeededBy, recipientSuccessor.id);
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('should succeed a relationship attribute and notify peer with all properties', () async {
      final recipientAddress = account2.address!;
      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');
      const succeededAttributeValue = ProprietaryStringAttributeValue(title: 'another title', value: 'another value');

      final senderOwnSharedAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        attributeValue,
        eventBus,
      );

      final result = await sender.consumptionServices.attributes.succeedRelationshipAttributeAndNotifyPeer(
        predecessorId: senderOwnSharedAttribute.id,
        value: succeededAttributeValue,
        validFrom: DateTime(2023).toRuntimeIsoString(),
        validTo: DateTime(2025).toRuntimeIsoString(),
      );

      expect(result, isSuccessful<SucceedRelationshipAttributeAndNotifyPeerResponse>());

      await syncUntilHasMessageWithNotification(recipient, result.value.notificationId);

      final senderPredecessor = result.value.predecessor;
      final senderSuccessor = result.value.successor;
      final recipientPredecessor = (await recipient.consumptionServices.attributes.getAttribute(attributeId: senderPredecessor.id)).value;
      final recipientSuccessor = (await recipient.consumptionServices.attributes.getAttribute(attributeId: senderSuccessor.id)).value;

      expect(senderSuccessor.content, recipientSuccessor.content);
      expect(senderSuccessor.shareInfo!.notificationReference, recipientSuccessor.shareInfo!.notificationReference);
      expect(senderSuccessor.shareInfo!.peer, recipientAddress);
      expect(recipientSuccessor.shareInfo!.peer, account1.address);
      expect(senderSuccessor.succeeds, senderPredecessor.id);
      expect(recipientSuccessor.succeeds, recipientPredecessor.id);
      expect(senderPredecessor.succeededBy, senderSuccessor.id);
      expect(recipientPredecessor.succeededBy, recipientSuccessor.id);
      expect(recipientSuccessor.content.toJson()['validFrom'], DateTime(2023).toRuntimeIsoString());
      expect(recipientSuccessor.content.toJson()['validTo'], DateTime(2025).toRuntimeIsoString());
    }, timeout: const Timeout(Duration(seconds: 60)));
  });

  group('AttributesFacade: changeDefaultRepositoryAttributes', () {
    test('should change default repository attributes', () async {
      final defaultAttribute = (await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'aDefaultGivenName'),
      ))
          .value;
      expect(defaultAttribute.isDefault, true);

      final desiredDefaultAttribute = (await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'aNewDefaultGivenName'),
      ))
          .value;
      expect(desiredDefaultAttribute.isDefault, null);

      final changeDefaultResult = await sender.consumptionServices.attributes.changeDefaultRepositoryAttribute(
        attributeId: desiredDefaultAttribute.id,
      );
      expect(changeDefaultResult, isSuccessful<LocalAttributeDTO>());

      expect(changeDefaultResult.value.id, desiredDefaultAttribute.id);
      expect(changeDefaultResult.value.isDefault, true);

      final updatedFormerDefaultAttribute = (await sender.consumptionServices.attributes.getAttribute(attributeId: defaultAttribute.id)).value;
      expect(updatedFormerDefaultAttribute.isDefault, null);
    });

    test('should change default repository attribute using succession', () async {
      final defaultAttribute = (await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'aDefaultGivenName'),
      ))
          .value;
      expect(defaultAttribute.isDefault, true);

      final otherAttributePredecessor = (await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const GivenNameAttributeValue(value: 'anotherGivenNamePredecessor'),
      ))
          .value;

      final successionResult = await sender.consumptionServices.attributes.succeedRepositoryAttribute(
        predecessorId: otherAttributePredecessor.id,
        value: const GivenNameAttributeValue(value: 'anotherGivenNameSuccessor'),
      );
      final updatedOtherAttributePredecessor = successionResult.value.predecessor;

      final changeDefaultResult =
          await sender.consumptionServices.attributes.changeDefaultRepositoryAttribute(attributeId: updatedOtherAttributePredecessor.id);
      expect(changeDefaultResult, isFailing('error.runtime.attributes.hasSuccessor'));
    });

    test('should return an error if the new default attribute is not a repository attributes', () async {
      final relationshipAttribute = await exchangeRelationshipAttribute(
        sender,
        recipient,
        const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString'),
      );

      final result = await sender.consumptionServices.attributes.changeDefaultRepositoryAttribute(attributeId: relationshipAttribute.id);
      expect(result, isFailing('error.runtime.attributes.isNotRepositoryAttribute'));
    });
  });

  group('AttributesFacade: deleteRepositoryAttribute', () {
    test('should delete a repository attribute', () async {
      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final deletionResult = await sender.consumptionServices.attributes.deleteRepositoryAttribute(attributeId: identityAttribute.id);
      expect(deletionResult, isSuccessful());
    });

    test('should return an error trying to delete an already deleted attribute', () async {
      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final successfulDeletionResult = await sender.consumptionServices.attributes.deleteRepositoryAttribute(attributeId: identityAttribute.id);
      expect(successfulDeletionResult, isSuccessful());

      final failingDeletionResult = await sender.consumptionServices.attributes.deleteRepositoryAttribute(attributeId: identityAttribute.id);
      expect(failingDeletionResult, isFailingVoidResult('error.runtime.recordNotFound'));
    });
  });

  group('AttributesFacade: deleteOwnSharedAttributeAndNotifyPeer', () {
    test('should delete an own shared identity attribute', () async {
      final recipientAddress = account2.address!;

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      final recipientPeerSharedIdentityAttribute = await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        shareAttributeResult.value,
        eventBus,
      );

      final senderOwnSharedIdentityAttribute =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: recipientPeerSharedIdentityAttribute.id)).value;

      final deletionResult =
          await sender.consumptionServices.attributes.deleteOwnSharedAttributeAndNotifyPeer(attributeId: senderOwnSharedIdentityAttribute.id);
      expect(deletionResult, isSuccessful<DeleteOwnSharedAttributeAndNotifyPeerResponse>());
    });

    test('should delete an own shared relationship attribute', () async {
      final recipientAddress = account2.address!;
      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final senderOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        attributeValue,
        eventBus,
      );

      final deletionResult =
          await sender.consumptionServices.attributes.deleteOwnSharedAttributeAndNotifyPeer(attributeId: senderOwnSharedRelationshipAttribute.id);
      expect(deletionResult, isSuccessful<DeleteOwnSharedAttributeAndNotifyPeerResponse>());
    });

    test('should set the deletionInfo of the peer`s attribute, deleting an own shared relationship attribute', () async {
      final recipientAddress = account2.address!;
      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final senderOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        attributeValue,
        eventBus,
      );

      final deletionResult =
          await sender.consumptionServices.attributes.deleteOwnSharedAttributeAndNotifyPeer(attributeId: senderOwnSharedRelationshipAttribute.id);
      final notificationId = deletionResult.value.notificationId;

      final timeBeforeUpdate = DateTime.now();
      await syncUntilHasMessageWithNotification(recipient, notificationId);
      await eventBus.waitForEvent<OwnSharedAttributeDeletedByOwnerEvent>(
          eventTargetAddress: recipientAddress, predicate: (e) => e.data.id == senderOwnSharedRelationshipAttribute.id);
      final timeAfterUpdate = DateTime.now();

      final recipientPeerSharedRelationshipAttribute =
          (await recipient.consumptionServices.attributes.getAttribute(attributeId: senderOwnSharedRelationshipAttribute.id)).value;
      expect(recipientPeerSharedRelationshipAttribute.deletionInfo!.deletionStatus, LocalAttributeDeletionStatus.DeletedByOwner);
      expect(DateTime.parse(recipientPeerSharedRelationshipAttribute.deletionInfo!.deletionDate).isAfter(timeBeforeUpdate), true);
      expect(DateTime.parse(recipientPeerSharedRelationshipAttribute.deletionInfo!.deletionDate).isBefore(timeAfterUpdate), true);
    });
  });

  group('AttributesFacade: deletePeerSharedAttributeAndNotifyOwner', () {
    test('should delete a peer shared identity attribute', () async {
      final recipientAddress = account2.address!;

      final identityAttributeResult = await sender.consumptionServices.attributes.createRepositoryAttribute(
        value: const PhoneNumberAttributeValue(value: '012345678910'),
      );
      final identityAttribute = identityAttributeResult.value;

      final shareAttributeResult = await sender.consumptionServices.attributes.shareRepositoryAttribute(
        attributeId: identityAttribute.id,
        peer: recipientAddress,
      );

      final recipientPeerSharedIdentityAttribute = await acceptIncomingShareAttributeRequest(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        shareAttributeResult.value,
        eventBus,
      );

      final deletionResult = await recipient.consumptionServices.attributes
          .deletePeerSharedAttributeAndNotifyOwner(attributeId: recipientPeerSharedIdentityAttribute.id);
      expect(deletionResult, isSuccessful<DeletePeerSharedAttributeAndNotifyOwnerResponse>());
    });

    test('should delete a peer shared relationship attribute', () async {
      final recipientAddress = account2.address!;
      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final senderOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        sender,
        recipient,
        account1.address!,
        recipientAddress,
        attributeValue,
        eventBus,
      );

      final recipientOwnSharedRelationshipAttribute =
          (await recipient.consumptionServices.attributes.getAttribute(attributeId: senderOwnSharedRelationshipAttribute.id)).value;

      final deletionResult = await recipient.consumptionServices.attributes
          .deletePeerSharedAttributeAndNotifyOwner(attributeId: recipientOwnSharedRelationshipAttribute.id);
      expect(deletionResult, isSuccessful<DeletePeerSharedAttributeAndNotifyOwnerResponse>());
    });

    test('should set the deletionInfo of the owner`s attribute, deleting a peer shared relationship attribute', () async {
      final senderAddress = account1.address!;
      final recipientAddress = account2.address!;
      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final senderOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        sender,
        recipient,
        senderAddress,
        recipientAddress,
        attributeValue,
        eventBus,
      );

      final deletionResult = await recipient.consumptionServices.attributes
          .deletePeerSharedAttributeAndNotifyOwner(attributeId: senderOwnSharedRelationshipAttribute.id);
      final notificationId = deletionResult.value.notificationId;

      final timeBeforeUpdate = DateTime.now();
      await syncUntilHasMessageWithNotification(sender, notificationId);
      await eventBus.waitForEvent<PeerSharedAttributeDeletedByPeerEvent>(
          eventTargetAddress: senderAddress, predicate: (e) => e.data.id == senderOwnSharedRelationshipAttribute.id);
      final timeAfterUpdate = DateTime.now();

      final updatedSenderOwnSharedRelationshipAttribute =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: senderOwnSharedRelationshipAttribute.id)).value;
      expect(updatedSenderOwnSharedRelationshipAttribute.deletionInfo!.deletionStatus, LocalAttributeDeletionStatus.DeletedByPeer);
      expect(DateTime.parse(updatedSenderOwnSharedRelationshipAttribute.deletionInfo!.deletionDate).isAfter(timeBeforeUpdate), true);
      expect(DateTime.parse(updatedSenderOwnSharedRelationshipAttribute.deletionInfo!.deletionDate).isBefore(timeAfterUpdate), true);
    });
  });

  group('AttributesFacade: deleteThirdPartyOwnedRelationshipAttributeAndNotifyPeer', () {
    test('should delete a third party owned relationship attribute as the sender of it', () async {
      final senderAddress = account1.address!;
      final recipientAddress = account2.address!;
      final thirdPartyAddress = account3.address!;

      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final thirdPartyOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        thirdParty,
        sender,
        account3.address!,
        senderAddress,
        attributeValue,
        eventBus,
      );

      final senderOwnSharedRelationshipAttribute =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: thirdPartyOwnSharedRelationshipAttribute.id)).value;

      final query = ThirdPartyRelationshipAttributeQuery(
        key: 'aKey',
        owner: ThirdPartyRelationshipAttributeQueryOwner.thirdParty,
        thirdParty: [thirdPartyAddress],
      );
      final requestItem = ReadAttributeRequestItem(mustBeAccepted: true, query: query);

      final senderThirdPartyOwnedRelationshipAttribute = await executeFullRequestAndShareThirdPartyRelationshipAttributeFlow(
          sender, recipient, senderAddress, recipientAddress, thirdPartyAddress, requestItem, senderOwnSharedRelationshipAttribute.id, eventBus);

      final deletionResult = await sender.consumptionServices.attributes
          .deleteThirdPartyOwnedRelationshipAttributeAndNotifyPeer(attributeId: senderThirdPartyOwnedRelationshipAttribute.id);
      expect(deletionResult, isSuccessful<DeleteThirdPartyOwnedRelationshipAttributeAndNotifyPeerResponse>());
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('should delete a third party owned relationship attribute as the recipient of it', () async {
      final senderAddress = account1.address!;
      final recipientAddress = account2.address!;
      final thirdPartyAddress = account3.address!;

      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final thirdPartyOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        thirdParty,
        sender,
        account3.address!,
        senderAddress,
        attributeValue,
        eventBus,
      );

      final senderOwnSharedRelationshipAttribute =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: thirdPartyOwnSharedRelationshipAttribute.id)).value;

      final query = ThirdPartyRelationshipAttributeQuery(
        key: 'aKey',
        owner: ThirdPartyRelationshipAttributeQueryOwner.thirdParty,
        thirdParty: [thirdPartyAddress],
      );
      final requestItem = ReadAttributeRequestItem(mustBeAccepted: true, query: query);

      final senderThirdPartyOwnedRelationshipAttribute = await executeFullRequestAndShareThirdPartyRelationshipAttributeFlow(
          sender, recipient, senderAddress, recipientAddress, thirdPartyAddress, requestItem, senderOwnSharedRelationshipAttribute.id, eventBus);

      final recipientThirdPartyOwnedRelationshipAttribute =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: senderThirdPartyOwnedRelationshipAttribute.id)).value;

      final deletionResult = await recipient.consumptionServices.attributes
          .deleteThirdPartyOwnedRelationshipAttributeAndNotifyPeer(attributeId: recipientThirdPartyOwnedRelationshipAttribute.id);
      expect(deletionResult, isSuccessful<DeleteThirdPartyOwnedRelationshipAttributeAndNotifyPeerResponse>());
    });

    test('should set the deletionInfo of the peer`s attribute, deleting a third party owned relationship attribute as the sender of it', () async {
      final senderAddress = account1.address!;
      final recipientAddress = account2.address!;
      final thirdPartyAddress = account3.address!;

      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final thirdPartyOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        thirdParty,
        sender,
        account3.address!,
        senderAddress,
        attributeValue,
        eventBus,
      );

      final senderOwnSharedRelationshipAttribute =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: thirdPartyOwnSharedRelationshipAttribute.id)).value;

      final query = ThirdPartyRelationshipAttributeQuery(
        key: 'aKey',
        owner: ThirdPartyRelationshipAttributeQueryOwner.thirdParty,
        thirdParty: [thirdPartyAddress],
      );
      final requestItem = ReadAttributeRequestItem(mustBeAccepted: true, query: query);

      final senderThirdPartyOwnedRelationshipAttribute = await executeFullRequestAndShareThirdPartyRelationshipAttributeFlow(
          sender, recipient, senderAddress, recipientAddress, thirdPartyAddress, requestItem, senderOwnSharedRelationshipAttribute.id, eventBus);

      final deletionResult = await sender.consumptionServices.attributes
          .deleteThirdPartyOwnedRelationshipAttributeAndNotifyPeer(attributeId: senderThirdPartyOwnedRelationshipAttribute.id);
      expect(deletionResult, isSuccessful<DeleteThirdPartyOwnedRelationshipAttributeAndNotifyPeerResponse>());
      final notificationId = deletionResult.value.notificationId;

      final timeBeforeUpdate = DateTime.now();
      await syncUntilHasMessageWithNotification(recipient, notificationId);
      await eventBus.waitForEvent<ThirdPartyOwnedRelationshipAttributeDeletedByPeerEvent>(
          eventTargetAddress: recipientAddress, predicate: (e) => e.data.id == senderThirdPartyOwnedRelationshipAttribute.id);
      final timeAfterUpdate = DateTime.now();

      final recipientThirdPartyOwnedRelationshipAttribute =
          (await recipient.consumptionServices.attributes.getAttribute(attributeId: senderThirdPartyOwnedRelationshipAttribute.id)).value;
      expect(recipientThirdPartyOwnedRelationshipAttribute.deletionInfo!.deletionStatus, LocalAttributeDeletionStatus.DeletedByPeer);
      expect(DateTime.parse(recipientThirdPartyOwnedRelationshipAttribute.deletionInfo!.deletionDate).isAfter(timeBeforeUpdate), true);
      expect(DateTime.parse(recipientThirdPartyOwnedRelationshipAttribute.deletionInfo!.deletionDate).isBefore(timeAfterUpdate), true);
    });

    test('should set the deletionInfo of the peer`s attribute, deleting a third party owned relationship attribute as the recipient of it', () async {
      final senderAddress = account1.address!;
      final recipientAddress = account2.address!;
      final thirdPartyAddress = account3.address!;

      const attributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aValue');

      final thirdPartyOwnSharedRelationshipAttribute = await executeFullCreateAndShareRelationshipAttributeFlow(
        thirdParty,
        sender,
        account3.address!,
        senderAddress,
        attributeValue,
        eventBus,
      );

      final senderOwnSharedRelationshipAttribute =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: thirdPartyOwnSharedRelationshipAttribute.id)).value;

      final query = ThirdPartyRelationshipAttributeQuery(
        key: 'aKey',
        owner: ThirdPartyRelationshipAttributeQueryOwner.thirdParty,
        thirdParty: [thirdPartyAddress],
      );
      final requestItem = ReadAttributeRequestItem(mustBeAccepted: true, query: query);

      final senderThirdPartyOwnedRelationshipAttribute = await executeFullRequestAndShareThirdPartyRelationshipAttributeFlow(
          sender, recipient, senderAddress, recipientAddress, thirdPartyAddress, requestItem, senderOwnSharedRelationshipAttribute.id, eventBus);

      final deletionResult = await recipient.consumptionServices.attributes
          .deleteThirdPartyOwnedRelationshipAttributeAndNotifyPeer(attributeId: senderThirdPartyOwnedRelationshipAttribute.id);
      final notificationId = deletionResult.value.notificationId;

      final timeBeforeUpdate = DateTime.now();
      await syncUntilHasMessageWithNotification(sender, notificationId);
      await eventBus.waitForEvent<ThirdPartyOwnedRelationshipAttributeDeletedByPeerEvent>(
          eventTargetAddress: senderAddress, predicate: (e) => e.data.id == senderThirdPartyOwnedRelationshipAttribute.id);
      final timeAfterUpdate = DateTime.now();

      final updatedSenderThirdPartyOwnedRelationshipAttribute =
          (await sender.consumptionServices.attributes.getAttribute(attributeId: senderThirdPartyOwnedRelationshipAttribute.id)).value;
      expect(updatedSenderThirdPartyOwnedRelationshipAttribute.deletionInfo!.deletionStatus, LocalAttributeDeletionStatus.DeletedByPeer);
      expect(DateTime.parse(updatedSenderThirdPartyOwnedRelationshipAttribute.deletionInfo!.deletionDate).isAfter(timeBeforeUpdate), true);
      expect(DateTime.parse(updatedSenderThirdPartyOwnedRelationshipAttribute.deletionInfo!.deletionDate).isBefore(timeAfterUpdate), true);
    }, timeout: const Timeout(Duration(seconds: 60)));
  });
}
