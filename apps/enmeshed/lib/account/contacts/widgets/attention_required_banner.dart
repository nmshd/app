import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class AttentionRequiredBanner extends StatefulWidget {
  final int numberOfContactsRequiringAttention;
  final VoidCallback showContactsRequiringAttention;

  const AttentionRequiredBanner({
    required this.numberOfContactsRequiringAttention,
    required this.showContactsRequiringAttention,
    super.key,
  });

  @override
  State<AttentionRequiredBanner> createState() => AttentionRequiredBannerState();
}

class AttentionRequiredBannerState extends State<AttentionRequiredBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.info, color: Theme.of(context).colorScheme.secondary),
              Gaps.w8,
              Expanded(
                child: Text(
                  context.l10n.contacts_require_attention(widget.numberOfContactsRequiringAttention),
                  maxLines: 2,
                ),
              ),
              Gaps.w8,
              TextButton(
                onPressed: widget.showContactsRequiringAttention,
                child: Text(
                  context.l10n.show,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
