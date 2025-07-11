import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

final List<String> personalDataInitialAttributeTypes = [
  'HonorificPrefix',
  'GivenName',
  'Surname',
  'BirthDate',
  'Citizenship',
  'Sex',
  'CommunicationLanguage',
];

final List<String> addressDataInitialAttributeTypes = ['StreetAddress', 'DeliveryBoxAddress', 'PostOfficeBoxAddress'];

final List<String> communcationDataInitialAttributeTypes = <String>['PhoneNumber', 'FaxNumber', 'EMailAddress', 'Website'];

Future<({bool personalData, bool addressData, bool communicationData})> getDataExisting(Session session) async {
  final personalDataResult = await session.consumptionServices.attributes.getRepositoryAttributes(
    query: {'content.value.@type': QueryValue.stringList(personalDataInitialAttributeTypes)},
  );

  final addressDataResult = await session.consumptionServices.attributes.getRepositoryAttributes(
    query: {'content.value.@type': QueryValue.stringList(addressDataInitialAttributeTypes)},
  );

  final communicationDataResult = await session.consumptionServices.attributes.getRepositoryAttributes(
    query: {'content.value.@type': QueryValue.stringList(communcationDataInitialAttributeTypes)},
  );

  return (
    // When we receive an error, we assume 'true' to not confuse the user.
    personalData: personalDataResult.isError || personalDataResult.value.isNotEmpty,
    addressData: addressDataResult.isError || addressDataResult.value.isNotEmpty,
    communicationData: communicationDataResult.isError || communicationDataResult.value.isNotEmpty,
  );
}

Future<List<LocalAttributeDTO?>> getUnviewedIdentityFileReferenceAttributes({required Session session, required BuildContext context}) async {
  final unviewedIdentityFileReferenceAttributes = await session.consumptionServices.attributes.getRepositoryAttributes(
    query: {
      'content.value.@type': QueryValue.string('IdentityFileReference'),
      'wasViewedAt': QueryValue.string('!'),
    },
  );

  return unviewedIdentityFileReferenceAttributes.value;
}
