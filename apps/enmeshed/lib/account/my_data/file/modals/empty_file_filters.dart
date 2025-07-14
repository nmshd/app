import 'package:enmeshed/core/core.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showEmptyFileFilters(
  BuildContext context, {
  required String title,
  required String description,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _EmptyFileFilters(title: title, description: description),
  );
}

class _EmptyFileFilters extends StatelessWidget {
  final String title;
  final String description;

  const _EmptyFileFilters({required this.title, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: Theme.of(context).textTheme.bodyMedium),
                Gaps.h32,
                FilledButton(onPressed: () => context.pop(), child: Text(context.l10n.error_understood)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
