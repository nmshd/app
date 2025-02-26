import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class InformationContainer extends StatelessWidget {
  final String title;
  final bool warning;
  final String? description;

  const InformationContainer({required this.title, required this.warning, this.description, super.key});

  @override
  Widget build(BuildContext context) {
    final boxColor = warning ? Theme.of(context).colorScheme.surfaceContainer : Theme.of(context).colorScheme.primaryContainer;
    final textColor = warning ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.onPrimaryContainer;

    return Container(
      decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (warning)
                  Icon(Icons.warning_amber_rounded, color: context.customColors.warning, size: 40)
                else
                  Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary, size: 40),
                Gaps.w8,
                Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor))),
              ],
            ),
            if (description != null) ...[Gaps.h8, Text(description!, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: textColor))],
          ],
        ),
      ),
    );
  }
}
