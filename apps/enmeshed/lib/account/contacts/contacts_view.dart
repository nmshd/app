import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'widgets/widgets.dart';

class ContactsView extends StatefulWidget {
  final String accountId;
  final void Function(SuggestionsBuilder?) setSuggestionsBuilder;

  const ContactsView({
    required this.accountId,
    required this.setSuggestionsBuilder,
    super.key,
  });

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

typedef RequestOrRelationship = ({IdentityDVO contact, LocalRequestDVO? openContactRequest});

class _ContactsViewState extends State<ContactsView> {
  late List<IdentityDVO> _relationships;
  late ContactsFavorites _contactsFavorites;
  List<IdentityDVO> _favorites = [];

  List<RequestOrRelationship>? _requestsAndRelationships;

  final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _reload(syncBefore: true, isFirstTime: true);

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<IncomingRequestReceivedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<IncomingRequestStatusChangedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<RelationshipChangedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<AccountSelectedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<ContactFavoriteUpdatedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<RelationshipDecomposedBySelfEvent>().listen((_) => _reload().catchError((_) {})));
  }

  @override
  void dispose() {
    widget.setSuggestionsBuilder(null);

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_requestsAndRelationships == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_requestsAndRelationships!.isEmpty) {
      return RefreshIndicator(
        onRefresh: _reload,
        child: EmptyListIndicator(
          icon: Icons.contacts,
          text: context.l10n.contacts_empty,
          description: context.l10n.contacts_emptyDescription,
          wrapInListView: true,
          action: TextButton(
            onPressed: () => goToInstructionsOrScanScreen(
              accountId: widget.accountId,
              instructionsType: InstructionsType.addContact,
              context: context,
            ),
            child: Text(context.l10n.contacts_addContact),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _reload,
      child: CustomScrollView(
        slivers: [
          if (_favorites.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ContactHeadline(text: context.l10n.favorites, icon: const Icon(Icons.star)),
              ),
            ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final contact = _favorites[index];
                return ContactFavorite(
                  contact: contact,
                  onTap: () => context.push('/account/${widget.accountId}/contacts/${contact.id}'),
                );
              },
              childCount: _favorites.length,
            ),
          ),
          SliverList.separated(
            itemCount: _requestsAndRelationships!.length,
            itemBuilder: (context, index) {
              final item = _requestsAndRelationships![index];
              final isFavoriteContact = _favorites.any((favorite) => favorite.id == item.contact.id);

              final contactItem = _ContactItem(
                accountId: widget.accountId,
                item: item,
                isFavoriteContact: isFavoriteContact,
                reload: _reload,
                updateFavList: _updateFavList,
              );

              if (index != 0 || item.contact.isUnknown) return contactItem;

              return Column(
                children: [
                  ContactHeadline(text: item.contact.initials[0].toUpperCase()),
                  contactItem,
                ],
              );
            },
            separatorBuilder: (context, index) {
              final currentCategory = _requestsAndRelationships![index].contact.initials[0].toLowerCase();
              final nextContact = _requestsAndRelationships![index + 1].contact;
              final nextCategory = nextContact.initials[0].toLowerCase();
              if (currentCategory == nextCategory) return const Divider(indent: 16, height: 2);

              return ContactHeadline(text: nextContact.initials[0].toUpperCase());
            },
          ),
        ],
      ),
    );
  }

  Future<void> _reload({bool syncBefore = false, bool isFirstTime = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) {
      await session.transportServices.account.syncEverything();
    }

    final relationships = await getContacts(session: session);
    final contactsFavorites = await loadContactsFavorites(session: session);
    final requests = await incomingOpenRequestsFromRelationshipTemplate(session: session);

    final requestsAndRelationships = [
      ...relationships.map((contact) => (contact: contact, openContactRequest: null)),
      ...requests.map((request) => (contact: request.peer, openContactRequest: request)),
    ]..sort((a, b) {
        final aName = a.contact.name;
        final bName = b.contact.name;

        // sort requestsAndRelationships by contact name
        // but always sort 'i18n://dvo.identity.unknown' to the top
        if (aName == unknownContactName) return -1;
        if (bName == unknownContactName) return 1;

        return aName.compareTo(bName);
      });

    if (mounted) {
      setState(() {
        _relationships = relationships;
        _contactsFavorites = contactsFavorites;
        _favorites = relationships.where((contact) => contactsFavorites.contains(contact.relationship!.id)).toList();
        _requestsAndRelationships = requestsAndRelationships;
      });
    }

    if (isFirstTime) {
      widget.setSuggestionsBuilder(_buildSuggestions);
    }
  }

  Future<void> _updateFavList(IdentityDVO identity) async {
    final favs = _contactsFavorites..toggle(identity.relationship!.id);

    // update is done in background to make the UI more responsive
    unawaited(updateContactsFavorites(favorites: favs, session: GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId)));

    setState(() {
      _favorites = _relationships.where((contact) => favs.contains(contact.relationship!.id)).toList();
    });
  }

  Iterable<Widget> _buildSuggestions(BuildContext context, SearchController controller) {
    final keyword = controller.value.text;

    return List<IdentityDVO>.of(_relationships)
        .where((element) => element.name.toLowerCase().contains(keyword.toLowerCase()))
        .map(
          (item) => ContactItem(
            contact: item,
            query: keyword,
            onTap: () {
              controller
                ..clear()
                ..closeView(null);
              FocusScope.of(context).unfocus();

              context.push('/account/${widget.accountId}/contacts/${item.id}');
            },
          ),
        )
        .separated(() => const Divider(height: 2));
  }
}

