import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class InformationContainer extends StatelessWidget {
  final String title;
  final String? description;

  const InformationContainer({required this.title, this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary, size: 40),
                Gaps.w8,
                Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
            if (description != null) ...[Gaps.h8, Text(description!, style: Theme.of(context).textTheme.bodySmall)],
          ],
        ),
      ),
    );
  }
}
