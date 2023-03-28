import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart' as types;
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
                params: types.DecideRequestParameters(
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
                params: types.DecideRequestParameters(
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
                params: types.DecideRequestParameters(
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
                params: types.DecideRequestParameters(
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
                'status': types.LocalRequestStatus.ManualDecisionRequired.asQueryValue,
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

  List<types.DecideRequestParametersItem> generateRejectItems(List<types.RequestItem> items) => items.map((e) {
        if (e is types.RequestItemGroup) {
          return types.DecideRequestItemGroupParameters(items: e.items.map((itemDerivation) => types.RejectRequestItemParameters()).toList());
        }

        return types.RejectRequestItemParameters();
      }).toList();

  List<types.DecideRequestParametersItem> generateAcceptItems(List<types.RequestItem> items, String currentIdentityAddress) => items
      .map((e) => e is types.RequestItemGroup
          ? types.DecideRequestItemGroupParameters(
              items: e.items.map((item) => generateAcceptItem(item, currentIdentityAddress)).toList(),
            )
          : generateAcceptItem(e as types.RequestItemDerivation, currentIdentityAddress))
      .toList();

  types.AcceptRequestItemParameters generateAcceptItem(types.RequestItemDerivation requestItem, String currentIdentityAddress) {
    switch (requestItem.runtimeType) {
      case types.ReadAttributeRequestItem:
        return generateAcceptReadAttributeRequestItemParametersWithNewAttribute(
          requestItem as types.ReadAttributeRequestItem,
          currentIdentityAddress,
        );
      case types.CreateAttributeRequestItem:
        return types.AcceptRequestItemParameters();

      case types.ShareAttributeRequestItem:
        return types.AcceptRequestItemParameters();

      case types.ProposeAttributeRequestItem:
        return types.AcceptProposeAttributeRequestItemParametersWithNewAttribute(
          attribute: (requestItem as types.ProposeAttributeRequestItem).attribute,
        );

      case types.ConsentRequestItem:
        return types.AcceptRequestItemParameters();

      case types.AuthenticationRequestItem:
        return types.AcceptRequestItemParameters();

      case types.RegisterAttributeListenerRequestItem:
        return types.AcceptRequestItemParameters();

      case types.SucceedAttributeRequestItem:
        // not implemented in the runtime
        throw UnimplementedError();

      default:
        throw UnimplementedError();
    }
  }

  types.AcceptRequestItemParameters generateAcceptReadAttributeRequestItemParametersWithNewAttribute(
    types.ReadAttributeRequestItem requestItem,
    String currentIdentityAddress,
  ) {
    switch (requestItem.query.runtimeType) {
      case types.IdentityAttributeQuery:
        return types.AcceptReadAttributeRequestItemParametersWithNewAttribute(
          newAttribute: generateIdentityAtrribute(requestItem.query as types.IdentityAttributeQuery, currentIdentityAddress),
        );
      case types.RelationshipAttributeQuery:
        return types.AcceptReadAttributeRequestItemParametersWithNewAttribute(
          newAttribute: generateRelationshipAtrribute(requestItem.query as types.RelationshipAttributeQuery, currentIdentityAddress),
        );
      case types.ThirdPartyRelationshipAttributeQuery:
        throw UnimplementedError();
      default:
        throw UnimplementedError();
    }
  }

  types.IdentityAttribute generateIdentityAtrribute(types.IdentityAttributeQuery query, String currentIdentityAddress) {
    final type = query.valueType;
    switch (type) {
      case 'AffiliationOrganization':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.AffiliationOrganization(value: 'Test$type'),
        );
      case 'AffiliationRole':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.AffiliationRole(value: 'Test$type'),
        );
      case 'AffiliationUnit':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.AffiliationUnit(value: 'Test$type'),
        );
      case 'BirthCity':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.BirthCity(value: 'Test$type'),
        );
      case 'BirthName':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.BirthName(value: 'Test$type'),
        );
      case 'BirthState':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.BirthState(value: 'Test$type'),
        );
      case 'City':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.City(value: 'Test$type'),
        );
      case 'DisplayName':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.DisplayName(value: 'Test$type'),
        );
      case 'FileReference':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.FileReference(value: 'Test${type}WithMinimunLengthOf30'),
        );
      case 'GivenName':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.GivenName(value: 'Test$type'),
        );
      case 'HonorificPrefix':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.HonorificPrefix(value: 'Test$type'),
        );
      case 'HonorificSuffix':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.HonorificSuffix(value: 'Test$type'),
        );
      case 'HouseNumber':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.HouseNumber(value: 'Test$type'),
        );
      case 'JobTitle':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.JobTitle(value: 'Test$type'),
        );
      case 'MiddleName':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.MiddleName(value: 'Test$type'),
        );
      case 'PhoneNumber':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.PhoneNumber(value: 'Test$type'),
        );
      case 'Pseudonym':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.Pseudonym(value: 'Test$type'),
        );
      case 'State':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.State(value: 'Test$type'),
        );
      case 'Street':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.Street(value: 'Test$type'),
        );
      case 'Surname':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.Surname(value: 'Test$type'),
        );
      case 'ZipCode':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: types.ZipCode(value: 'Test$type'),
        );
      case 'Affiliation':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.Affiliation(role: 'TestRole', organization: 'TestOrganization', unit: 'TestUnit'),
        );
      case 'BirthCountry':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.BirthCountry(value: 'DE'),
        );
      case 'BirthDate':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.BirthDate(day: 1, month: 1, year: 2000),
        );
      case 'BirthDay':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.BirthDay(value: 5),
        );
      case 'BirthMonth':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.BirthMonth(value: 5),
        );
      case 'BirthPlace':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.BirthPlace(city: 'TestCity', country: 'DE'),
        );
      case 'BirthYear':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.BirthYear(value: 2000),
        );
      case 'Citizenship':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.Citizenship(value: 'DE'),
        );
      case 'CommunicationLanguage':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.CommunicationLanguage(value: 'de'),
        );
      case 'Country':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.Country(value: 'DE'),
        );
      case 'DeliveryBoxAddress':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.DeliveryBoxAddress(
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
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.EMailAddress(value: 'test@test.com'),
        );
      case 'FaxNumber':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.FaxNumber(value: '123456789'),
        );
      case 'Nationality':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.Nationality(value: 'DE'),
        );
      case 'PersonName':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.PersonName(
            givenName: 'givenName',
            surname: 'surname',
            honorificPrefix: 'honorificPrefix',
            honorificSuffix: 'honorificSuffix',
            middleName: 'middleName',
          ),
        );
      case 'PostOfficeBoxAddress':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.PostOfficeBoxAddress(
            recipient: 'recipient',
            boxId: 'boxId',
            zipCode: 'zipCode',
            city: 'city',
            country: 'DE',
            state: 'state',
          ),
        );
      case 'Sex':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.Sex(value: 'male'),
        );
      case 'StreetAddress':
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.StreetAddress(
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
        return types.IdentityAttribute(
          owner: currentIdentityAddress,
          value: const types.Website(value: 'www.testwebsite.com'),
        );
      default:
        throw UnimplementedError();
    }
  }

  types.RelationshipAttribute generateRelationshipAtrribute(types.RelationshipAttributeQuery query, String currentIdentityAddress) {
    final type = query.attributeCreationHints.valueType;
    switch (type) {
      case 'Consent':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.Consent(consent: 'TestConsent'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryBoolean':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryBoolean(title: 'atitle', value: true),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryCountry':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryCountry(title: 'atitle', value: 'DE'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryEMailAddress':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryEMailAddress(title: 'atitle', value: 'test@test.com'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryFileReference':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryFileReference(title: 'atitle', value: 'fileReference'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryFloat':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryFloat(title: 'atitle', value: 25.5),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryHEXColor':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryHEXColor(title: 'aTitle', value: '3d6dba'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryInteger':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryInteger(title: 'atitle', value: 5),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryJSON':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryJSON(
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
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryLanguage':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryLanguage(title: 'atitle', value: 'de'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryPhoneNumber':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryPhoneNumber(title: 'atitle', value: '123456789'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryString':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryString(title: 'atitle', value: 'propString'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      case 'ProprietaryURL':
        return types.RelationshipAttribute(
          owner: currentIdentityAddress,
          value: types.ProprietaryURL(title: 'atitle', value: 'www.google.com'),
          key: 'key',
          confidentiality: types.RelationshipAttributeConfidentiality.public,
        );
      default:
        throw UnimplementedError();
    }
  }

  Future<types.LocalRequestDTO?> getDecidableRequest() async {
    final requests = await runtime.currentSession.consumptionServices.incomingRequests.getRequests(query: {
      'status': types.LocalRequestStatus.ManualDecisionRequired.asQueryValue,
    });
    if (requests.isEmpty) return null;

    return requests.last;
  }
}