class _ContactItem extends StatelessWidget {
  final String accountId;
  final RequestOrRelationship item;
  final bool isFavoriteContact;
  final VoidCallback reload;
  final Future<void> Function(IdentityDVO identity) updateFavList;

  const _ContactItem({
    required this.accountId,
    required this.item,
    required this.isFavoriteContact,
    required this.reload,
    required this.updateFavList,
  });

  @override
  Widget build(BuildContext context) {
    final contact = item.contact;

    return DismissibleContactItem(
      contact: contact,
      onTap: () => _onTap(context),
      trailing: item.openContactRequest != null
          ? const Padding(padding: EdgeInsets.all(8), child: Icon(Icons.edit))
          : IconButton(
              icon: isFavoriteContact ? const Icon(Icons.star) : const Icon(Icons.star_border),
              color: isFavoriteContact ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.shadow,
              onPressed: () => updateFavList(contact),
            ),
      onDeletePressed: _onDeletePressed,
    );
  }

  void _onTap(BuildContext context) {
    final contact = item.contact;

    if (item.openContactRequest == null) {
      context.push('/account/$accountId/contacts/${contact.id}');
      return;
    }

    final request = item.openContactRequest!;
    context.go('/account/$accountId/contacts/contact-request/${request.id}', extra: request);
  }

  Future<void> _onDeletePressed(BuildContext context) async {
    final contact = item.contact;

    if (item.openContactRequest == null) {
      await deleteContact(context: context, accountId: accountId, contact: contact, onContactDeleted: reload);
      return;
    }

    final request = item.openContactRequest!;

    final rejectItems = List<DecideRequestParametersItem>.from(
      request.items.map((e) {
        if (e is RequestItemGroupDVO) {
          final items = e.items.map((e) => const RejectRequestItemParameters()).toList();
          return DecideRequestItemGroupParameters(items: items);
        }

        return const RejectRequestItemParameters();
      }),
    );

    final rejectParams = DecideRequestParameters(requestId: request.id, items: rejectItems);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);
    final result = await session.consumptionServices.incomingRequests.reject(params: rejectParams);
    if (result.isError) GetIt.I.get<Logger>().e(result.error);
  }
}
