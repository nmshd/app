import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/core.dart';
import '../account_tab_controller.dart';
import 'mailbox_filter_controller.dart';
import 'mailbox_filter_option.dart';
import 'modals/select_mailbox_filters.dart';

class MailboxView extends StatefulWidget {
  final String accountId;
  final MailboxFilterController mailboxFilterController;
  final void Function(SuggestionsBuilder?) setSuggestionsBuilder;
  final String? filteredContactId;

  const MailboxView({
    required this.accountId,
    required this.mailboxFilterController,
    required this.setSuggestionsBuilder,
    this.filteredContactId,
    super.key,
  });

  @override
  State<MailboxView> createState() => _MailboxViewState();
}

class _MailboxViewState extends State<MailboxView> {
  List<MessageDVO>? _incomingMessages;
  List<MessageDVO>? _outgoingMessages;
  List<IdentityDVO>? _contacts;

  final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    widget.mailboxFilterController.value = {
      if (widget.filteredContactId != null) ContactFilterOption(widget.filteredContactId!),
    };

    widget.mailboxFilterController.onOpenMailboxFilter = _onOpenFilterPressed;
    widget.mailboxFilterController.addListener(_reload);

    _reload(isFirstTime: true, syncBefore: true);

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<MessageSentEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageWasReadAtChangedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<AccountSelectedEvent>().listen((_) => _reload().catchError((_) {})));
  }

  @override
  void dispose() {
    widget.mailboxFilterController.removeListener(_reload);

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_incomingMessages == null || _outgoingMessages == null || _contacts == null) return const Center(child: CircularProgressIndicator());

    final controller = AccountTabController.of(context);

    return Column(
      children: [
        if (widget.mailboxFilterController.isMailboxFilterSet)
          Align(
            alignment: Alignment.centerLeft,
            child: _FilterChipBar(
              selectedFilterOptions: widget.mailboxFilterController.value,
              contacts: _contacts!,
              removeFilter: (filter) => widget.mailboxFilterController.removeFilter(filter),
            ),
          ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              if (_incomingMessages == null)
                const Center(child: CircularProgressIndicator())
              else
                _MessageListView(
                  messages: _incomingMessages!,
                  accountId: widget.accountId,
                  onRefresh: () => _reload(syncBefore: true),
                  isFiltered: widget.mailboxFilterController.isMailboxFilterSet,
                ),
              if (_outgoingMessages == null)
                const Center(child: CircularProgressIndicator())
              else
                _MessageListView(
                  messages: _outgoingMessages!,
                  accountId: widget.accountId,
                  onRefresh: () => _reload(syncBefore: true),
                  isFiltered: widget.mailboxFilterController.isMailboxFilterSet,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _reload({bool syncBefore = false, bool isFirstTime = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    if (!mounted) return;

    final filteredContactIds = widget.mailboxFilterController.value.whereType<ContactFilterOption>().map((e) => e.contactId).toList();
    final query = {
      if (!context.showTechnicalMessages) 'content.@type': QueryValue.string(r'~^(Request|Mail)$'),
      if (filteredContactIds.isNotEmpty) 'participant': QueryValue.stringList(filteredContactIds),
    };

    if (widget.mailboxFilterController.value.contains(const ActionRequiredFilterOption())) {
      query['content.@type'] = QueryValue.string('Request');
    }

    if (widget.mailboxFilterController.value.contains(const WithAttachmentFilterOption())) {
      query['attachments'] = QueryValue.string('+');
    }

    final isUnreadFiltered = widget.mailboxFilterController.value.contains(const UnreadFilterOption());

    final messageResult = await session.transportServices.messages.getMessages(query: query);
    final messages = await session.expander.expandMessageDTOs(messageResult.value);
    messages.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));

    final contacts = await getContacts(session: session);

    if (mounted) {
      setState(() {
        _incomingMessages = messages.where((element) => isUnreadFiltered ? !element.isOwn && element.wasReadAt == null : !element.isOwn).toList();
        _outgoingMessages = messages.where((element) => element.isOwn).toList();
        _contacts = contacts;
      });
    }

    if (isFirstTime) {
      widget.setSuggestionsBuilder(_buildSuggestions);
    }
  }

  Iterable<Widget> _buildSuggestions(BuildContext context, SearchController controller) {
    final keyword = controller.value.text;

    final messages = [...?_incomingMessages, ...?_outgoingMessages];

    bool containsKeyword(MessageDVO message, String keyword) {
      return [
        if (message is MailDVO) message.body.toLowerCase(),
        if (message is MailDVO) message.subject.toLowerCase(),
        if (message.description != null) message.description!.toLowerCase(),
        message.name.toLowerCase(),
        message.peer.name.toLowerCase(),
      ].any((element) => element.contains(keyword.toLowerCase()));
    }

    return List<MessageDVO>.of(messages)
        .where((element) => containsKeyword(element, keyword))
        .map(
          (item) => MessageDVORenderer(
            message: item,
            accountId: widget.accountId,
            controller: controller,
            query: keyword,
          ),
        )
        .separated(() => const Divider(height: 2));
  }

  Future<void> _onOpenFilterPressed() async {
    if (_contacts == null) return;

    final options = await showSelectMailboxFiltersModal(
      contacts: _contacts!,
      mailboxFilterController: widget.mailboxFilterController,
      context: context,
    );

    if (options == null) return;

    widget.mailboxFilterController.value = options;
  }
}

class _FilterChipBar extends StatelessWidget {
  final Set<MailboxFilterOption> selectedFilterOptions;
  final List<IdentityDVO> contacts;
  final void Function(MailboxFilterOption option) removeFilter;

  const _FilterChipBar({
    required this.selectedFilterOptions,
    required this.contacts,
    required this.removeFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final option = selectedFilterOptions.elementAt(index);

          return Chip(
            label: Text(
              switch (option) {
                ActionRequiredFilterOption() => context.l10n.mailbox_filter_actionRequired,
                UnreadFilterOption() => context.l10n.mailbox_filter_unread,
                WithAttachmentFilterOption() => context.l10n.mailbox_filter_withAttachment,
                final ContactFilterOption contactFilterOption => contacts.firstWhere((element) => element.id == contactFilterOption.contactId).name,
              },
              style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            padding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.only(left: 8),
            deleteIcon: const Icon(Icons.close),
            onDeleted: () => removeFilter(option),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Gaps.w8,
        itemCount: selectedFilterOptions.length,
      ),
    );
  }
}

class _MessageListView extends StatelessWidget {
  final List<MessageDVO> messages;
  final String accountId;
  final Future<void> Function() onRefresh;
  final bool isFiltered;

  const _MessageListView({
    required this.messages,
    required this.accountId,
    required this.onRefresh,
    required this.isFiltered,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: (messages.isEmpty)
          ? EmptyListIndicator(
              icon: Icons.mail_outline,
              text: context.l10n.mailbox_empty,
              wrapInListView: true,
              isFiltered: isFiltered,
              filteredText: context.l10n.mailbox_filtered_noResults,
            )
          : ListView.separated(
              itemCount: messages.length,
              separatorBuilder: (context, index) {
                if (createdDayText(itemCreatedAt: DateTime.parse(messages[index].createdAt), context: context) ==
                    createdDayText(itemCreatedAt: DateTime.parse(messages[index + 1].createdAt), context: context)) {
                  return const Divider(indent: 16);
                }

                return Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    createdDayText(itemCreatedAt: DateTime.parse(messages[index + 1].createdAt).toLocal(), context: context),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          createdDayText(itemCreatedAt: DateTime.parse(messages[index].createdAt).toLocal(), context: context),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      MessageDVORenderer(message: messages[index], accountId: accountId),
                    ],
                  );
                }

                return MessageDVORenderer(message: messages[index], accountId: accountId);
              },
            ),
    );
  }
}
