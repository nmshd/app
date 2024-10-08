import 'package:flutter/material.dart';

import '/core/core.dart';

class EmptyListIndicator extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool wrapInListView;
  final bool isFiltered;
  final Color? backgroundColor;
  final String? filteredText;
  final String? description;
  final Widget? action;

  const EmptyListIndicator({
    required this.icon,
    required this.text,
    this.wrapInListView = false,
    this.isFiltered = false,
    this.backgroundColor,
    this.filteredText,
    this.description,
    this.action,
    super.key,
  }) : assert(isFiltered == false || filteredText != null, 'filteredText must be provided when isFiltered is true');

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: double.infinity,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isFiltered ? Icons.filter_alt_outlined : icon, size: 40, color: Theme.of(context).colorScheme.primaryContainer),
            if (isFiltered) ...[
              Gaps.h16,
              Text(context.l10n.noEntries, style: Theme.of(context).textTheme.titleMedium),
            ],
            Gaps.h16,
            Text(
              isFiltered ? filteredText! : text,
              style: description != null ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              Gaps.h8,
              Text(description!, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            ],
            if (action != null) ...[Gaps.h12, action!],
          ],
        ),
      ),
    );

    return wrapInListView ? ListView(children: [container]) : container;
  }
}
