import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'widgets/home_widgets.dart';

class HomeView extends StatefulWidget {
  final String accountId;

  const HomeView({
    required this.accountId,
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _unreadMessagesCount = 0;
  List<MessageDVO>? _messages;
  List<LocalRequestDVO>? _requests;
  bool _isCompleteProfileContainerShown = false;

  final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _reload();

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<MessageSentEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageWasReadAtChangedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<IncomingRequestReceivedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<IncomingRequestStatusChangedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<AccountSelectedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reload().catchError((_) {})));
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    if (oldWidget.accountId != widget.accountId) _reload();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_messages == null || _requests == null) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: () => _reload(syncBefore: true),
      child: Scrollbar(
        thumbVisibility: true,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  if (_isCompleteProfileContainerShown) ...[
                    CompleteProfileContainer(hideContainer: _hideCompleteProfileContainer, accountId: widget.accountId),
                    Gaps.h24,
                  ],
                  if (context.isFeatureEnabled('NEWS')) ...[
                    NewsContainer.debugPrefilled(),
                    Gaps.h24,
                  ],
                  AddContactOrDeviceContainer(accountId: widget.accountId),
                ],
              ),
            ),
            Gaps.h24,
            if (context.isFeatureEnabled('SHOW_CONTACT_REQUESTS')) ...[
              ContactRequestsContainer(accountId: widget.accountId, relationshipRequests: _requests!),
              Gaps.h24,
            ],
            MessagesContainer(
              accountId: widget.accountId,
              messages: _messages,
              unreadMessagesCount: _unreadMessagesCount,
              seeAllMessages: () => context.go('/account/${widget.accountId}/mailbox'),
              title: context.l10n.home_messages,
              noMessagesText: context.l10n.home_noNewMessages,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reload({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final requests = await incomingOpenRequestsFromRelationshipTemplate(session: session);

    if (!mounted) return;

    final messagesResult = await getUnreadMessages(session: session, context: context);

    final messages = messagesResult..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final messageDVOs = await session.expander.expandMessageDTOs(messages.take(5).toList());

    final isCompleteProfileContainerShown = await getSetting(
      accountId: widget.accountId,
      key: 'home.completeProfileContainerShown',
      valueKey: 'isShown',
    );

    if (!mounted) return;
    setState(() {
      _unreadMessagesCount = messages.length;
      _messages = messageDVOs;
      _requests = requests;
      _isCompleteProfileContainerShown = isCompleteProfileContainerShown;
    });
  }

  Future<void> _hideCompleteProfileContainer() async {
    if (mounted) setState(() => _isCompleteProfileContainerShown = false);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    await session.consumptionServices.settings.createSetting(
      key: 'home.completeProfileContainerShown',
      value: {'isShown': false},
    );
  }
}
