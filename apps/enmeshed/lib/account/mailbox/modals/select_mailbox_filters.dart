import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../mailbox_filter_controller.dart';
import '../mailbox_filter_option.dart';

Future<Set<FilterOption>?> showSelectMailboxFiltersModal({
  required List<IdentityDVO> contacts,
  required MailboxFilterController mailboxFilterController,
  required Set<FilterOption> selectedFilterOptions,
  required BuildContext context,
}) {
  final options = showModalBottomSheet<Set<FilterOption>?>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.75,
      child: _SelectFilterOptionsModal(
        contacts: contacts,
        mailboxFilterController: mailboxFilterController,
        selectedFilterOptions: Set.from(selectedFilterOptions),
      ),
    ),
  );

  return options;
}

class _SelectFilterOptionsModal extends StatefulWidget {
  final List<IdentityDVO> contacts;
  final MailboxFilterController mailboxFilterController;
  final Set<FilterOption> selectedFilterOptions;

  const _SelectFilterOptionsModal({
    required this.contacts,
    required this.mailboxFilterController,
    required this.selectedFilterOptions,
  });

  @override
  _SelectFilterOptionsModalState createState() => _SelectFilterOptionsModalState();
}

class _SelectFilterOptionsModalState extends State<_SelectFilterOptionsModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          title: Text(
            context.l10n.mailbox_filter_header,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.close,
              size: 22,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        ListTile(title: Text(context.l10n.filter, style: Theme.of(context).textTheme.titleMedium)),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: const Icon(Icons.notification_important),
          title: Text(context.l10n.mailbox_filter_actionRequired, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Checkbox(
            value: widget.selectedFilterOptions.contains(const ActionRequiredFilterOption()),
            onChanged: (value) => setState(() => widget.selectedFilterOptions.toggle(const ActionRequiredFilterOption())),
          ),
          onTap: () => setState(() => widget.selectedFilterOptions.toggle(const ActionRequiredFilterOption())),
        ),
        const Divider(height: 1, indent: 16),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: const Icon(Icons.attach_file),
          title: Text(context.l10n.mailbox_filter_withAttachment, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Checkbox(
            value: widget.selectedFilterOptions.contains(const WithAttachmentFilterOption()),
            onChanged: (value) => setState(() => widget.selectedFilterOptions.toggle(const WithAttachmentFilterOption())),
          ),
          onTap: () => setState(() => widget.selectedFilterOptions.toggle(const WithAttachmentFilterOption())),
        ),
        const Divider(height: 1, indent: 16),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: const Icon(Icons.mail),
          title: Text(context.l10n.mailbox_filter_unread),
          trailing: Checkbox(
            value: widget.selectedFilterOptions.contains(const UnreadFilterOption()),
            onChanged: (value) => setState(() => widget.selectedFilterOptions.toggle(const UnreadFilterOption())),
          ),
          onTap: () => setState(() => widget.selectedFilterOptions.toggle(const UnreadFilterOption())),
        ),
        Gaps.h16,
        ListTile(title: Text(context.l10n.mailbox_filter_byContacts, style: Theme.of(context).textTheme.titleMedium)),
        Expanded(
          child: widget.contacts.isEmpty
              ? EmptyListIndicator(icon: Icons.contacts, text: context.l10n.contacts_empty, wrapInListView: true)
              : ListView.separated(
                  itemCount: widget.contacts.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(height: 1, indent: 16),
                  itemBuilder: (context, index) {
                    final contact = widget.contacts[index];

                    return ContactItem(
                      contact: contact,
                      trailing: Checkbox(
                        value: widget.selectedFilterOptions.contains(ContactFilterOption(contact.id)),
                        onChanged: (_) => setState(() => widget.selectedFilterOptions.toggle(ContactFilterOption(contact.id))),
                      ),
                      onTap: () => setState(() => widget.selectedFilterOptions.toggle(ContactFilterOption(contact.id))),
                      iconSize: 42,
                    );
                  },
                ),
        ),
        _ModalSheetFooter(
          applyFilters: () => context.pop(widget.selectedFilterOptions),
          resetFilters: () => context.pop(<FilterOption>{}),
        ),
      ],
    );
  }
}

class _ModalSheetFooter extends StatelessWidget {
  final VoidCallback applyFilters;
  final VoidCallback resetFilters;

  const _ModalSheetFooter({
    required this.applyFilters,
    required this.resetFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Material(
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom + 16),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: resetFilters,
                    child: Text(
                      context.l10n.reset,
                    ),
                  ),
                  Gaps.w4,
                  FilledButton(
                    onPressed: applyFilters,
                    child: Text(context.l10n.apply_filter),
                  ),
                  Gaps.w16,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

extension _Toggle<T> on Set<T> {
  void toggle(T value) {
    contains(value) ? remove(value) : add(value);
  }
}
