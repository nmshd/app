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
              final identityInfo = await runtime.currentSession.transportServices.account.getIdentityInfo();
              final currentIdentityAddress = identityInfo.value.address;

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
              final identityInfo = await runtime.currentSession.transportServices.account.getIdentityInfo();
              final currentIdentityAddress = identityInfo.value.address;

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
              if (requests.value.isEmpty) return;

              final request = await runtime.currentSession.consumptionServices.incomingRequests.getRequest(
                requestId: requests.value.first.id,
              );
              print(request);
            },
            child: const Text('getRequest'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await runtime.currentSession.transportServices.account.syncEverything();

              final requests = await runtime.currentSession.consumptionServices.incomingRequests.getRequests(query: {
                'status': LocalRequestStatus.ManualDecisionRequired.asQueryValue,
              });

              if (requests.value.isEmpty) {
                print('There are no open requests');
                return;
              }

              print('---${requests.value.length}---');
              for (final request in requests.value) {
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
          return DecideRequestItemGroupParameters(items: e.items.map((itemDerivation) => const RejectRequestItemParameters()).toList());
        }

        return const RejectRequestItemParameters();
      }).toList();

  List<DecideRequestParametersItem> generateAcceptItems(List<RequestItem> items, String currentIdentityAddress) => items
      .map((e) => e is RequestItemGroup
          ? DecideRequestItemGroupParameters(
              items: e.items.map((item) => generateAcceptItem(item, currentIdentityAddress)).toList(),
            )
          : generateAcceptItem(e as RequestItemDerivation, currentIdentityAddress))
      .toList();

  AcceptRequestItemParameters generateAcceptItem(RequestItemDerivation requestItem, String currentIdentityAddress) {
    return switch (requestItem.runtimeType) {
      CreateAttributeRequestItem _ ||
      ShareAttributeRequestItem _ ||
      ConsentRequestItem _ ||
      AuthenticationRequestItem _ ||
      RegisterAttributeListenerRequestItem _ =>
        const AcceptRequestItemParameters(),
      ReadAttributeRequestItem _ => generateAcceptReadAttributeRequestItemParametersWithNewAttribute(
          requestItem as ReadAttributeRequestItem,
          currentIdentityAddress,
        ),
      ProposeAttributeRequestItem _ => AcceptProposeAttributeRequestItemParametersWithNewAttribute(
          attribute: (requestItem as ProposeAttributeRequestItem).attribute,
        ),
      _ => throw UnimplementedError(),
    };
  }

  AcceptRequestItemParameters generateAcceptReadAttributeRequestItemParametersWithNewAttribute(
    ReadAttributeRequestItem requestItem,
    String currentIdentityAddress,
  ) {
    return switch (requestItem.query.runtimeType) {
      IdentityAttributeQuery _ => AcceptReadAttributeRequestItemParametersWithNewAttribute(
          newAttribute: generateIdentityAtrribute(requestItem.query as IdentityAttributeQuery, currentIdentityAddress),
        ),
      RelationshipAttributeQuery _ => AcceptReadAttributeRequestItemParametersWithNewAttribute(
          newAttribute: generateRelationshipAtrribute(requestItem.query as RelationshipAttributeQuery, currentIdentityAddress),
        ),
      ThirdPartyRelationshipAttributeQuery _ => throw UnimplementedError(),
      _ => throw UnimplementedError(),
    };
  }

  IdentityAttribute generateIdentityAtrribute(IdentityAttributeQuery query, String currentIdentityAddress) {
    final type = query.valueType;
    return switch (type) {
      'AffiliationOrganization' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: AffiliationOrganizationAttributeValue(value: 'Test$type'),
        ),
      'AffiliationRole' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: AffiliationRoleAttributeValue(value: 'Test$type'),
        ),
      'AffiliationUnit' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: AffiliationUnitAttributeValue(value: 'Test$type'),
        ),
      'BirthCity' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: BirthCityAttributeValue(value: 'Test$type'),
        ),
      'BirthName' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: BirthNameAttributeValue(value: 'Test$type'),
        ),
      'BirthState' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: BirthStateAttributeValue(value: 'Test$type'),
        ),
      'City' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: CityAttributeValue(value: 'Test$type'),
        ),
      'DisplayName' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: DisplayNameAttributeValue(value: 'Test$type'),
        ),
      'IdentityFileReference' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: IdentityFileReferenceAttributeValue(value: 'Test${type}WithMinimunLengthOf30'),
        ),
      'GivenName' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: GivenNameAttributeValue(value: 'Test$type'),
        ),
      'HonorificPrefix' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: HonorificPrefixAttributeValue(value: 'Test$type'),
        ),
      'HonorificSuffix' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: HonorificSuffixAttributeValue(value: 'Test$type'),
        ),
      'HouseNumber' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: HouseNumberAttributeValue(value: 'Test$type'),
        ),
      'JobTitle' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: JobTitleAttributeValue(value: 'Test$type'),
        ),
      'MiddleName' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: MiddleNameAttributeValue(value: 'Test$type'),
        ),
      'PhoneNumber' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: PhoneNumberAttributeValue(value: 'Test$type'),
        ),
      'Pseudonym' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: PseudonymAttributeValue(value: 'Test$type'),
        ),
      'State' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: StateAttributeValue(value: 'Test$type'),
        ),
      'Street' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: StreetAttributeValue(value: 'Test$type'),
        ),
      'Surname' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: SurnameAttributeValue(value: 'Test$type'),
        ),
      'ZipCode' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: ZipCodeAttributeValue(value: 'Test$type'),
        ),
      'Affiliation' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const AffiliationAttributeValue(role: 'TestRole', organization: 'TestOrganization', unit: 'TestUnit'),
        ),
      'BirthCountry' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthCountryAttributeValue(value: 'DE'),
        ),
      'BirthDate' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthDateAttributeValue(day: 1, month: 1, year: 2000),
        ),
      'BirthDay' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthDayAttributeValue(value: 5),
        ),
      'BirthMonth' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthMonthAttributeValue(value: 5),
        ),
      'BirthPlace' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthPlaceAttributeValue(city: 'TestCity', country: 'DE'),
        ),
      'BirthYear' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const BirthYearAttributeValue(value: 2000),
        ),
      'Citizenship' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const CitizenshipAttributeValue(value: 'DE'),
        ),
      'CommunicationLanguage' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const CommunicationLanguageAttributeValue(value: 'de'),
        ),
      'Country' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const CountryAttributeValue(value: 'DE'),
        ),
      'DeliveryBoxAddress' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const DeliveryBoxAddressAttributeValue(
            recipient: 'recipient',
            deliveryBoxId: 'deliveryBoxId',
            userId: 'userId',
            zipCode: 'zipCode',
            city: 'city',
            country: 'country',
            phoneNumber: 'phoneNumber',
            state: 'state',
          ),
        ),
      'EMailAddress' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const EMailAddressAttributeValue(value: 'test@test.com'),
        ),
      'FaxNumber' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const FaxNumberAttributeValue(value: '123456789'),
        ),
      'Nationality' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const NationalityAttributeValue(value: 'DE'),
        ),
      'PersonName' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const PersonNameAttributeValue(
            givenName: 'givenName',
            surname: 'surname',
            honorificPrefix: 'honorificPrefix',
            honorificSuffix: 'honorificSuffix',
            middleName: 'middleName',
          ),
        ),
      'PostOfficeBoxAddress' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const PostOfficeBoxAddressAttributeValue(
            recipient: 'recipient',
            boxId: 'boxId',
            zipCode: 'zipCode',
            city: 'city',
            country: 'DE',
            state: 'state',
          ),
        ),
      'Sex' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const SexAttributeValue(value: 'male'),
        ),
      'StreetAddress' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const StreetAddressAttributeValue(
            recipient: 'recipient',
            street: 'street',
            houseNumber: 'houseNumber',
            zipCode: 'zipCode',
            city: 'city',
            country: 'country',
            state: 'state',
          ),
        ),
      'Website' => IdentityAttribute(
          owner: currentIdentityAddress,
          value: const WebsiteAttributeValue(value: 'www.testwebsite.com'),
        ),
      _ => throw UnimplementedError(),
    };
  }

  RelationshipAttribute generateRelationshipAtrribute(RelationshipAttributeQuery query, String currentIdentityAddress) {
    final type = query.attributeCreationHints.valueType;
    return switch (type) {
      'Consent' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ConsentAttributeValue(consent: 'TestConsent'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryBoolean' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryBooleanAttributeValue(title: 'atitle', value: true),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryCountry' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryCountryAttributeValue(title: 'atitle', value: 'DE'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryEMailAddress' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryEMailAddressAttributeValue(title: 'atitle', value: 'test@test.com'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryFileReference' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryFileReferenceAttributeValue(title: 'atitle', value: 'fileReference'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryFloat' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryFloatAttributeValue(title: 'atitle', value: 25.5),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryHEXColor' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryHEXColorAttributeValue(title: 'aTitle', value: '3d6dba'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryInteger' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryIntegerAttributeValue(title: 'atitle', value: 5),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryJSON' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryJSONAttributeValue(
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
        ),
      'ProprietaryLanguage' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryLanguageAttributeValue(title: 'atitle', value: 'de'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryPhoneNumber' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryPhoneNumberAttributeValue(title: 'atitle', value: '123456789'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryString' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryStringAttributeValue(title: 'atitle', value: 'propString'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      'ProprietaryURL' => RelationshipAttribute(
          owner: currentIdentityAddress,
          value: const ProprietaryURLAttributeValue(title: 'atitle', value: 'www.google.com'),
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
        ),
      _ => throw UnimplementedError(),
    };
  }

  Future<LocalRequestDTO?> getDecidableRequest() async {
    final requests = await runtime.currentSession.consumptionServices.incomingRequests.getRequests(query: {
      'status': LocalRequestStatus.ManualDecisionRequired.asQueryValue,
    });
    if (requests.value.isEmpty) return null;

    return requests.value.last;
  }
}
