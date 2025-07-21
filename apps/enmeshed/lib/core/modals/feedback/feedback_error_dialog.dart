import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';

import '../../utils/extensions.dart';

class FeedbackErrorDialog extends StatelessWidget {
  final String accountId;
  final Uri? feedbackMailUri;

  const FeedbackErrorDialog({required this.accountId, required this.feedbackMailUri, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 24),
      title: Text(context.l10n.giveFeedback_error_title),
      content: Text(context.l10n.giveFeedback_error_description, textAlign: TextAlign.center),
      actions: [
        OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
        FilledButton(
          onPressed: () async {
            final success = await _sendEmail();
            if (!success || !context.mounted) return;

            context.pop();
            unawaited(context.push('/account/$accountId/feedback/success'));
          },
          child: Text(context.l10n.giveFeedback_error_tryAgain),
        ),
      ],
    );
  }

  Future<bool> _sendEmail() async {
    if (feedbackMailUri == null) return false;

    final urlLauncher = GetIt.I.get<AbstractUrlLauncher>();

    final canLaunch = await urlLauncher.canLaunchUrl(feedbackMailUri!);
    if (!canLaunch) return false;

    try {
      await urlLauncher.launchUrl(feedbackMailUri!);
      return true;
    } catch (e) {
      GetIt.I.get<Logger>().e('Failed to launch email: $e');
      return false;
    }
  }
}
