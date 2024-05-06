import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';
import 'extensions.dart';

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

Future<void> showWrongTokenErrorDialog(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (_) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.clear, color: Theme.of(context).colorScheme.error, size: 90),
              Gaps.h16,
              Text(
                context.l10n.scanner_invalidCode,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
              Gaps.h16,
              OutlinedButton(
                onPressed: () => context.pop(),
                child: Text(context.l10n.tryAgain),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showNotImplementedDialog(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (_) => const _NotImplementedDialog(),
  );
}

class _NotImplementedDialog extends StatelessWidget {
  const _NotImplementedDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_rounded, size: 36, color: context.customColors.warningIcon),
                Gaps.h8,
                SizedBox(
                  width: 250,
                  child: Text(context.l10n.notImplemented, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
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
