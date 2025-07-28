import 'dart:async';

import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../utils/utils.dart';

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
          onPressed: () async => feedbackMailUri == null ? _giveFeedback(context) : await _reSendMail(context),
          child: Text(context.l10n.giveFeedback_error_tryAgain),
        ),
      ],
    );
  }

  void _giveFeedback(BuildContext context) => context
    ..pop()
    ..giveFeedback(accountId);

  Future<void> _reSendMail(BuildContext context) async {
    if (feedbackMailUri == null) return;

    final urlLauncher = GetIt.I.get<AbstractUrlLauncher>();

    final canLaunch = await urlLauncher.canLaunchUrl(feedbackMailUri!);
    if (!canLaunch) return;

    try {
      await urlLauncher.launchUrl(feedbackMailUri!);
    } catch (e) {
      GetIt.I.get<Logger>().e('Failed to launch email: $e');
      return;
    }

    if (!context.mounted) return;

    context.pop();
    unawaited(context.push('/account/$accountId/feedback/success'));
  }
}
