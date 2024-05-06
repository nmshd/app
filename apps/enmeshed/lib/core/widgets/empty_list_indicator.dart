import 'package:flutter/material.dart';

import '/core/core.dart';

class EmptyListIndicator extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool wrapInListView;

  final bool isFiltered;
  final Color? backgroundColor;
  final String? filteredText;

  const EmptyListIndicator({
    required this.icon,
    required this.text,
    super.key,
    this.wrapInListView = false,
    this.isFiltered = false,
    this.backgroundColor,
    this.filteredText,
  }) : assert(isFiltered == false || filteredText != null, 'filteredText must be provided when isFiltered is true');

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? Theme.of(context).colorScheme.surface;
    final container = Container(
      width: double.infinity,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isFiltered ? Icons.filter_alt_outlined : icon, size: 40, color: Theme.of(context).colorScheme.inversePrimary),
            if (isFiltered) ...[
              Gaps.h16,
              Text(context.l10n.noEntries, style: Theme.of(context).textTheme.titleMedium),
            ],
            Gaps.h16,
            Text(isFiltered ? filteredText! : text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );

    return wrapInListView ? ListView(children: [container]) : container;
  }
}
