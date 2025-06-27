import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/core.dart';
import 'mailbox_filter_option.dart';
import 'modals/mailbox_filter_help.dart';
import 'modals/select_contact_filter.dart';

class MailboxView extends StatefulWidget {
  final String accountId;
  final void Function(SuggestionsBuilder?) setSuggestionsBuilder;
  final String? filteredContactId;

  const MailboxView({
    required this.accountId,
    required this.setSuggestionsBuilder,
    this.filteredContactId,
    super.key,
  });

  @override
  State<MailboxView> createState() => _MailboxViewState();
}

class _MailboxViewState extends State<MailboxView> {
  List<MessageDVO>? _messages;
  List<IdentityDVO>? _contacts;

  late MailboxFilterOption _filterOption;
  late String? _filteredContactId;

  final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _filterOption = MailboxFilterOption.incoming;
    _filteredContactId = widget.filteredContactId;

    _reload(isFirstTime: true, syncBefore: true);

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<MessageSentEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<IncomingRequestStatusChangedEvent>().listen((_) => _reload().catchError((_) {})))
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
    if (_messages == null || _contacts == null) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: _FilterChipBar(
            selectedFilterOption: _filterOption,
            setFilter: (filter) {
              setState(() => _filterOption = filter);
              _reload();
            },
            filteredContactId: _filteredContactId,
            contacts: _contacts!,
            setFilteredContactId: (contactId) {
              setState(() => _filteredContactId = contactId);
              _reload();
            },
          ),
        ),
        Expanded(
          child: _MessageListView(
            messages: _messages!,
            accountId: widget.accountId,
            onRefresh: () => _reload(syncBefore: true),
            filterOption: _filterOption,
          ),
        ),
      ],
    );
  }

  Future<void> _reload({bool syncBefore = false, bool isFirstTime = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    if (!mounted) return;

    final query = {
      if (!context.showTechnicalMessages) 'content.@type': QueryValue.string(r'~^(Request|Mail)$'),
      if (_filteredContactId != null) 'participant': QueryValue.string(_filteredContactId!),
    };

    final identityInfo = await session.transportServices.account.getIdentityInfo();
    final ownAddress = identityInfo.value.address;

    switch (_filterOption) {
      case MailboxFilterOption.incoming:
        query['createdBy'] = QueryValue.string('!$ownAddress');
      case MailboxFilterOption.actionRequired:
        query['createdBy'] = QueryValue.string('!$ownAddress');
        query['content.@type'] = QueryValue.string('Request');
      case MailboxFilterOption.unread:
        query['createdBy'] = QueryValue.string('!$ownAddress');
        query['wasReadAt'] = QueryValue.string('!');
      case MailboxFilterOption.withAttachment:
        query['createdBy'] = QueryValue.string('!$ownAddress');
        query['attachments'] = QueryValue.string('+');
      case MailboxFilterOption.outgoing:
        query['createdBy'] = QueryValue.string(ownAddress);
        query['content.@type'] = QueryValue.string('Mail');
    }

    final messageResult = await session.transportServices.messages.getMessages(query: query);
    final messages = await session.expander.expandMessageDTOs(messageResult.value);
    messages.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));

    final contacts = await getContacts(session: session);

    if (mounted) {
      setState(() {
        _messages = messages;
        _contacts = contacts;
      });
    }

    if (isFirstTime) {
      widget.setSuggestionsBuilder(_buildSuggestions);
    }
  }

  Iterable<Widget> _buildSuggestions(BuildContext context, SearchController controller) {
    final keyword = controller.value.text;

    final messages = _messages ?? [];

    bool containsKeyword(MessageDVO message, String keyword) {
      return [
        if (message is MailDVO) message.body.toLowerCase(),
        if (message is MailDVO) message.subject.toLowerCase(),
        if (message is RequestMessageDVO) message.request.content.title?.toLowerCase(),
        if (message is RequestMessageDVO) message.request.content.description?.toLowerCase(),
        if (message.description != null) message.description!.toLowerCase(),
        message.name.toLowerCase(),
        message.peer.name.toLowerCase(),
      ].any((element) => element != null && element.contains(keyword.toLowerCase()));
    }

    return List<MessageDVO>.of(messages)
        .where((element) => containsKeyword(element, keyword))
        .map((item) => MessageListTile(message: item, accountId: widget.accountId, controller: controller, query: keyword))
        .separated(() => const Divider(height: 2));
  }
}

class _FilterChipBar extends StatelessWidget {
  final MailboxFilterOption selectedFilterOption;
  final void Function(MailboxFilterOption option) setFilter;

  final String? filteredContactId;
  final List<IdentityDVO> contacts;
  final void Function(String? contactId) setFilteredContactId;

