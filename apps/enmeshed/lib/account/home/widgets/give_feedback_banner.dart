import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class GiveFeedbackBanner extends StatelessWidget {
  final VoidCallback onClose;

  const GiveFeedbackBanner({required this.onClose, super.key});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: Theme.of(context).colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.push('/feedback'),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.emoji_emotions_outlined, size: 24),
              ),
              Text(context.l10n.drawer_hints_giveFeedback, style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              CloseButton(onPressed: onClose),
            ],
          ),
        ),
      ),
    );
  }
}
