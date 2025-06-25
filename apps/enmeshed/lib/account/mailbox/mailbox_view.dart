import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
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
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          child: Row(
            spacing: 4,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: _FilterOptionChip(
                  option: MailboxFilterOption.incoming,
                  setFilter: setFilter,
                  label: context.l10n.mailbox_filterOption_incoming,
                  isSelected: selectedFilterOption == MailboxFilterOption.incoming,
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              _FilterOptionChip(
                option: MailboxFilterOption.actionRequired,
                setFilter: setFilter,
                label: context.l10n.mailbox_filterOption_actionRequired,
                isSelected: selectedFilterOption == MailboxFilterOption.actionRequired,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              _FilterOptionChip(
                option: MailboxFilterOption.unread,
                setFilter: setFilter,
                label: context.l10n.mailbox_filterOption_unread,
                isSelected: selectedFilterOption == MailboxFilterOption.unread,
              ),
              _FilterOptionChip(
                option: MailboxFilterOption.withAttachment,
                setFilter: setFilter,
                label: context.l10n.mailbox_filterOption_withAttachment,
                isSelected: selectedFilterOption == MailboxFilterOption.withAttachment,
              ),
              _FilterOptionChip(
                option: MailboxFilterOption.outgoing,
                setFilter: setFilter,
                label: context.l10n.mailbox_filterOption_outgoing,
                isSelected: selectedFilterOption == MailboxFilterOption.outgoing,
              ),
              _ContactSelectionChip(contacts: contacts, filteredContactId: filteredContactId, setFilteredContactId: setFilteredContactId),
              const SizedBox(width: 52),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
            ),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(
                onPressed: () => showMailboxFilterHelpModal(context: context),
                icon: const Icon(Icons.info),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterOptionChip extends StatelessWidget {
  final MailboxFilterOption option;
  final void Function(MailboxFilterOption option) setFilter;
  final String label;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const _FilterOptionChip({
    required this.option,
    required this.setFilter,
    required this.label,
    required this.isSelected,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest;
    final foregroundColor = this.foregroundColor ?? Theme.of(context).colorScheme.onSurface;

    if (!isSelected) {
      return Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: RawChip(
          label: Icon(option.filterIcon, size: 24, color: foregroundColor),
          onPressed: () => setFilter(option),
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(2),
          side: const BorderSide(color: Colors.transparent),
        ),
      );
    }

    return RawChip(
      avatar: Icon(option.filterIcon, size: 24, color: foregroundColor),
      label: Text(label, style: TextStyle(color: foregroundColor)),
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.all(2),
      labelPadding: const EdgeInsets.only(left: 4, right: 8),
      side: const BorderSide(color: Colors.transparent),
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
    if (filteredContactId != null) {
      return RawChip(
        labelPadding: EdgeInsets.zero,
        label: ContactCircleAvatar(contact: contacts.singleWhere((v) => v.id == filteredContactId), radius: 14),
        onDeleted: () => setFilteredContactId(null),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        padding: const EdgeInsets.only(left: 4),
        side: const BorderSide(color: Colors.transparent),
      );
    }

    return RawChip(
      label: Icon(Icons.person, size: 24, color: Theme.of(context).colorScheme.onSurface),
      onPressed: () async {
        final contact = await showSelectContactFilterModal(context: context, contacts: contacts);
        if (contact == null) return;

        setFilteredContactId(contact.id);
      },
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.all(2),
      side: const BorderSide(color: Colors.transparent),
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
