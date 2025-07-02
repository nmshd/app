import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import '../contacts_filter_option.dart';
import '../modals/modals.dart';

class ContactsFilterBar extends StatelessWidget {
  final ContactsFilterOption selectedFilterOption;
  final void Function(ContactsFilterOption option) setFilter;

  const ContactsFilterBar({required this.selectedFilterOption, required this.setFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return FilterChipBar(
      onInfoPressed: () => showContactsFilterHelpModal(context: context),
      children: [
        for (final option in ContactsFilterOption.values)
          CondensedFilterChip(
            onPressed: () => setFilter(option),
            icon: option.filterIcon,
            label: switch (option) {
              ContactsFilterOption.all => context.l10n.contacts_filterOption_all,
              ContactsFilterOption.active => context.l10n.contacts_filterOption_active,
              ContactsFilterOption.actionRequired => context.l10n.contacts_filterOption_actionRequired,
            },
            isSelected: selectedFilterOption == option,
            foregroundColor: switch (option) {
              ContactsFilterOption.actionRequired => Theme.of(context).colorScheme.error,
              _ => null,
            },
            backgroundColor: switch (option) {
              ContactsFilterOption.actionRequired => Theme.of(context).colorScheme.errorContainer,
              _ => null,
            },
          ),
      ],
    );
  }
}
