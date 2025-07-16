import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../file_filter_type.dart';

void showSelectFileTypes(
  BuildContext context, {
  required Set<FileFilterType> availableTypes,
  required Set<FileFilterType> activeTypes,
  required void Function(Set<FileFilterType>) onApplyTypes,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _SelectFileTypes(availableTypes: availableTypes, onApplyTypes: onApplyTypes, activeTypes: activeTypes),
  );
}

class _SelectFileTypes extends StatefulWidget {
  final Set<FileFilterType> availableTypes;
  final Set<FileFilterType> activeTypes;
  final void Function(Set<FileFilterType>) onApplyTypes;

  const _SelectFileTypes({required this.availableTypes, required this.activeTypes, required this.onApplyTypes});

  @override
  State<_SelectFileTypes> createState() => _SelectFileTypesState();
}

class _SelectFileTypesState extends State<_SelectFileTypes> {
  Set<FileFilterType> _selectedFilters = {};

  @override
  void initState() {
    super.initState();

    _selectedFilters = widget.activeTypes;
  }

  @override
  Widget build(BuildContext context) {
    final availableFilters = widget.availableTypes.map((e) => (filter: e, label: e.toLabel(context))).toList()
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
                Text(context.l10n.files_filter_byFileType, style: Theme.of(context).textTheme.titleLarge),
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
                    Wrap(
                      spacing: 10,
                      children: availableFilters.map((e) {
                        return FilterChip(
                          label: Text(e.label),
                          shape: const StadiumBorder(),
                          avatar: switch (e.filter) {
                            PDFFileFilterType() => Icon(Icons.picture_as_pdf, color: Theme.of(context).colorScheme.onSurface),
                            PNGFileFilterType() || JPGFileFilterType() => Icon(Icons.image, color: Theme.of(context).colorScheme.onSurface),
                            OtherFileFilterType() => null,
                            _ => Icon(Icons.insert_drive_file, color: Theme.of(context).colorScheme.onSurface),
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
                          onPressed: () => context.pop(),
                          child: Text(context.l10n.cancel),
                        ),
                        Gaps.w8,
                        FilledButton(
                          onPressed: () {
                            widget.onApplyTypes(_selectedFilters);
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
