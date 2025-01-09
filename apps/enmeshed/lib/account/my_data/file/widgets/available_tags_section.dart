import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/constants.dart';
import '/core/utils/extensions.dart';
import '../utils/get_tag_label.dart';

typedef AvailableTagsData = ({Map<String, AttributeTagDTO> tagsMap, String currentPath});

class AvailableTagsSection extends StatelessWidget {
  final AttributeTagCollectionDTO? tagCollection;
  final List<String> selectedTags;
  final void Function({
    required String tagPath,
    required AttributeTagDTO tagData,
    required bool selected,
  }) onTagSelected;

  const AvailableTagsSection({required this.tagCollection, required this.selectedTags, required this.onTagSelected, super.key});

  @override
  Widget build(BuildContext context) {
    if (tagCollection == null) return const SizedBox.shrink();

    final availableTagsData = _getAvailableTagsData();
    if (availableTagsData == null) return const SizedBox.shrink();

    final currentPath = availableTagsData.currentPath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.files_availableTags, style: Theme.of(context).textTheme.titleMedium),
        Gaps.h8,
        Wrap(
          spacing: 10,
          children: availableTagsData.tagsMap.entries.map((entry) {
            return FilterChip(
              label: Text(getTagLabel(context, tagCollection, entry.value)),
              selected: selectedTags.contains(entry.key.split('.').last),
              onSelected: (selected) => onTagSelected(
                tagPath: currentPath.isEmpty ? entry.key : '$currentPath.${entry.key}',
                tagData: entry.value,
                selected: selected,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  AvailableTagsData? _getAvailableTagsData() {
    var currentLevel = tagCollection!.tagsForAttributeValueTypes['IdentityFileReference'] ?? {};
    if (selectedTags.isEmpty) return (tagsMap: currentLevel, currentPath: '');

    var currentPath = '';
    for (final tag in selectedTags) {
      if (!currentLevel.containsKey(tag)) {
        return (tagsMap: currentLevel, currentPath: currentPath);
      }

      currentPath = currentPath.isEmpty ? tag : '$currentPath.$tag';
      currentLevel = currentLevel[tag]!.children ?? {};

      if (currentLevel.isEmpty) return null;
    }

    return (tagsMap: currentLevel, currentPath: currentPath);
  }
}
