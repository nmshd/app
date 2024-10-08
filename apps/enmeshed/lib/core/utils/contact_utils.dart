import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'dialogs.dart';

const _contactSettingKey = 'contact_settings';

Future<void> toggleContactPinned({required String relationshipId, required Session session}) async {
  final settingValue = await _getContactSettings(relationshipId: relationshipId, session: session);

  settingValue['isPinned'] = switch (settingValue['isPinned']) {
    true => false,
    false => true,
    _ => true,
  };

  await session.consumptionServices.settings.upsertSettingByKey(
    _contactSettingKey,
    settingValue,
    scope: SettingScope.Relationship,
    reference: relationshipId,
  );
}

Future<Map<String, dynamic>> _getContactSettings({required String relationshipId, required Session session}) async {
  final existingSettingResult = await session.consumptionServices.settings.getSettingByKey(
    _contactSettingKey,
    scope: SettingScope.Relationship,
    reference: relationshipId,
  );

  if (existingSettingResult.isSuccess) return existingSettingResult.value.value;
  return {};
}

Future<List<IdentityDVO>> getActiveContacts({required Session session}) async {
  final contacts = await getContacts(session: session);

  return contacts.where((e) => e.relationship != null && e.relationship!.status == RelationshipStatus.Active).toList();
}

Future<List<IdentityDVO>> getContacts({required Session session}) async {
  final relationshipsResult = await session.transportServices.relationships.getRelationships(
    query: {
      'status': QueryValue.stringList([
        RelationshipStatus.Active.name,
        RelationshipStatus.Pending.name,
        RelationshipStatus.Terminated.name,
        RelationshipStatus.DeletionProposed.name,
      ]),
    },
  );
  final dvos = await session.expander.expandRelationshipDTOs(relationshipsResult.value);
  dvos.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  return dvos;
}

Future<List<LocalRequestDVO>> incomingOpenRequestsFromRelationshipTemplate({required Session session}) async {
  final incomingRequestResult = await session.consumptionServices.incomingRequests.getRequests(
    query: {
      'status': QueryValue.stringList([LocalRequestStatus.DecisionRequired.name, LocalRequestStatus.ManualDecisionRequired.name]),
      'source.type': QueryValue.string(LocalRequestSourceType.RelationshipTemplate.name),
    },
  );

  if (incomingRequestResult.isError) {
    GetIt.I.get<Logger>().e(incomingRequestResult.error);
    return [];
  }

  final expandedOpenRequests = await session.expander.expandLocalRequestDTOs(incomingRequestResult.value);

  return expandedOpenRequests;
}

Future<void> deleteContact({
  required BuildContext context,
  required String accountId,
  required IdentityDVO contact,
  required VoidCallback onContactDeleted,
}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

  final relationship = contact.relationship!;

  if (relationship.status == RelationshipStatus.Pending) {
    final accepted = await showRevokeRelationshipConfirmationDialog(context, contactName: contact.name);
    if (!accepted) return;

    final result = await session.transportServices.relationships.revokeRelationship(relationshipId: relationship.id);
    if (result.isError) {
      GetIt.I.get<Logger>().e(result.error);
      return;
    }

    return;
  }

  final accepted = await showDeleteRelationshipConfirmationDialog(context, contactName: contact.name);
  if (!accepted) return;

  if (relationship.status == RelationshipStatus.Active) {
    final result = await session.transportServices.relationships.terminateRelationship(relationshipId: relationship.id);
    if (result.isError) {
      GetIt.I.get<Logger>().e(result.error);
      return;
    }
  }

  final result = await session.transportServices.relationships.decomposeRelationship(relationshipId: relationship.id);
  if (result.isError) {
    GetIt.I.get<Logger>().e(result.error);
    return;
  }
  onContactDeleted();
}
