import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String title;
  final String? description;
  final Icon? icon;
  final Color? backgroundColor;

  const InformationCard({required this.title, this.description, this.icon, this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    final mainIcon =
        description != null
            ? Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary, size: 40)
            : Icon(Icons.security, color: Theme.of(context).colorScheme.primary, size: 40);

    return Container(
      decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [icon ?? mainIcon, Gaps.w8, Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium))],
            ),
            if (description != null) ...[Gaps.h8, Text(description!, style: Theme.of(context).textTheme.bodySmall)],
          ],
        ),
      ),
    );
  }
}
