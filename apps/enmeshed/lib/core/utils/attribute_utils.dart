import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import 'extensions.dart';

Future<LocalAttributeDTO?> createRepositoryAttribute({
  required String accountId,
  required BuildContext context,
  required IdentityAttributeValue value,
  required VoidCallback onAttributeCreated,
  ValueNotifier<bool>? createEnabledNotifier,
  void Function(String errorCode)? onAttributeCreationFailed,
  List<String>? tags,
}) async {
  if (createEnabledNotifier != null) createEnabledNotifier.value = false;

  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

  final createAttributeResult = await session.consumptionServices.attributes.createRepositoryAttribute(value: value, tags: tags);

  if (createAttributeResult.isSuccess) {
    if (context.mounted) context.pop();
    onAttributeCreated();

    return createAttributeResult.value;
  }

  GetIt.I.get<Logger>().e('Creating new attribute failed caused by: ${createAttributeResult.error}');

  if (onAttributeCreationFailed != null) {
    onAttributeCreationFailed(createAttributeResult.error.code);
  } else {
    if (context.mounted) {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
            content: Text(context.l10n.error_createAttribute),
          );
        },
      );

      if (createEnabledNotifier != null) createEnabledNotifier.value = true;
    }
  }

  return null;
}

final List<String> personalDataInitialAttributeTypes = [
  'HonorificPrefix',
  'GivenName',
  'Surname',
  'BirthDate',
  'Citizenship',
  'Sex',
  'CommunicationLanguage',
];

final List<String> addressDataInitialAttributeTypes = [
  'StreetAddress',
  'DeliveryBoxAddress',
  'PostOfficeBoxAddress',
];

final List<String> communcationDataInitialAttributeTypes = <String>[
  'PhoneNumber',
  'FaxNumber',
  'EMailAddress',
  'Website',
];

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
