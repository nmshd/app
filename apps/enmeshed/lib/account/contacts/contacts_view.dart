import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'contacts_filter_controller.dart';
import 'contacts_filter_option.dart';
import 'modals/select_contacts_filters.dart';
import 'widgets/widgets.dart';

enum _ContactsSortingType { date, name }

class ContactsView extends StatefulWidget {
  final String accountId;
  final ContactsFilterController contactsFilterController;
  final void Function(SuggestionsBuilder?) setSuggestionsBuilder;

  const ContactsView({
    required this.accountId,
    required this.setSuggestionsBuilder,
    required this.contactsFilterController,
    super.key,
  });

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

typedef RequestOrRelationship = ({IdentityDVO contact, LocalRequestDVO? openContactRequest});

extension on RequestOrRelationship {
  bool get requiresAttention {
    if (openContactRequest != null) return true;

    return switch (contact.relationship?.status) {
      null || RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed => true,
      _ => false,
    };
  }
}

class _ContactsViewState extends State<ContactsView> {
  late List<IdentityDVO> _relationships;

  List<RequestOrRelationship>? _contacts;
  List<RequestOrRelationship> _filteredContacts = [];

  late ContactsFavorites _contactsFavorites;
  List<IdentityDVO> _favorites = [];

  _ContactsSortingType _sortingType = _ContactsSortingType.name;
  bool _isSortedAscending = true;

  final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    widget.contactsFilterController.onOpenContactsFilter = _onOpenFilterPressed;
    _reload(syncBefore: true, isFirstTime: true);

    widget.contactsFilterController.value = {};

    widget.contactsFilterController.addListener(_reload);

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

