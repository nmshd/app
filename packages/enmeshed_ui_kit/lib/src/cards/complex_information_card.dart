import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class ComplexInformationCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final String? description;
  final Color? backgroundColor;
  final List<Widget>? actionButtons;

  const ComplexInformationCard({required this.title, required this.icon, this.description, this.backgroundColor, this.actionButtons, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              children: [
                icon,
                Gaps.w8,
                Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
            if (description != null) Text(description!, style: Theme.of(context).textTheme.bodySmall),
            if (actionButtons != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: actionButtons!.length > 1 ? MainAxisAlignment.end : MainAxisAlignment.center,
                  spacing: actionButtons!.length > 1 ? 8 : 0,
                  children: actionButtons!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
