import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'contacts_filter_controller.dart';
import 'contacts_filter_option.dart';
import 'modals/select_contacts_filters.dart';
import 'widgets/discoverable_identities.dart';
import 'widgets/widgets.dart';

enum _ContactsSortingType { date, name }

class ContactsView extends StatefulWidget {
  final String accountId;
  final ContactsFilterController contactsFilterController;
  final void Function(SuggestionsBuilder?) setSuggestionsBuilder;

  const ContactsView({required this.accountId, required this.setSuggestionsBuilder, required this.contactsFilterController, super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  late List<IdentityDVO> _relationships;

  List<RequestOrRelationship>? _contacts;
  List<RequestOrRelationship> _filteredContacts = [];
  List<PublicRelationshipTemplateReferenceDTO> _matchingPublicRelationshipTemplateReferences = [];

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
      ..add(runtime.eventBus.on<RelationshipChangedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<ContactNameUpdatedEvent>().listen((_) => _reload().catchError((_) {})))
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
          if (_matchingPublicRelationshipTemplateReferences.isNotEmpty)
            SliverToBoxAdapter(
              child: DiscoverableIdentities(
                accountId: widget.accountId,
                publicRelationshipTemplateReferences: _matchingPublicRelationshipTemplateReferences,
              ),
            ),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.75),
              delegate: SliverChildBuilderDelegate((context, index) {
                final contact = _favorites[index];
                return ContactFavorite(contact: contact, onTap: () => context.push('/account/${widget.accountId}/contacts/${contact.id}'));
              }, childCount: _favorites.length),
            ),
          ],
          SliverToBoxAdapter(
            child: SortBar<_ContactsSortingType>(
              sortingType: _sortingType,
              isSortedAscending: _isSortedAscending,
              translate:
                  (s) => switch (s) {
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
                  toggleContactFavorite: _toggleContactFavorite,
                );

                if (index != 0 ||
                    widget.contactsFilterController.isContactsFilterSet ||
                    (item.contact.isUnknown && _sortingType == _ContactsSortingType.name)) {
                  return contactItem;
                }

                return Column(children: [ContactHeadline(text: _contactToCategory(item)), contactItem]);
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
    final options = await showSelectContactsFiltersModal(contactsFilterController: widget.contactsFilterController, context: context);

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
    final requests = await incomingOpenRequestsFromRelationshipTemplate(session: session);

    final requestsAndRelationships = [
      ...relationships.map((contact) => (contact: contact, openContactRequest: null)),
      ...requests.map((request) => (contact: request.peer, openContactRequest: request)),
    ];

    final templateReferences = <PublicRelationshipTemplateReferenceDTO>[];
    final referencesResult = await session.transportServices.publicRelationshipTemplateReferences.getPublicRelationshipTemplateReferences();
    if (referencesResult.isSuccess && referencesResult.value.isNotEmpty) {
      templateReferences.addAll(
        // currently the only way to filter out already existing relationships is comparing the title with the shared contact name
        // this is only a workaround and only practical for the PoC
        referencesResult.value.where((e) => !relationships.any((r) => (r.originalName ?? r.name) == e.title)),
      );

      if (mounted && context.isFeatureEnabled('SHOW_ADDITIONAL_PUBLIC_RELATIONSHIP_TEMPLATE_REFERENCES')) {
        templateReferences.addAll([
          const PublicRelationshipTemplateReferenceDTO(title: 'Uni Magdeburg', description: 'Uni Magdeburg', truncatedReference: 'none'),
          const PublicRelationshipTemplateReferenceDTO(title: 'Lernpfadfinder', description: 'Uni Magdeburg', truncatedReference: 'none'),
        ]);
      }
    }

    if (mounted) {
      setState(() {
        _relationships = relationships;
        _favorites = relationships.where((contact) => contact.relationship?.isPinned ?? false).toList();
        _contacts = requestsAndRelationships;
        _matchingPublicRelationshipTemplateReferences = templateReferences;
      });

      _filterAndSort();
    }

    if (isFirstTime) {
      widget.setSuggestionsBuilder(_buildSuggestions);
    }
  }

  Future<void> _toggleContactFavorite(IdentityDVO identity) async {
    setState(() {
      if (_favorites.any((favorite) => favorite.id == identity.id)) {
        _favorites.removeWhere((favorite) => favorite.id == identity.id);
      } else {
        _favorites.add(identity);
      }
    });

    await toggleContactPinned(relationshipId: identity.relationship!.id, session: GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId));
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

    final filteredContacts =
        _contacts!.where((contact) {
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
        _ContactsSortingType.name =>
          isSortedAscending
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
  final Future<void> Function(IdentityDVO identity) toggleContactFavorite;

  const _ContactItem({
    required this.accountId,
    required this.item,
    required this.isFavoriteContact,
    required this.reload,
    required this.toggleContactFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final contact = item.contact;

    return DismissibleContactItem(
      item: item,
      onTap: () => _onTap(context),
      isFavoriteContact: isFavoriteContact,
      onToggleFavorite: () => toggleContactFavorite(contact),
      onDeletePressed: _onDeletePressed,
    );
  }

  Future<void> _onTap(BuildContext context) async {
    final contact = item.contact;

    if (item.openContactRequest == null) {
      unawaited(context.push('/account/$accountId/contacts/${contact.id}'));
      return;
    }

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);
    final request = item.openContactRequest!;

    final validateRelationshipCreationResponse = await validateRelationshipCreation(accountId: accountId, request: request, session: session);

    if (!context.mounted) return;

    if (validateRelationshipCreationResponse.success) return context.go('/account/$accountId/contacts/contact-request/${request.id}', extra: request);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => CreateRelationshipErrorDialog(errorCode: validateRelationshipCreationResponse.errorCode!),
    );

    if (!context.mounted) return;

    if (result ?? false) await _onDeletePressed(context);
  }

  Future<void> _onDeletePressed(BuildContext context) async {
    final contact = item.contact;

    if (item.openContactRequest == null) {
      await deleteContact(context: context, accountId: accountId, contact: contact, onContactDeleted: reload);
      return;
    }

    final request = item.openContactRequest!;
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

    if (request.status == LocalRequestStatus.Expired) {
      final deleteResult = await session.consumptionServices.incomingRequests.delete(requestId: request.id);

      if (deleteResult.isError) {
        GetIt.I.get<Logger>().e(deleteResult.error);

        if (!context.mounted) return;

        showErrorSnackbar(context: context, text: context.l10n.error_deleteRequestFailed);
      }
      return;
    }

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
          onPressed: () => goToInstructionsOrScanScreen(accountId: accountId, instructionsType: ScannerType.addContact, context: context),
          child: Text(context.l10n.contacts_addContact),
        ),
      ),
    );
  }
}
