import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class QuitCreatingMessageDialog extends StatelessWidget {
  final String accountId;

  const QuitCreatingMessageDialog({required this.accountId, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_rounded, size: 36, color: context.customColors.warning),
            Gaps.h8,
            SizedBox(
              width: 250,
              child: Text(
                context.l10n.mailbox_quitDialogTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Gaps.h16,
            Text(
              context.l10n.mailbox_quitDialogDescription,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gaps.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context
                    ..pop()
                    ..pop(),
                  child: Text(
                    context.l10n.mailbox_yesButton,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Gaps.w16,
                FilledButton(
                  onPressed: () => context.pop(),
                  child: Text(context.l10n.mailbox_noButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
