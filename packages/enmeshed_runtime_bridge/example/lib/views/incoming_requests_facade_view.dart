import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

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
    if (type == 'AffiliationOrganization' ||
        type == 'AffiliationRole' ||
        type == 'AffiliationUnit' ||
        type == 'BirthCity' ||
        type == 'BirthName' ||
        type == 'BirthState' ||
        type == 'City' ||
        type == 'DisplayName' ||
        type == 'FileReference' ||
        type == 'GivenName' ||
        type == 'HonorificPrefix' ||
        type == 'HonorificSuffix' ||
        type == 'HouseNumber' ||
        type == 'JobTitle' ||
        type == 'MiddleName' ||
        type == 'PhoneNumber' ||
        type == 'Pseudonym' ||
        type == 'State' ||
        type == 'Street' ||
        type == 'Surname' ||
        type == 'ZipCode') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'Test$type',
        },
      );
    } else if (type == 'Affiliation') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'role': 'TestRole',
          'organization': 'TestOrganization',
          'unit': 'TestUnit',
        },
      );
    } else if (type == 'BirthCountry') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'DE',
        },
      );
    } else if (type == 'BirthDate') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'day': 1,
          'month': 1,
          'year': 2000,
        },
      );
    } else if (type == 'BirthDay') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 5,
        },
      );
    } else if (type == 'BirthMonth') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 5,
        },
      );
    } else if (type == 'BirthPlace') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'city': 'TestCity',
          'country': 'DE',
        },
      );
    } else if (type == 'BirthYear') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 2000,
        },
      );
    } else if (type == 'Citizenship') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'DE',
        },
      );
    } else if (type == 'CommunicationLanguage') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'de',
        },
      );
    } else if (type == 'Country') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'DE',
        },
      );
    } else if (type == 'DeliveryBoxAddress') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'recipient': 'TestRecipient',
          'deliveryBoxId': 'TestDeliveryBoxId',
          'userId': 'TestUserId',
          'zipCode': 'TestZipCode',
          'city': 'TestCity',
          'country': 'DE',
        },
      );
    } else if (type == 'EMailAddress') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'test@test.com',
        },
      );
    } else if (type == 'FaxNumber') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': '123456789',
        },
      );
    } else if (type == 'Nationality') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'DE',
        },
      );
    } else if (type == 'PersonName') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'givenName': 'TestGivenName',
          'surname': 'TestSurname',
        },
      );
    } else if (type == 'PostOfficeBoxAddress') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'recipient': 'TestRecipient',
          'boxId': 'TestBoxId',
          'zipCode': 'TestZipCode',
          'city': 'TestCity',
          'country': 'DE',
        },
      );
    } else if (type == 'Sex') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'male',
        },
      );
    } else if (type == 'StreetAddress') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'recipient': 'TestRecipient',
          'street': 'TestStreet',
          'houseNo': 'TestHouseNumber',
          'zipCode': 'TestZipCode',
          'city': 'TestCity',
          'country': 'DE',
          'state': 'TestState',
        },
      );
    } else if (type == 'Website') {
      return IdentityAttribute(
        owner: currentIdentityAddress,
        value: {
          '@type': type,
          'value': 'www.testwebsite.com',
        },
      );
    } else {
      throw UnimplementedError();
    }
  }

  RelationshipAttribute generateRelationshipAtrribute(RelationshipAttributeQuery query, String currentIdentityAddress) {
    final type = query.attributeCreationHints.valueType;
    switch (type) {
      case 'Consent':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'Consent', 'consent': 'testConsent'},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryBoolean':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'value': true},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryCountry':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryCountry', 'title': 'aTitle', 'value': 'DE'},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryEMailAddress':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'value': 'test@test.com'},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryFileReference':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryFileReference', 'title': 'aTitle', 'value': 'fileReference'},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryFloat':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryFloat', 'title': 'aTitle', 'value': 25.5},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryHEXColor':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'value': '#3d6dba'},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryInteger':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryInteger', 'title': 'aTitle', 'value': 1},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryJSON':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {
            '@type': 'ProprietaryJSON',
            'title': 'aTitle',
            'value': {
              'foo': 'bar',
              'baz': 123,
              'qux': true,
              'quux': {'corge': 'grault'},
              'garply': ['waldo', 'fred', 'plugh'],
            },
          },
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryLanguage':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'value': 'de'},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryPhoneNumber':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'value': '123456789'},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryString':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryString', 'title': 'aTitle', 'value': 'propString'},
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryURL':
        return RelationshipAttribute(
          owner: currentIdentityAddress,
          value: {'@type': 'ProprietaryURL', 'title': 'aTitle', 'value': 'www.google.com'},
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
