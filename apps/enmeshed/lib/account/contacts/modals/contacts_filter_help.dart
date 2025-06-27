import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import '../contacts_filter_option.dart';

Future<void> showContactsFilterHelpModal({required BuildContext context}) async {
  await showModalBottomSheet<void>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.75),
      child: const _ContactsFilterHelpModal(),
    ),
  );
}

class _ContactsFilterHelpModal extends StatelessWidget {
  const _ContactsFilterHelpModal();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(title: context.l10n.contacts_filter_infoSheet_title),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                Text(context.l10n.contacts_filter_infoSheet_description),
                InformationCard(
                  title: context.l10n.contacts_filter_infoSheet_unconfirmed,
                  icon: Icon(ContactsFilterOption.unconfirmed.filterIcon, size: 24, color: Theme.of(context).colorScheme.secondary),
                ),
                InformationCard(
                  title: context.l10n.contacts_filter_infoSheet_actionRequired,
                  icon: Icon(ContactsFilterOption.actionRequired.filterIcon, size: 24, color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
