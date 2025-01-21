import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../mailbox_filter_controller.dart';
import '../mailbox_filter_option.dart';

Future<Set<MailboxFilterOption>?> showSelectMailboxFiltersModal({
  required List<IdentityDVO> contacts,
  required MailboxFilterController mailboxFilterController,
  required BuildContext context,
}) {
  final options = showModalBottomSheet<Set<MailboxFilterOption>?>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.75,
      child: _SelectMailboxFiltersModal(contacts: contacts, mailboxFilterController: mailboxFilterController),
    ),
  );

  return options;
}

class _SelectMailboxFiltersModal extends StatefulWidget {
  final List<IdentityDVO> contacts;
  final MailboxFilterController mailboxFilterController;

  const _SelectMailboxFiltersModal({required this.contacts, required this.mailboxFilterController});

  @override
  _SelectMailboxFiltersModalState createState() => _SelectMailboxFiltersModalState();
}

class _SelectMailboxFiltersModalState extends State<_SelectMailboxFiltersModal> {
  late Set<MailboxFilterOption> selectedFilterOptions;

  @override
  void initState() {
    super.initState();

    selectedFilterOptions = {...widget.mailboxFilterController.value};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
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
            value: selectedFilterOptions.contains(const ActionRequiredFilterOption()),
            onChanged: (value) => setState(() => selectedFilterOptions.toggle(const ActionRequiredFilterOption())),
          ),
          onTap: () => setState(() => selectedFilterOptions.toggle(const ActionRequiredFilterOption())),
        ),
        const Divider(height: 1, indent: 16),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: const Icon(Icons.attach_file),
          title: Text(context.l10n.mailbox_filter_withAttachment, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Checkbox(
            value: selectedFilterOptions.contains(const WithAttachmentFilterOption()),
            onChanged: (value) => setState(() => selectedFilterOptions.toggle(const WithAttachmentFilterOption())),
          ),
          onTap: () => setState(() => selectedFilterOptions.toggle(const WithAttachmentFilterOption())),
        ),
        const Divider(height: 1, indent: 16),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: const Icon(Icons.mail),
          title: Text(context.l10n.mailbox_filter_unread),
          trailing: Checkbox(
            value: selectedFilterOptions.contains(const UnreadFilterOption()),
            onChanged: (value) => setState(() => selectedFilterOptions.toggle(const UnreadFilterOption())),
          ),
          onTap: () => setState(() => selectedFilterOptions.toggle(const UnreadFilterOption())),
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
                        value: selectedFilterOptions.contains(ContactFilterOption(contact.id)),
                        onChanged: (_) => setState(() => selectedFilterOptions.toggle(ContactFilterOption(contact.id))),
                      ),
                      onTap: () => setState(() => selectedFilterOptions.toggle(ContactFilterOption(contact.id))),
                      iconSize: 42,
                    );
                  },
                ),
        ),
        _ModalSheetFooter(
          applyFilters: () => context.pop(selectedFilterOptions),
          resetFilters: () => context.pop(<MailboxFilterOption>{}),
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
      children: [
        Material(
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
