import 'dart:async';

import 'package:enmeshed/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:go_router/go_router.dart';

class FeedbackErrorDialog extends StatelessWidget {
  final Email email;

  const FeedbackErrorDialog({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 24),
      title: Text(context.l10n.giveFeedback_error_title),
      content: Text(context.l10n.giveFeedback_error_description, textAlign: TextAlign.center),
      actions: [
        OutlinedButton(
          onPressed: () => context.pop(),
          child: Text(context.l10n.cancel),
        ),
        FilledButton(
          onPressed: () async {
            final success = await _sendEmail();
            if (!success || !context.mounted) return;

            context.pop();
            unawaited(context.push('/feedback/success'));
          },
          child: Text(context.l10n.giveFeedback_error_tryAgain),
        ),
      ],
    );
  }

  Future<bool> _sendEmail() async {
    try {
      await FlutterEmailSender.send(email);
      return true;
    } catch (_) {
      return false;
    }
  }
}