  const _FilterChipBar({
    required this.selectedFilterOption,
    required this.setFilter,
    required this.filteredContactId,
    required this.contacts,
    required this.setFilteredContactId,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChipBar(
      onInfoPressed: () => showMailboxFilterHelpModal(context: context),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CondensedFilterChip(
            onPressed: () => setFilter(MailboxFilterOption.incoming),
            icon: MailboxFilterOption.incoming.filterIcon,
            label: context.l10n.mailbox_filterOption_incoming,
            isSelected: selectedFilterOption == MailboxFilterOption.incoming,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        CondensedFilterChip(
          onPressed: () => setFilter(MailboxFilterOption.actionRequired),
          icon: MailboxFilterOption.actionRequired.filterIcon,
          label: context.l10n.mailbox_filterOption_actionRequired,
          isSelected: selectedFilterOption == MailboxFilterOption.actionRequired,
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          foregroundColor: Theme.of(context).colorScheme.error,
        ),
        CondensedFilterChip(
          onPressed: () => setFilter(MailboxFilterOption.unread),
          icon: MailboxFilterOption.unread.filterIcon,
          label: context.l10n.mailbox_filterOption_unread,
          isSelected: selectedFilterOption == MailboxFilterOption.unread,
        ),
        CondensedFilterChip(
          onPressed: () => setFilter(MailboxFilterOption.withAttachment),
          icon: MailboxFilterOption.withAttachment.filterIcon,
          label: context.l10n.mailbox_filterOption_withAttachment,
          isSelected: selectedFilterOption == MailboxFilterOption.withAttachment,
        ),
        CondensedFilterChip(
          onPressed: () => setFilter(MailboxFilterOption.outgoing),
          icon: MailboxFilterOption.outgoing.filterIcon,
          label: context.l10n.mailbox_filterOption_outgoing,
          isSelected: selectedFilterOption == MailboxFilterOption.outgoing,
        ),
        _ContactSelectionChip(contacts: contacts, filteredContactId: filteredContactId, setFilteredContactId: setFilteredContactId),
      ],
    );
  }
}

class _ContactSelectionChip extends StatelessWidget {
  final List<IdentityDVO> contacts;
  final String? filteredContactId;
  final void Function(String? contact) setFilteredContactId;

  const _ContactSelectionChip({
    required this.contacts,
    required this.filteredContactId,
    required this.setFilteredContactId,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.surfaceContainerHighest;

    if (filteredContactId != null) {
      return Container(
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.only(left: 4),
        child: Row(
          children: [
            ContactCircleAvatar(contact: contacts.singleWhere((v) => v.id == filteredContactId), radius: 14),
            IconButton(
              onPressed: () => setFilteredContactId(null),
              icon: const Icon(Icons.cancel, size: 16),
              constraints: const BoxConstraints(minHeight: 34, minWidth: 34),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
              ),
            ),
          ],
        ),
      );
    }

    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(8),
      color: backgroundColor,
      child: InkWell(
        onTap: () async {
          final contact = await showSelectContactFilterModal(context: context, contacts: contacts);
          if (contact == null) return;

          setFilteredContactId(contact.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.person, size: 18, color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}

class _MessageListView extends StatelessWidget {
  final List<MessageDVO> messages;
  final String accountId;
  final Future<void> Function() onRefresh;
  final MailboxFilterOption filterOption;

  const _MessageListView({required this.messages, required this.accountId, required this.onRefresh, required this.filterOption});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: (messages.isEmpty)
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: EmptyListIndicator(
                icon: filterOption.emptyListIcon,
                wrapInListView: true,
                text: switch (filterOption) {
                  MailboxFilterOption.incoming => context.l10n.mailbox_empty_incoming,
                  MailboxFilterOption.actionRequired => context.l10n.mailbox_empty_actionRequired,
                  MailboxFilterOption.unread => context.l10n.mailbox_empty_unread,
                  MailboxFilterOption.withAttachment => context.l10n.mailbox_empty_withAttachment,
                  MailboxFilterOption.outgoing => context.l10n.mailbox_empty_outgoing,
                },
              ),
            )
          : ListView.separated(
              itemCount: messages.length,
              separatorBuilder: (context, index) {
                if (createdDayText(itemCreatedAt: DateTime.parse(messages[index].createdAt), context: context) ==
                    createdDayText(itemCreatedAt: DateTime.parse(messages[index + 1].createdAt), context: context)) {
                  return const Divider(indent: 16, height: 1);
                }

                return _DateTextDivider(createdAt: messages[index + 1].createdAt);
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DateTextDivider(createdAt: messages[index].createdAt),
                      MessageListTile(message: messages[index], accountId: accountId),
                    ],
                  );
                }

                return MessageListTile(message: messages[index], accountId: accountId);
              },
            ),
    );
  }
}

class _DateTextDivider extends StatelessWidget {
  final String createdAt;

  const _DateTextDivider({required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40,
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        createdDayText(itemCreatedAt: DateTime.parse(createdAt).toLocal(), context: context),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
