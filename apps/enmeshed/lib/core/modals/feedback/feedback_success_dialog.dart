import 'package:enmeshed/core/utils/utils.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedbackSuccessDialog extends StatelessWidget {
  const FeedbackSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.check_circle, color: context.customColors.success, size: 24),
      title: Text(context.l10n.giveFeedback_success_title),
      content: Text(context.l10n.giveFeedback_success_description, textAlign: TextAlign.center),
      actions: [
        OutlinedButton(
          onPressed: () => context
            ..pop()
            ..giveFeedback(),
          child: Text(context.l10n.giveFeedback_success_newFeedback),
        ),
        FilledButton(
          onPressed: () => context.pop(),
          child: Text(context.l10n.close),
        ),
      ],
    );
  }
}
