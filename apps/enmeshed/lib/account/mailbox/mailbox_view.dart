import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
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

  Set<FilterOption> _selectedFilterOptions = {};

  final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    widget.mailboxFilterController.onOpenMailboxFilter = _onOpenFilterPressed;
    _reload(isFirstTime: true, syncBefore: true);

    if (widget.filteredContactId != null) _selectedFilterOptions.add(ContactFilterOption(widget.filteredContactId!));
    widget.mailboxFilterController.updateMailboxFilterStatus(activeFilters: _selectedFilterOptions);

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<MessageSentEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageWasReadAtChangedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<AccountSelectedEvent>().listen((_) => _reload().catchError((_) {})));
  }

  @override
  void dispose() {
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
        if (_selectedFilterOptions.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: _FilterChipBar(selectedFilterOptions: _selectedFilterOptions, contacts: _contacts!, removeFilter: _removeFilter),
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
                  isFiltered: _selectedFilterOptions.isNotEmpty,
                ),
              if (_outgoingMessages == null)
                const Center(child: CircularProgressIndicator())
              else
                _MessageListView(
                  messages: _outgoingMessages!,
                  accountId: widget.accountId,
                  onRefresh: () => _reload(syncBefore: true),
                  isFiltered: _selectedFilterOptions.isNotEmpty,
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

    final filteredContactIds = _selectedFilterOptions.whereType<ContactFilterOption>().map((e) => e.contactId).toList();
    final query = {
      if (!context.showTechnicalMessages) 'content.@type': QueryValue.string(r'~^(Request|Mail)$'),
      if (filteredContactIds.isNotEmpty) 'participant': QueryValue.stringList(filteredContactIds),
    };

    if (_selectedFilterOptions.contains(const ActionRequiredFilterOption())) {
      query['content.@type'] = QueryValue.string('Request');
    }

    if (_selectedFilterOptions.contains(const WithAttachmentFilterOption())) {
      query['attachments'] = QueryValue.string('+');
    }

    final isUnreadFiltered = _selectedFilterOptions.contains(const UnreadFilterOption());

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

  void _removeFilter(FilterOption filter) {
    _selectedFilterOptions.remove(filter);
    widget.mailboxFilterController.updateMailboxFilterStatus(activeFilters: _selectedFilterOptions);
    _reload();
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
      selectedFilterOptions: _selectedFilterOptions,
      context: context,
    );

    if (options == null) return;

    _selectedFilterOptions = options;
    widget.mailboxFilterController.updateMailboxFilterStatus(activeFilters: _selectedFilterOptions);

    if (mounted) await _reload();
  }
}

class _FilterChipBar extends StatelessWidget {
  final Set<FilterOption> selectedFilterOptions;
  final List<IdentityDVO> contacts;
  final void Function(FilterOption option) removeFilter;

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

          return InputChip(
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
              side: BorderSide(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
