import 'package:flutter/material.dart';

import '../file_filter_type.dart';

class ActiveTypesAndTagsBar extends StatelessWidget {
  final Set<FileFilterType> activeTypes;
  final Set<String> activeTags;
  final void Function(FileFilterType) onRemoveType;
  final void Function(String) onRemoveTag;

  const ActiveTypesAndTagsBar({
    required this.activeTypes,
    required this.activeTags,
    required this.onRemoveType,
    required this.onRemoveTag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typeChips = activeTypes.map((e) => (filter: e, label: e.toLabel(context))).toList()
      ..sort((a, b) {
        if (a.filter is OtherFileFilterType) return 1;
        if (b.filter is OtherFileFilterType) return -1;
        return a.label.compareTo(b.label);
      });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...typeChips.map(
              (e) => Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 2,
                children: [
                  Text(e.label, style: Theme.of(context).textTheme.labelSmall),
                  GestureDetector(child: const Icon(Icons.close, size: 16), onTap: () => onRemoveType(e.filter)),
                ],
              ),
            ),
            ...activeTags.map(
              (tag) => Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 2,
                children: [
                  Text(tag, style: Theme.of(context).textTheme.labelSmall),
                  GestureDetector(child: const Icon(Icons.close, size: 16), onTap: () => onRemoveTag(tag)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
