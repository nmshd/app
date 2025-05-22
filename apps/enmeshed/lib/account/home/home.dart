import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'widgets/home_widgets.dart';

class HomeView extends StatefulWidget {
  final String accountId;

  const HomeView({required this.accountId, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;

  int _unreadMessagesCount = 0;
  List<MessageDVO>? _messages;
  List<LocalRequestDVO>? _requests;
  bool _isCompleteProfileContainerShown = false;
  bool _showRecoveryKitWasUsedContainer = false;

  final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

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
    _scrollController.dispose();

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
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              spacing: 24,
              children: [
                if (_isCompleteProfileContainerShown)
                  CompleteProfileContainer(hideContainer: _hideCompleteProfileContainer, accountId: widget.accountId),

                if (_showRecoveryKitWasUsedContainer)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ComplexInformationCard(
                      title: context.l10n.home_identityRecoveryKitWasUsed,
                      description: context.l10n.home_identityRecoverKitWasUsed_description,
                      icon: Icon(Icons.warning_rounded, color: context.customColors.warning),
                      actionButtons: [
                        OutlinedButton(
                          onPressed: () => upsertRestoreFromIdentityRecoveryKitSetting(accountId: widget.accountId, value: false),
                          child: Text(context.l10n.home_closeHint),
                        ),
                        FilledButton(onPressed: () => context.push('/profiles'), child: Text(context.l10n.home_create)),
                      ],
                    ),
                  ),
                AddContact(accountId: widget.accountId),
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

    final showRecoveryKitWasUsedContainer = await getSetting(
      accountId: widget.accountId,
      key: 'home.restoredIdentity',
      valueKey: 'showContainer',
      ignoreRecordNotFoundError: true,
    );

    if (!mounted) return;
    setState(() {
      _unreadMessagesCount = messages.length;
      _messages = messageDVOs;
      _requests = requests;
      _isCompleteProfileContainerShown = isCompleteProfileContainerShown;
      _showRecoveryKitWasUsedContainer = showRecoveryKitWasUsedContainer;
    });
  }

  Future<void> _hideCompleteProfileContainer() async {
    if (mounted) setState(() => _isCompleteProfileContainerShown = false);

    await upsertCompleteProfileContainerSetting(accountId: widget.accountId, value: false);
  }
}
