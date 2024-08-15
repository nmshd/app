import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'dialogs.dart';

const _contactsFavoritesKey = 'contacts_favorites';

class ContactFavoriteUpdatedEvent extends Event {
  ContactFavoriteUpdatedEvent({required super.eventTargetAddress});
}

Future<bool> isContactFavorite({required String relationshipId, required Session session}) async {
  final contactsFavorites = await getContactsFavoritesSetting(session);

  return contactsFavorites._relationshipIds.contains(relationshipId);
}

Future<void> toggleContactFavorite({required String relationshipId, required Session session, required String accountId}) async {
  final contactsFavorites = await getContactsFavoritesSetting(session);
  contactsFavorites.toggle(relationshipId);

  await session.consumptionServices.settings.updateSetting(contactsFavorites.id!, contactsFavorites.toJson());

  GetIt.I.get<EnmeshedRuntime>().eventBus.publish(ContactFavoriteUpdatedEvent(eventTargetAddress: accountId));
}

Future<void> updateContactsFavorites({required ContactsFavorites favorites, required Session session}) async {
  final contactsFavorites = await getContactsFavoritesSetting(session);
  final relationshipIdsJson = favorites.toJson();

  await session.consumptionServices.settings.updateSetting(contactsFavorites.id!, relationshipIdsJson);
}

Future<ContactsFavorites> loadContactsFavorites({required Session session}) async {
  final contactsFavorites = await getContactsFavoritesSetting(session);

  return contactsFavorites;
}

Future<ContactsFavorites> getContactsFavoritesSetting(Session session) async {
  var favoritesSettings = await session.consumptionServices.settings.getSettingByKey(_contactsFavoritesKey);

  if (favoritesSettings.isError) {
    final favorites = ContactsFavorites(relationshipIds: []);
    final relationshipIdsJson = favorites.toJson();
    favoritesSettings = await session.consumptionServices.settings.createSetting(
      key: _contactsFavoritesKey,
      value: relationshipIdsJson,
    );
  }

  final contactsFavorites = ContactsFavorites.fromJson(favoritesSettings.value.value)..id = favoritesSettings.value.id;
  return contactsFavorites;
}

Future<void> deleteContactsFavorites({required Session session}) async {
  final favoritesSettings = await getContactsFavoritesSetting(session);

  await session.consumptionServices.settings.deleteSetting(favoritesSettings.id!);
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

class ContactsFavorites {
  List<String> _relationshipIds;
  String? id;

  ContactsFavorites({required List<String> relationshipIds, this.id}) : _relationshipIds = relationshipIds;

  factory ContactsFavorites.fromJson(Map<String, dynamic> json) => ContactsFavorites(
        relationshipIds: List<String>.from(json['relationshipIds'] as List<dynamic>),
      );

  bool contains(String id) => _relationshipIds.contains(id);
  void toggle(String id) => contains(id) ? _relationshipIds.remove(id) : _relationshipIds.add(id);

  Map<String, dynamic> toJson() => {'relationshipIds': _relationshipIds};
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
