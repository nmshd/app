import 'package:flutter/material.dart';

import '/core/utils/extensions.dart';
import '../contacts_filter_option.dart';

class ContactsFilterBar extends StatelessWidget {
  final Set<ContactsFilterOption> selectedFilterOptions;
  final void Function(ContactsFilterOption option) removeFilter;
  final void Function() resetFilters;

  const ContactsFilterBar({
    required this.selectedFilterOptions,
    required this.removeFilter,
    required this.resetFilters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 12,
                children: [
                  for (final option in const [
                    ActionRequiredContactsFilterOption(),
                    ActiveContactsFilterOption(),
                    PendingContactsFilterOption(),
                  ])
                    if (selectedFilterOptions.contains(option)) _FilterBarFilterChip(option: option, onDeleted: () => removeFilter(option)),
                ],
              ),
            ),
            IconButton(onPressed: resetFilters, icon: const Icon(Icons.close)),
          ],
        ),
      ),
    );
  }
}

class _FilterBarFilterChip extends StatelessWidget {
  final ContactsFilterOption option;
  final VoidCallback onDeleted;

  const _FilterBarFilterChip({
    required this.option,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        switch (option) {
          ActionRequiredContactsFilterOption() => context.l10n.contacts_filterOption_actionRequired,
          ActiveContactsFilterOption() => context.l10n.contacts_filterOption_active,
          PendingContactsFilterOption() => context.l10n.contacts_filterOption_pending,
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
      onDeleted: onDeleted,
    );
  }
}