    widget.contactsFilterController.removeListener(_reload);

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _reload,
      child: CustomScrollView(
        slivers: [
          if (!widget.contactsFilterController.isContactsFilterSet && _getNumberOfContactsRequiringAttention() > 0)
            SliverToBoxAdapter(
              child: AttentionRequiredBanner(
                numberOfContactsRequiringAttention: _getNumberOfContactsRequiringAttention(),
                showContactsRequiringAttention: () => widget.contactsFilterController.value = {const ActionRequiredContactsFilterOption()},
              ),
            ),
          if (_favorites.isNotEmpty && !widget.contactsFilterController.isContactsFilterSet) ...[
            SliverToBoxAdapter(child: ContactHeadline(text: context.l10n.favorites, icon: const Icon(Icons.star))),
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
          ],
          SliverToBoxAdapter(
            child: SortBar<_ContactsSortingType>(
              sortingType: _sortingType,
              isSortedAscending: _isSortedAscending,
              translate: (s) => switch (s) {
                _ContactsSortingType.name => context.l10n.sortedByName,
                _ContactsSortingType.date => context.l10n.sortedByDate,
              },
              sortMenuItem: [
                (value: _ContactsSortingType.name, label: context.l10n.name),
                (value: _ContactsSortingType.date, label: context.l10n.contacts_date),
              ],
              onSortingConditionChanged: ({required type, required isSortedAscending}) {
                _isSortedAscending = isSortedAscending;
                _sortingType = type;

                _filterAndSort();
              },
            ),
          ),
          if (widget.contactsFilterController.isContactsFilterSet)
            SliverToBoxAdapter(
              child: ContactsFilterBar(
                selectedFilterOptions: widget.contactsFilterController.value,
                removeFilter: (filter) => widget.contactsFilterController.removeFilter(filter),
                resetFilters: () => widget.contactsFilterController.value = {},
              ),
            ),
          if (_contacts!.isEmpty)
            _EmptyContactsIndicator(accountId: widget.accountId)
          else
            SliverList.separated(
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) {
                final item = _filteredContacts[index];
                final isFavoriteContact = _favorites.any((favorite) => favorite.id == item.contact.id);

                final contactItem = _ContactItem(
                  accountId: widget.accountId,
                  item: item,
                  isFavoriteContact: isFavoriteContact,
                  reload: _reload,
                  updateFavList: _updateFavList,
                );

                if (index != 0 ||
                    widget.contactsFilterController.isContactsFilterSet ||
                    (item.contact.isUnknown && _sortingType == _ContactsSortingType.name)) {
                  return contactItem;
                }

                return Column(
                  children: [
                    ContactHeadline(text: _contactToCategory(item)),
                    contactItem,
                  ],
                );
              },
              separatorBuilder: (context, index) {
                final currentCategory = _contactToCategory(_filteredContacts[index]);
                final nextCategory = _contactToCategory(_filteredContacts[index + 1]);

                if (currentCategory == nextCategory || widget.contactsFilterController.isContactsFilterSet) {
                  return const Divider(indent: 16, height: 2);
                }

                return ContactHeadline(text: nextCategory);
              },
            ),
        ],
      ),
    );
  }

  Future<void> _onOpenFilterPressed() async {
    final options = await showSelectContactsFiltersModal(
      contactsFilterController: widget.contactsFilterController,
      context: context,
    );

    if (options == null) return;

    widget.contactsFilterController.value = options;
  }

  String _contactToCategory(RequestOrRelationship requestOrRelationship) => switch (_sortingType) {
        _ContactsSortingType.date => simpleTimeago(context, requestOrRelationship.sortingDate),
        _ContactsSortingType.name => requestOrRelationship.contact.isUnknown ? '' : requestOrRelationship.contact.initials[0].toUpperCase(),
      };

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
    ];

    if (mounted) {
      setState(() {
        _relationships = relationships;
        _contactsFavorites = contactsFavorites;
        _favorites = relationships.where((contact) => contactsFavorites.contains(contact.relationship!.id)).toList();
        _contacts = requestsAndRelationships;
      });
    }

    _filterAndSort();

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

  int _getNumberOfContactsRequiringAttention() => _contacts!.where((contact) => contact.requiresAttention).length;

  void _filterAndSort() {
    if (!widget.contactsFilterController.isContactsFilterSet) {
      final sorted = _contacts!..sort(_compareFunction(_sortingType, _isSortedAscending));
      setState(() => _filteredContacts = sorted);
      return;
    }

    final selectedFilterOptions = widget.contactsFilterController.value;

    final filteredContacts = _contacts!.where((contact) {
      return switch (contact.contact.relationship?.status) {
        RelationshipStatus.Terminated => selectedFilterOptions.contains(const ActionRequiredContactsFilterOption()),
        RelationshipStatus.DeletionProposed => selectedFilterOptions.contains(const ActionRequiredContactsFilterOption()),
        RelationshipStatus.Active => selectedFilterOptions.contains(const ActiveContactsFilterOption()),
        RelationshipStatus.Pending => selectedFilterOptions.contains(const PendingContactsFilterOption()),
        RelationshipStatus.Revoked => false,
        RelationshipStatus.Rejected => false,
        null => selectedFilterOptions.contains(const ActionRequiredContactsFilterOption()),
      };
    }).toList()
      ..sort(_compareFunction(_sortingType, _isSortedAscending));

    setState(() => _filteredContacts = filteredContacts);
  }

  int Function(RequestOrRelationship, RequestOrRelationship) _compareFunction(_ContactsSortingType type, bool isSortedAscending) {
    return (a, b) {
      if (_sortingType == _ContactsSortingType.name) {
        // Sort 'i18n://dvo.identity.unknown' to the top
        if (a.contact.name == unknownContactName) return -1;
        if (b.contact.name == unknownContactName) return 1;
      }

      return switch (type) {
        _ContactsSortingType.date => isSortedAscending ? b.sortingDate.compareTo(a.sortingDate) : a.sortingDate.compareTo(b.sortingDate),
        _ContactsSortingType.name => isSortedAscending
            ? a.contact.name.toLowerCase().compareTo(b.contact.name.toLowerCase())
            : b.contact.name.toLowerCase().compareTo(a.contact.name.toLowerCase()),
      };
    };
  }
}

extension on RequestOrRelationship {
  DateTime get sortingDate => DateTime.parse(openContactRequest?.createdAt ?? contact.date ?? '0000-01-01');
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

class _EmptyContactsIndicator extends StatelessWidget {
  final String accountId;

  const _EmptyContactsIndicator({required this.accountId});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: EmptyListIndicator(
        icon: Icons.contacts,
        text: context.l10n.contacts_empty,
        description: context.l10n.contacts_emptyDescription,
        action: TextButton(
          onPressed: () => goToInstructionsOrScanScreen(
            accountId: accountId,
            instructionsType: InstructionsType.addContact,
            context: context,
          ),
          child: Text(context.l10n.contacts_addContact),
        ),
      ),
    );
  }
}
