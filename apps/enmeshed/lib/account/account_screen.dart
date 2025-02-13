import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'account_tab_controller.dart';
import 'app_drawer/app_drawer.dart';
import 'contacts/contacts_filter_controller.dart';
import 'mailbox/mailbox_filter_controller.dart';

class AccountScreen extends StatefulWidget {
  final String accountId;
  final ValueNotifier<SuggestionsBuilder?> suggestionsBuilder;
  final String location;
  final MailboxFilterController mailboxFilterController;
  final ContactsFilterController contactsFilterController;
  final Widget child;

  const AccountScreen({
    required this.accountId,
    required this.suggestionsBuilder,
    required this.location,
    required this.mailboxFilterController,
    required this.contactsFilterController,
    required this.child,
    super.key,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with SingleTickerProviderStateMixin {
  final List<StreamSubscription<void>> _subscriptions = [];

  late final TabController _tabController;
  List<LocalAccountDTO> _accountsInDeletion = [];

  LocalAccountDTO? _account;
  int _numberOfOpenContactRequests = 0;
  int _unreadMessagesCount = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<ProfileEditedEvent>().listen((_) => _loadAccount().catchError((_) {})))
      ..add(runtime.eventBus.on<AccountSelectedEvent>().listen((_) => _loadAccount().catchError((_) {})))
      ..add(runtime.eventBus.on<IncomingRequestReceivedEvent>().listen((_) => _reloadContactRequests().catchError((_) {})))
      ..add(runtime.eventBus.on<IncomingRequestStatusChangedEvent>().listen((_) => _reloadContactRequests().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageWasReadAtChangedEvent>().listen((_) => _loadUnreadMessages().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => _loadUnreadMessages().catchError((_) {})))
      ..add(runtime.eventBus.on<RelationshipDecomposedBySelfEvent>().listen((_) => _loadUnreadMessages().catchError((_) {})))
      ..add(runtime.eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reloadContactRequests().catchError((_) {})))
      ..add(runtime.eventBus.on<LocalAccountDeletionDateChangedEvent>().listen((_) => _reloadContactRequests().catchError((_) {})));

    _loadAccount();
    _reloadContactRequests();
    _loadUnreadMessages();
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(accountId: widget.accountId),
      appBar: AppBar(
        title: Text(switch (_selectedIndex) {
          0 => context.l10n.home_title,
          1 => context.l10n.contacts,
          2 => context.l10n.myData,
          3 => context.l10n.mailbox,
          _ => throw Exception('Unknown index: $_selectedIndex'),
        }, style: _selectedIndex == 0 ? Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary) : null),
        actions: [
          ..._actions ?? [],
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 14),
            child: Badge(
              isLabelVisible: _accountsInDeletion.isNotEmpty,
              child: AutoLoadingProfilePicture(
                accountId: widget.accountId,
                profileName: _account?.name ?? '',
                radius: 18,
                onPressed: () => context.push('/profiles?selectedAccountReference=${widget.accountId}'),
              ),
            ),
          ),
        ],
        scrolledUnderElevation: switch (_selectedIndex) {
          2 => 0,
          _ => 3,
        },
        notificationPredicate:
            (notification) => switch (_selectedIndex) {
              3 => notification.depth == 1,
              _ => notification.depth == 0,
            },
        bottom: switch (_selectedIndex) {
          3 => TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(child: Text(context.l10n.mailbox_incoming, style: Theme.of(context).textTheme.titleSmall)),
              Tab(child: Text(context.l10n.mailbox_outgoing, style: Theme.of(context).textTheme.titleSmall)),
            ],
          ),
          _ => null,
        },
      ),
      bottomNavigationBar: NavigationBar(
        destinations: <NavigationDestination>[
          NavigationDestination(icon: const Icon(Icons.home), label: context.l10n.home),
          NavigationDestination(
            label: context.l10n.contacts,
            icon: Badge(
              isLabelVisible: _numberOfOpenContactRequests > 0,
              textColor: Theme.of(context).colorScheme.onPrimary,
              label: Text(_numberOfOpenContactRequests.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
              child: const Icon(Icons.contacts),
            ),
          ),
          NavigationDestination(icon: const Icon(Icons.person), label: context.l10n.myData),
          NavigationDestination(
            label: context.l10n.mailbox,
            icon: Badge(
              isLabelVisible: _unreadMessagesCount > 0,
              textColor: Theme.of(context).colorScheme.onPrimary,
              label: Text(_unreadMessagesCount.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
              child: const Icon(Icons.mail),
            ),
          ),
        ],
        onDestinationSelected: (index) {
          if (index == _selectedIndex) return;

          context.go(switch (index) {
            0 => '/account/${widget.accountId}/home',
            1 => '/account/${widget.accountId}/contacts',
            2 => '/account/${widget.accountId}/my-data',
            3 => '/account/${widget.accountId}/mailbox',
            _ => throw Exception(),
          });

          _tabController.index = 0;
        },
        selectedIndex: _selectedIndex,
      ),
      body: AccountTabController(tabController: _tabController, child: widget.child),
    );
  }

  int get _selectedIndex {
    if (widget.location.startsWith('/account/:accountId/home')) return 0;
    if (widget.location.startsWith('/account/:accountId/contacts')) return 1;
    if (widget.location.startsWith('/account/:accountId/my-data')) return 2;
    if (widget.location.startsWith('/account/:accountId/mailbox')) return 3;

    throw Exception();
  }

  List<Widget>? get _actions => switch (_selectedIndex) {
    1 => [
      SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return IconButton(icon: const Icon(Icons.search), onPressed: () => controller.openView());
        },
        suggestionsBuilder:
            (context, controller) => widget.suggestionsBuilder.value == null ? [] : widget.suggestionsBuilder.value!(context, controller),
      ),
      ValueListenableBuilder(
        valueListenable: widget.contactsFilterController,
        builder:
            (context, value, child) => (value.isNotEmpty ? IconButton.filledTonal : IconButton.new)(
              icon: const Icon(Icons.filter_list),
              onPressed: () => widget.contactsFilterController.openContactsFilter(),
            ),
      ),
      IconButton(
        icon: const Icon(Icons.person_add),
        onPressed: () => goToInstructionsOrScanScreen(accountId: widget.accountId, instructionsType: ScannerType.addContact, context: context),
      ),
    ],
    3 => [
      SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return IconButton(icon: const Icon(Icons.search), onPressed: () => controller.openView());
        },
        suggestionsBuilder:
            (context, controller) => widget.suggestionsBuilder.value == null ? [] : widget.suggestionsBuilder.value!(context, controller),
      ),
      ValueListenableBuilder(
        valueListenable: widget.mailboxFilterController,
        builder:
            (context, value, child) => (value.isNotEmpty ? IconButton.filledTonal : IconButton.new)(
              icon: const Icon(Icons.filter_list),
              onPressed: () => widget.mailboxFilterController.openMailboxFilter(),
            ),
      ),
      IconButton(icon: const Icon(Icons.add), onPressed: () => context.go('/account/${widget.accountId}/mailbox/send')),
    ],
    _ => null,
  };

  Future<void> _loadAccount() async {
    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final account = await runtime.accountServices.getAccount(widget.accountId);
    final accountsInDeletion = await runtime.accountServices.getAccountsInDeletion();
    if (mounted) {
      setState(() {
        _account = account;
        _accountsInDeletion = accountsInDeletion;
      });
    }
  }

  Future<void> _reloadContactRequests() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final requests = await incomingOpenRequestsFromRelationshipTemplate(session: session);
    if (mounted) setState(() => _numberOfOpenContactRequests = requests.length);
  }

  Future<void> _loadUnreadMessages() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final messages = await getUnreadMessages(session: session, context: context);

    if (!mounted) return;

    setState(() => _unreadMessagesCount = messages.length);
  }
}
