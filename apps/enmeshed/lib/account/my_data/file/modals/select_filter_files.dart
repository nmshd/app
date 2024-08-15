import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../file_filter_type.dart';

void showSelectFileFilters(
  BuildContext context, {
  required Set<FileFilterType> availableFilters,
  required Set<FileFilterType> activeFilters,
  required void Function(Set<FileFilterType>) onApplyFilters,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _SelectFileFilters(availableFilters: availableFilters, onApplyFilters: onApplyFilters, activeFilters: activeFilters),
  );
}

class _SelectFileFilters extends StatefulWidget {
  final Set<FileFilterType> availableFilters;
  final Set<FileFilterType> activeFilters;
  final void Function(Set<FileFilterType>) onApplyFilters;

  const _SelectFileFilters({required this.availableFilters, required this.activeFilters, required this.onApplyFilters});

  @override
  State<_SelectFileFilters> createState() => _SelectFileFiltersState();
}

class _SelectFileFiltersState extends State<_SelectFileFilters> {
  Set<FileFilterType> _selectedFilters = {};

  @override
  void initState() {
    super.initState();

    _selectedFilters = widget.activeFilters;
  }

  @override
  Widget build(BuildContext context) {
    final availableFilters = widget.availableFilters.map((e) => (filter: e, label: e.toLabel(context))).toList()
      ..sort((a, b) {
        if (a.filter is OtherFileFilterType) return 1;
        if (b.filter is OtherFileFilterType) return -1;
        return a.label.compareTo(b.label);
      });

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
                Text(context.l10n.files_filter_title, style: Theme.of(context).textTheme.titleLarge),
                IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.files_filter_byFileType, style: Theme.of(context).textTheme.titleMedium),
                    Gaps.h32,
                    Text(context.l10n.files_filter_documentType, style: Theme.of(context).textTheme.titleSmall),
                    Gaps.h8,
                    Wrap(
                      spacing: 10,
                      children: availableFilters.map((e) {
                        return FilterChip(
                          label: Text(e.label),
                          avatar: switch (e.filter) {
                            PDFFileFilterType() => const Icon(Icons.picture_as_pdf),
                            PNGFileFilterType() || JPGFileFilterType() => const Icon(Icons.image),
                            OtherFileFilterType() => null,
                            _ => const Icon(Icons.insert_drive_file),
                          },
                          showCheckmark: false,
                          selected: _selectedFilters.contains(e.filter),
                          onSelected: (_) => setState(() => _selectedFilters.toggle(e.filter)),
                        );
                      }).toList(),
                    ),
                    Gaps.h48,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            widget.onApplyFilters({});
                            context.pop();
                          },
                          child: Text(context.l10n.reset),
                        ),
                        Gaps.w8,
                        FilledButton(
                          onPressed: () {
                            widget.onApplyFilters(_selectedFilters);
                            context.pop();
                          },
                          child: Text(context.l10n.apply_filter),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
