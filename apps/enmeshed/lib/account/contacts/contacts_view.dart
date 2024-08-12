import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../account_tab_controller.dart';
import 'widgets/contacts_widgets.dart';

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

class _ContactsViewState extends State<ContactsView> {
  List<IdentityDVO>? _relationships;
  late ContactsFavorites _contactsFavorites;
  List<IdentityDVO> _favorites = [];
  List<LocalRequestDVO>? _requests;

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
      ..add(runtime.eventBus.on<ContactFavoriteUpdatedEvent>().listen((_) => _reload().catchError((_) {})));
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
    final controller = AccountTabController.of(context);
    return TabBarView(
      controller: controller,
      children: [
        if (_relationships == null)
          const Center(child: CircularProgressIndicator())
        else
          ContactsOverview(
            accountId: widget.accountId,
            relationships: _relationships!,
            onRefresh: () => _reload(syncBefore: true),
            favorites: _favorites,
            updateFavList: _updateFavList,
          ),
        if (_requests == null)
          const Center(child: CircularProgressIndicator())
        else
          ContactRequests(
            requests: _requests!,
            onRefresh: () => _reload(syncBefore: true),
            accountId: widget.accountId,
          ),
      ],
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

    if (mounted) {
      setState(() {
        _relationships = relationships;
        _contactsFavorites = contactsFavorites;
        _favorites = relationships.where((contact) => contactsFavorites.contains(contact.relationship!.id)).toList();
        _requests = requests;
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
      _favorites = _relationships!.where((contact) => favs.contains(contact.relationship!.id)).toList();
    });
  }

  Iterable<Widget> _buildSuggestions(BuildContext context, SearchController controller) {
    final keyword = controller.value.text;

    return List<IdentityDVO>.of(_relationships!)
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
