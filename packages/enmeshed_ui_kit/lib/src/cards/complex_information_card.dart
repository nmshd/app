import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class ComplexInformationCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final String? description;
  final Color? backgroundColor;
  final List<Widget>? actionButtons;
  final double? actionButtonSpacing;
  final MainAxisAlignment? actionButtonMainAxisAlignment;

  const ComplexInformationCard({
    required this.title,
    required this.icon,
    this.description,
    this.backgroundColor,
    this.actionButtons,
    this.actionButtonSpacing = 0,
    this.actionButtonMainAxisAlignment = MainAxisAlignment.center,
    super.key,
  });

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
              children: [icon, Gaps.w8, Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium))],
            ),
            if (description != null) ...[
              Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Text(description!, style: Theme.of(context).textTheme.bodySmall)),
            ],
            if (actionButtons != null)
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8, left: 8, right: 8),
                child: Row(mainAxisAlignment: actionButtonMainAxisAlignment!, spacing: actionButtonSpacing!, children: actionButtons!),
              ),
          ],
        ),
      ),
    );
  }
}
