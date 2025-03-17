import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final String? description;
  final Color? backgroundColor;

  const InformationCard({required this.title, required this.icon, this.description, this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [icon, Gaps.w8, Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium))],
            ),
            if (description != null) ...[Gaps.h8, Text(description!, style: Theme.of(context).textTheme.bodySmall)],
          ],
        ),
      ),
    );
  }
}
