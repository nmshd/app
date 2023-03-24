import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart' hide State;

class IncomingRequestsFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const IncomingRequestsFacadeView({super.key, required this.runtime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();
              final currentIdentityAddress = identityInfo.address;

              final requestToDecide = await getDecidableRequest();
              if (requestToDecide == null) return;

              final result = await runtime.currentSession.consumptionServices.incomingRequests.canAccept(
                params: DecideRequestParameters(
                  requestId: requestToDecide.id,
                  items: generateAcceptItems(requestToDecide.content.items, currentIdentityAddress),
                ),
              );
              print(result);
            },
            child: const Text('canAccept'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();
              final currentIdentityAddress = identityInfo.address;

              final requestToDecide = await getDecidableRequest();
              if (requestToDecide == null) return;

              final request = await runtime.currentSession.consumptionServices.incomingRequests.accept(
                params: DecideRequestParameters(
                  requestId: requestToDecide.id,
                  items: generateAcceptItems(requestToDecide.content.items, currentIdentityAddress),
                ),
              );
              print(request);
            },
            child: const Text('accept'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final requestToDecide = await getDecidableRequest();
              if (requestToDecide == null) return;

              final validationResult = await runtime.currentSession.consumptionServices.incomingRequests.canReject(
                params: DecideRequestParameters(
                  requestId: requestToDecide.id,
                  items: generateRejectItems(requestToDecide.content.items),
                ),
              );
              print(validationResult);
            },
            child: const Text('canReject'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final requestToDecide = await getDecidableRequest();
              if (requestToDecide == null) return;

              final decidedRequest = await runtime.currentSession.consumptionServices.incomingRequests.reject(
                params: DecideRequestParameters(
                  requestId: requestToDecide.id,
                  items: generateRejectItems(requestToDecide.content.items),
                ),
              );
              print(decidedRequest);
            },
            child: const Text('reject'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final requests = await runtime.currentSession.consumptionServices.incomingRequests.getRequests();
              if (requests.isEmpty) return;

              final request = await runtime.currentSession.consumptionServices.incomingRequests.getRequest(
                requestId: requests.first.id,
              );
              print(request);
            },
            child: const Text('getRequest'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await runtime.currentSession.transportServices.accounts.syncEverything();

              final requests = await runtime.currentSession.consumptionServices.incomingRequests.getRequests(query: {
                'status': LocalRequestStatus.ManualDecisionRequired.asQueryValue,
              });

              if (requests.isEmpty) {
                print('There are no open requests');
                return;
              }

              print('---${requests.length}---');
              for (final request in requests) {
                print(request);
                print('---');
              }
            },
            child: const Text('getRequests'),
          ),
        ],
      ),
    );
  }

  List<DecideRequestParametersItem> generateRejectItems(List<RequestItem> items) => items.map((e) {
        if (e is RequestItemGroup) {
          return DecideRequestItemGroupParameters(items: e.items.map((itemDerivation) => RejectRequestItemParameters()).toList());
        }

        return RejectRequestItemParameters();
      }).toList();

  List<DecideRequestParametersItem> generateAcceptItems(List<RequestItem> items, String currentIdentityAddress) => items
      .map((e) => e is RequestItemGroup
          ? DecideRequestItemGroupParameters(
              items: e.items.map((item) => generateAcceptItem(item, currentIdentityAddress)).toList(),
            )
          : generateAcceptItem(e as RequestItemDerivation, currentIdentityAddress))
      .toList();

  AcceptRequestItemParameters generateAcceptItem(RequestItemDerivation requestItem, String currentIdentityAddress) {
    switch (requestItem.runtimeType) {
      case ReadAttributeRequestItem:
        return generateAcceptReadAttributeRequestItemParametersWithNewAttribute(requestItem as ReadAttributeRequestItem, currentIdentityAddress);
      case CreateAttributeRequestItem:
        return AcceptRequestItemParameters();

      case ShareAttributeRequestItem:
        return AcceptRequestItemParameters();

      case ProposeAttributeRequestItem:
        return AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: (requestItem as ProposeAttributeRequestItem).attribute);

      case ConsentRequestItem:
        return AcceptRequestItemParameters();

      case AuthenticationRequestItem:
        return AcceptRequestItemParameters();

      case RegisterAttributeListenerRequestItem:
        return AcceptRequestItemParameters();

      case SucceedAttributeRequestItem:
        // not implemented in the runtime
        throw UnimplementedError();

      default:
        throw UnimplementedError();
    }
  }

  AcceptRequestItemParameters generateAcceptReadAttributeRequestItemParametersWithNewAttribute(
    ReadAttributeRequestItem requestItem,
    String currentIdentityAddress,
  ) {
    switch (requestItem.query.runtimeType) {
      case IdentityAttributeQuery:
        return AcceptReadAttributeRequestItemParametersWithNewAttribute(
          newAttribute: generateIdentityAtrribute(requestItem.query as IdentityAttributeQuery, currentIdentityAddress),
        );
      case RelationshipAttributeQuery:
        return AcceptReadAttributeRequestItemParametersWithNewAttribute(
          newAttribute: generateRelationshipAtrribute(requestItem.query as RelationshipAttributeQuery, currentIdentityAddress),
        );
      case ThirdPartyRelationshipAttributeQuery:
        throw UnimplementedError();
      default:
        throw UnimplementedError();
    }
  }

  IdentityAttribute generateIdentityAtrribute(IdentityAttributeQuery query, String currentIdentityAddress) {
    final type = query.valueType;
    switch (type) {
      case 'AffiliationOrganization':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: AffiliationOrganization(value: 'Test$type'),
        );
      case 'AffiliationRole':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: AffiliationRole(value: 'Test$type'),
        );
      case 'AffiliationUnit':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: AffiliationUnit(value: 'Test$type'),
        );
      case 'BirthCity':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: BirthCity(value: 'Test$type'),
        );
      case 'BirthName':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: BirthName(value: 'Test$type'),
        );
      case 'BirthState':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: BirthState(value: 'Test$type'),
        );
      case 'City':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: City(value: 'Test$type'),
        );
      case 'DisplayName':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: DisplayName(value: 'Test$type'),
        );
      case 'FileReference':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: FileReference(value: 'Test${type}WithMinimunLengthOf30'),
        );
      case 'GivenName':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: GivenName(value: 'Test$type'),
        );
      case 'HonorificPrefix':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: HonorificPrefix(value: 'Test$type'),
        );
      case 'HonorificSuffix':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: HonorificSuffix(value: 'Test$type'),
        );
      case 'HouseNumber':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: HouseNumber(value: 'Test$type'),
        );
      case 'JobTitle':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: JobTitle(value: 'Test$type'),
        );
      case 'MiddleName':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: MiddleName(value: 'Test$type'),
        );
      case 'PhoneNumber':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: PhoneNumber(value: 'Test$type'),
        );
      case 'Pseudonym':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: Pseudonym(value: 'Test$type'),
        );
      case 'State':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: State(value: 'Test$type'),
        );
      case 'Street':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: Street(value: 'Test$type'),
        );
      case 'Surname':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: Surname(value: 'Test$type'),
        );
      case 'ZipCode':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: ZipCode(value: 'Test$type'),
        );
      case 'Affiliation':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const Affiliation(role: 'TestRole', organization: 'TestOrganization', unit: 'TestUnit'),
        );
      case 'BirthCountry':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthCountry(value: 'DE'),
        );
      case 'BirthDate':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthDate(day: 1, month: 1, year: 2000),
        );
      case 'BirthDay':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthDay(value: 5),
        );
      case 'BirthMonth':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthMonth(value: 5),
        );
      case 'BirthPlace':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthPlace(city: 'TestCity', country: 'DE'),
        );
      case 'BirthYear':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthYear(value: 2000),
        );
      case 'Citizenship':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const Citizenship(value: 'DE'),
        );
      case 'CommunicationLanguage':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const CommunicationLanguage(value: 'de'),
        );
      case 'Country':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const Country(value: 'DE'),
        );
      case 'DeliveryBoxAddress':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const DeliveryBoxAddress(
            recipient: 'recipient',
            deliveryBoxId: 'deliveryBoxId',
            userId: 'userId',
            zipCode: 'zipCode',
            city: 'city',
            country: 'country',
            phoneNumber: 'phoneNumber',
            state: 'state',
          ),
        );
      case 'EMailAddress':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const EMailAddress(value: 'test@test.com'),
        );
      case 'FaxNumber':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const FaxNumber(value: '123456789'),
        );
      case 'Nationality':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const Nationality(value: 'DE'),
        );
      case 'PersonName':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const PersonName(
            givenName: 'givenName',
            surname: 'surname',
            honorificPrefix: 'honorificPrefix',
            honorificSuffix: 'honorificSuffix',
            middleName: 'middleName',
          ),
        );
      case 'PostOfficeBoxAddress':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const PostOfficeBoxAddress(
            recipient: 'recipient',
            boxId: 'boxId',
            zipCode: 'zipCode',
            city: 'city',
            country: 'DE',
            state: 'state',
          ),
        );
      case 'Sex':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const Sex(value: 'male'),
        );
      case 'StreetAddress':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const StreetAddress(
            recipient: 'recipient',
            street: 'street',
            houseNumber: 'houseNumber',
            zipCode: 'zipCode',
            city: 'city',
            country: 'country',
            state: 'state',
          ),
        );
      case 'Website':
        return IdentityAttribute(
          owner: currentIdentityAddress,
          value: const Website(value: 'www.testwebsite.com'),
        );
      default:
        throw UnimplementedError();
    }
  }

  RelationshipAttribute generateRelationshipAtrribute(RelationshipAttributeQuery query, String currentIdentityAddress) {
    final type = query.attributeCreationHints.valueType;
    switch (type) {
      case 'Consent':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: Consent(consent: 'TestConsent'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryBoolean':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryBoolean(title: 'atitle', value: true),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryCountry':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryCountry(title: 'atitle', value: 'DE'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryEMailAddress':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryEMailAddress(title: 'atitle', value: 'test@test.com'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryFileReference':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryFileReference(title: 'atitle', value: 'fileReference'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryFloat':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryFloat(title: 'atitle', value: 25.5),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryHEXColor':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryHEXColor(title: 'aTitle', value: '3d6dba'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryInteger':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryInteger(title: 'atitle', value: 5),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryJSON':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryJSON(
            title: 'atitle',
            value: {
              'foo': 'bar',
              'baz': 123,
              'qux': true,
              'quux': {'corge': 'grault'},
              'garply': ['waldo', 'fred', 'plugh'],
            },
          ),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryLanguage':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryLanguage(title: 'atitle', value: 'de'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryPhoneNumber':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryPhoneNumber(title: 'atitle', value: '123456789'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryString':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryString(title: 'atitle', value: 'propString'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryURL':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: ProprietaryURL(title: 'atitle', value: 'www.google.com'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      default:
        throw UnimplementedError();
    }
  }

  Future<LocalRequestDTO?> getDecidableRequest() async {
    final requests = await runtime.currentSession.consumptionServices.incomingRequests.getRequests(query: {
      'status': LocalRequestStatus.ManualDecisionRequired.asQueryValue,
    });
    if (requests.isEmpty) return null;

    return requests.last;
  }
}
