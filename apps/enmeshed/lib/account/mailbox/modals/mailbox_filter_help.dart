import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import '../mailbox_filter_option.dart';

Future<void> showMailboxFilterHelpModal({
  required BuildContext context,
}) {
  final options = showModalBottomSheet<void>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.75),
      child: const _MailboxFilterHelpModal(),
    ),
  );

  return options;
}

class _MailboxFilterHelpModal extends StatelessWidget {
  const _MailboxFilterHelpModal();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(title: context.l10n.mailbox_filter_infoSheet_title),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              spacing: 32,
              children: [
                Text(context.l10n.mailbox_filter_infoSheet_description),
                InformationCard(
                  title: context.l10n.mailbox_filter_infoSheet_incoming,
                  icon: Icon(MailboxFilterOption.incoming.filterIcon, size: 24, color: Theme.of(context).colorScheme.secondary),
                ),
                InformationCard(
                  title: context.l10n.mailbox_filter_infoSheet_actionRequired,
                  icon: Icon(MailboxFilterOption.actionRequired.filterIcon, size: 24, color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
