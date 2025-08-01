import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import '../files_filter_option.dart';
import '../modals/files_filter_help.dart';

class FilesFilterChipBar extends StatelessWidget {
  final FilesFilterOption selectedFilterOption;
  final Future<void> Function(FilesFilterOption option) setFilter;
  final bool typeFiltersActive;
  final bool tagFiltersActive;
  final bool selectTagsEnabled;
  final bool selectTypesEnabled;
  final VoidCallback showTags;
  final VoidCallback showTypes;

  const FilesFilterChipBar({
    required this.selectedFilterOption,
    required this.setFilter,
    required this.typeFiltersActive,
    required this.tagFiltersActive,
    required this.selectTagsEnabled,
    required this.selectTypesEnabled,
    required this.showTags,
    required this.showTypes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChipBar(
      onInfoPressed: () => showFilesFilterHelpModal(context: context),
      children: [
        for (final option in FilesFilterOption.values)
          _FilesCondensedFilterChip(
            onPressed: () => switch (option) {
              FilesFilterOption.tag => selectTagsEnabled ? showTags() : null,
              FilesFilterOption.type => selectTypesEnabled ? showTypes() : null,
              _ => setFilter(option),
            },
            icon: option.filterIcon,
            filterOption: option,
            isTagBadgeVisible: tagFiltersActive,
            isTypeBadgeVisible: typeFiltersActive,
            label: switch (option) {
              FilesFilterOption.all => context.l10n.files_filterOption_all,
              FilesFilterOption.unviewed => context.l10n.files_filterOption_new,
              FilesFilterOption.expired => context.l10n.files_filterOption_expired,
              _ => null,
            },
            isSelected: selectedFilterOption == option,
            foregroundColor: switch (option) {
              FilesFilterOption.unviewed => Theme.of(context).colorScheme.secondary,
              FilesFilterOption.expired => Theme.of(context).colorScheme.error,
              _ => Theme.of(context).colorScheme.onSurfaceVariant,
            },
            backgroundColor: switch (option) {
              FilesFilterOption.unviewed => Theme.of(context).colorScheme.secondaryContainer,
              FilesFilterOption.expired => Theme.of(context).colorScheme.errorContainer,
              _ => Theme.of(context).colorScheme.surfaceContainerHighest,
            },
          ),
      ],
    );
  }
}

class _FilesCondensedFilterChip extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool isSelected;
  final bool isTagBadgeVisible;
  final bool isTypeBadgeVisible;
  final FilesFilterOption filterOption;
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const _FilesCondensedFilterChip({
    required this.onPressed,
    required this.icon,
    required this.isSelected,
    required this.isTagBadgeVisible,
    required this.isTypeBadgeVisible,
    required this.filterOption,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest;
    final foregroundColor = this.foregroundColor ?? Theme.of(context).colorScheme.onSurface;

    final icon = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Icon(this.icon, size: 18, color: foregroundColor),
    );

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: switch (filterOption) {
          FilesFilterOption.type || FilesFilterOption.tag => onPressed,
          _ => isSelected ? null : onPressed,
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: isSelected
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        icon,
                        if (label != null)
                          Text(
                            label!,
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: foregroundColor),
                          ),
                      ],
                    )
                  : icon,
            ),

            if (isTagBadgeVisible && filterOption == FilesFilterOption.tag || isTypeBadgeVisible && filterOption == FilesFilterOption.type)
              Positioned(
                top: -1,
                right: -1,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, shape: BoxShape.circle),
                  child: Badge(backgroundColor: Theme.of(context).colorScheme.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
