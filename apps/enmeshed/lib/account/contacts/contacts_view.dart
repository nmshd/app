import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'contacts_filter_option.dart';
import 'widgets/discoverable_identities.dart';
import 'widgets/widgets.dart';

class ContactsView extends StatefulWidget {
  final String accountId;
  final void Function(SuggestionsBuilder?) setSuggestionsBuilder;

  const ContactsView({required this.accountId, required this.setSuggestionsBuilder, super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  late List<IdentityDVO> _relationships;

  List<IdentityWithOpenRequests>? _contacts;
  List<IdentityWithOpenRequests> _filteredContacts = [];
  List<PublicRelationshipTemplateReferenceDTO> _matchingPublicRelationshipTemplateReferences = [];

  ContactsFilterOption _option = ContactsFilterOption.all;

  List<IdentityDVO> _favorites = [];

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
      ..add(runtime.eventBus.on<RelationshipChangedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<ContactNameUpdatedEvent>().listen((_) => _reload().catchError((_) {})))
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
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _reload,
      child: Scrollbar(
        child: CustomScrollView(
          slivers: [
            if (_matchingPublicRelationshipTemplateReferences.isNotEmpty)
              SliverToBoxAdapter(
                child: DiscoverableIdentities(
                  accountId: widget.accountId,
                  publicRelationshipTemplateReferences: _matchingPublicRelationshipTemplateReferences,
                ),
              ),
            if (_getNumberOfContactsRequiringAttention() > 0)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BannerCard(
                    title: context.l10n.contacts_require_attention(_getNumberOfContactsRequiringAttention()),
                    type: BannerCardType.info,
                    actionButton: (
                      onPressed: () {
                        if (_option == ContactsFilterOption.actionRequired) return;

                        setState(() {
                          _option = ContactsFilterOption.actionRequired;
                          _filterAndSort();
                        });
                      },
                      title: context.l10n.show,
                    ),
                  ),
                ),
              ),
            if (_favorites.isNotEmpty) ...[
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisExtent: 145),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final contact = _favorites[index];
                  return ContactFavorite(contact: contact, onTap: () => context.push('/account/${widget.accountId}/contacts/${contact.id}'));
                }, childCount: _favorites.length),
              ),
            ],
            SliverToBoxAdapter(
              child: ContactsFilterBar(
                selectedFilterOption: _option,
                setFilter: (filter) {
                  setState(() {
                    _option = filter;
                    _filterAndSort();
                  });
                },
              ),
            ),
            if (_filteredContacts.isEmpty)
              _EmptyContactsIndicator(accountId: widget.accountId, option: _option)
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

                  if (index != 0 || item.contact.isUnknown) return contactItem;

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

                  if (currentCategory == nextCategory) return const Divider(indent: 16, height: 2);

                  return ContactHeadline(text: nextCategory);
                },
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  String _contactToCategory(IdentityWithOpenRequests requestOrRelationship) =>
      requestOrRelationship.contact.isUnknown ? '' : requestOrRelationship.contact.initials[0].toUpperCase();

  Future<void> _reload({bool syncBefore = false, bool isFirstTime = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) {
      await session.transportServices.account.syncEverything();
    }

    final relationships = await getContacts(session: session);
    final requests = await incomingOpenRequestsFromRelationshipTemplate(session: session);

    final requestsAndRelationships = <IdentityWithOpenRequests>[...relationships.map((contact) => (contact: contact, openRequests: []))];

    for (final request in requests) {
      final entry = requestsAndRelationships.where((item) => item.contact.id == request.peer.id).firstOrNull;

      if (entry != null) {
        entry.openRequests.add(request);
      } else {
        requestsAndRelationships.add((contact: request.peer, openRequests: [request]));
      }
    }

    final templateReferences = <PublicRelationshipTemplateReferenceDTO>[];
    final referencesResult = await session.transportServices.publicRelationshipTemplateReferences.getPublicRelationshipTemplateReferences();
    if (referencesResult.isSuccess && referencesResult.value.isNotEmpty) {
      templateReferences.addAll(
        // currently the only way to filter out already existing relationships is comparing the title with the shared contact name
        // this is only a workaround and only practical for the PoC
        referencesResult.value.where((e) => !relationships.any((r) => (r.originalName ?? r.name) == e.title)),
      );
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
            iconSize: 40,
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
    final filtered =
        switch (_option) {
          ContactsFilterOption.all => _contacts!,
          ContactsFilterOption.actionRequired => _contacts!.where((contact) => contact.requiresAttention).toList(),
          ContactsFilterOption.active => _contacts!.where((contact) => contact.contact.relationship?.status == RelationshipStatus.Active).toList(),
        }..sort((a, b) {
          // Sort 'i18n://dvo.identity.unknown' to the top
          if (a.contact.name == unknownContactName) return -1;
          if (b.contact.name == unknownContactName) return 1;

          return a.contact.name.toLowerCase().compareTo(b.contact.name.toLowerCase());
        });

    setState(() => _filteredContacts = filtered);
  }
}

class _ContactItem extends StatelessWidget {
  final String accountId;
  final IdentityWithOpenRequests item;
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

    if (item.openRequests.isEmpty || item.contact.hasRelationship) {
      unawaited(context.push('/account/$accountId/contacts/${contact.id}'));
      return;
    }

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);
    final request = item.openRequests.first;

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

    if (item.openRequests.isEmpty) {
      await deleteContact(context: context, accountId: accountId, contact: contact, onContactDeleted: reload);
      return;
    }

    final request = item.openRequests.first;
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
  final ContactsFilterOption option;

  const _EmptyContactsIndicator({required this.accountId, required this.option});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: EmptyListIndicator(
          icon: option.emptyListIcon,
          text: switch (option) {
            ContactsFilterOption.all => context.l10n.contacts_empty,
            ContactsFilterOption.active => context.l10n.contacts_empty_active,
            ContactsFilterOption.actionRequired => context.l10n.contacts_empty_actionRequired,
          },
          description: switch (option) {
            ContactsFilterOption.all => context.l10n.contacts_emptyDescription,
            ContactsFilterOption.actionRequired || ContactsFilterOption.active => null,
          },
          action: option != ContactsFilterOption.all
              ? null
              : TextButton(
                  onPressed: () => goToInstructionsOrScanScreen(accountId: accountId, instructionsType: ScannerType.addContact, context: context),
                  child: Text(context.l10n.contacts_addContact),
                ),
        ),
      ),
    );
  }
}
