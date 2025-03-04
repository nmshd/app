import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'dialogs.dart';
import 'extensions.dart';

const _contactSettingKey = 'contact_settings';

class ContactNameUpdatedEvent extends Event {
  ContactNameUpdatedEvent({required super.eventTargetAddress});
}

Future<void> setContactName({required String relationshipId, required Session session, required String accountId, String? contactName}) async {
  final settingValue = await _getContactSettings(relationshipId: relationshipId, session: session);

  settingValue['userTitle'] = contactName;

  await session.consumptionServices.settings.upsertSettingByKey(
    _contactSettingKey,
    settingValue,
    scope: SettingScope.Relationship,
    reference: relationshipId,
  );

  GetIt.I.get<EnmeshedRuntime>().eventBus.publish(ContactNameUpdatedEvent(eventTargetAddress: accountId));
}

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
      'status': QueryValue.stringList([
        LocalRequestStatus.DecisionRequired.name,
        LocalRequestStatus.ManualDecisionRequired.name,
        LocalRequestStatus.Expired.name,
      ]),
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
    final accepted = await showRevokeRelationshipConfirmationDialog(context);
    if (!accepted) return;

    final result = await session.transportServices.relationships.revokeRelationship(relationshipId: relationship.id);
    if (result.isError) {
      GetIt.I.get<Logger>().e(result.error);
      return;
    }

    onContactDeleted();
    return;
  }

  final accepted = await showDeleteRelationshipConfirmationDialog(
    context,
    contactName: contact.name,
    content:
        relationship.status == RelationshipStatus.Active && relationship.peerDeletionStatus == null
            ? context.l10n.contacts_delete_descriptionOnActive
            : context.l10n.contacts_delete_description,
  );
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

Future<({bool success, String? errorCode})> validateRelationshipCreation({
  required String accountId,
  required Session session,
  LocalRequestDVO? request,
}) async {
  if (request == null || request.peer.hasRelationship || request.source?.type != LocalRequestSourceType.RelationshipTemplate) {
    return (success: true, errorCode: null);
  }

  final response = await session.transportServices.relationships.canCreateRelationship(templateId: request.source!.reference);

  if (response.value.isSuccess) return (success: true, errorCode: null);

  final failureResponse = response.value as CanCreateRelationshipFailureResponse;

  return (success: false, errorCode: failureResponse.code);
}
