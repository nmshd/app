import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/extensions.dart';

Future<void> showLoadingDialog(BuildContext context, String text) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return PopScope(
        canPop: false,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 60, width: 60, child: CircularProgressIndicator(strokeWidth: 12)),
                const SizedBox(height: 38),
                Text(text, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showDownloadFileErrorDialog(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
        content: Text(context.l10n.error_download_file),
      );
    },
  );
}

Future<bool> showDeleteRelationshipConfirmationDialog(BuildContext context, {required String contactName, required String content}) async {
  return showConfirmationDialog(
    context,
    title: BoldStyledText(
      contactName == unknownContactName ? context.l10n.contacts_delete_title_unknown : context.l10n.contacts_delete_title(contactName),
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
    ),
    content: Text(content, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
    confirmText: context.l10n.delete,
  );
}

Future<bool> showRevokeRelationshipConfirmationDialog(BuildContext context) async {
  return showConfirmationDialog(
    context,
    title: Text(
      context.l10n.contacts_revoke_title,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
    ),
    content: Text(context.l10n.contacts_revoke_description, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
    confirmText: context.l10n.contacts_revoke_action,
  );
}

Future<bool> showConfirmationDialog(
  BuildContext context, {
  required Widget title,
  required Widget content,
  required String confirmText,
  Icon? icon,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      icon: icon,
      title: title,
      content: content,
      actions: [
        OutlinedButton(onPressed: () => context.pop(false), child: Text(context.l10n.cancel)),
        FilledButton(onPressed: () => context.pop(true), child: Text(confirmText)),
      ],
    ),
  );

  return result ?? false;
}
