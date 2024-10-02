import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../contacts_filter_controller.dart';
import '../contacts_filter_option.dart';

Future<Set<ContactsFilterOption>?> showSelectContactsFiltersModal({
  required ContactsFilterController contactsFilterController,
  required BuildContext context,
}) {
  final options = showModalBottomSheet<Set<ContactsFilterOption>?>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    builder: (context) => _SelectContactFilters(contactsFilterController: contactsFilterController),
  );

  return options;
}

class _SelectContactFilters extends StatefulWidget {
  final ContactsFilterController contactsFilterController;

  const _SelectContactFilters({required this.contactsFilterController});

  @override
  State<_SelectContactFilters> createState() => _SelectContactFiltersState();
}

class _SelectContactFiltersState extends State<_SelectContactFilters> {
  Set<ContactsFilterOption> _selectedFilters = {};

  @override
  void initState() {
    super.initState();

    _selectedFilters = {...widget.contactsFilterController.value};
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.contacts_filter_title, style: Theme.of(context).textTheme.titleLarge),
                IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.contacts_filter_byContactStatus, style: Theme.of(context).textTheme.titleMedium),
                    Gaps.h8,
                    Wrap(
                      spacing: 10,
                      children: [
                        FilterChip(
                          label: Text(context.l10n.contacts_filterOption_actionRequired),
                          showCheckmark: false,
                          selected: _selectedFilters.contains(const ActionRequiredContactsFilterOption()),
                          onSelected: (_) => setState(() => _selectedFilters.toggle(const ActionRequiredContactsFilterOption())),
                        ),
                        FilterChip(
                          label: Text(context.l10n.contacts_filterOption_active),
                          showCheckmark: false,
                          selected: _selectedFilters.contains(const ActiveContactsFilterOption()),
                          onSelected: (_) => setState(() => _selectedFilters.toggle(const ActiveContactsFilterOption())),
                        ),
                        FilterChip(
                          label: Text(context.l10n.contacts_filterOption_pending),
                          showCheckmark: false,
                          selected: _selectedFilters.contains(const PendingContactsFilterOption()),
                          onSelected: (_) => setState(() => _selectedFilters.toggle(const PendingContactsFilterOption())),
                        ),
                      ],
                    ),
                    Gaps.h48,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => context.pop(<ContactsFilterOption>{}),
                          child: Text(context.l10n.reset),
                        ),
                        Gaps.w8,
                        FilledButton(
                          onPressed: () => context.pop(_selectedFilters),
                          child: Text(context.l10n.apply_filter),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
