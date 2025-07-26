import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import '../files_filter_option.dart';

Future<void> showFilesFilterHelpModal({required BuildContext context}) async {
  await showModalBottomSheet<void>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.75),
      child: const _FilessFilterHelpModal(),
    ),
  );
}

class _FilessFilterHelpModal extends StatelessWidget {
  const _FilessFilterHelpModal();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(title: context.l10n.files_filter_infoSheet_title),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                Text(context.l10n.files_filter_infoSheet_description),
                InformationCard(
                  title: context.l10n.files_filter_infoSheet_unviewed,
                  icon: Icon(FilesFilterOption.unviewed.filterIcon, size: 24, color: Theme.of(context).colorScheme.secondary),
                ),
                InformationCard(
                  title: context.l10n.files_filter_infoSheet_expired,
                  icon: Icon(FilesFilterOption.expired.filterIcon, size: 24, color: Theme.of(context).colorScheme.error),
                ),
                InformationCard(
                  title: context.l10n.files_filter_infoSheet_type,
                  icon: Icon(FilesFilterOption.type.filterIcon, size: 24, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                InformationCard(
                  title: context.l10n.files_filter_infoSheet_tag,
                  icon: Icon(FilesFilterOption.tag.filterIcon, size: 24, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
