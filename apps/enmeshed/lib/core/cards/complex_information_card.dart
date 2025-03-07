import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class ComplexInformationCard extends StatelessWidget {
  final String title;
  final String? description;
  final Icon? icon;
  final Color? backgroundColor;
  final Widget? actionButtons;

  const ComplexInformationCard({required this.title, this.description, this.icon, this.backgroundColor, this.actionButtons, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon ?? Icon(Icons.error, color: Theme.of(context).colorScheme.error),
                Gaps.w8,
                Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
            if (description != null) ...[
              Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Text(description!, style: Theme.of(context).textTheme.bodySmall)),
            ],
            if (actionButtons != null) Padding(padding: const EdgeInsets.only(top: 24, bottom: 8, left: 8, right: 8), child: actionButtons),
          ],
        ),
      ),
    );
  }
}
