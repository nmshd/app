import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../utils/get_tag_label.dart';

class AvailableTagsSection extends StatelessWidget {
  final AttributeTagCollectionDTO tagCollection;
  final List<String> selectedTags;
  final void Function({
    required String tagPath,
    required bool selected,
  }) onTagSelected;

  const AvailableTagsSection({required this.tagCollection, required this.selectedTags, required this.onTagSelected, super.key});

  @override
  Widget build(BuildContext context) {
    final availableTags = tagCollection.tagsForAttributeValueTypes['IdentityFileReference'] ?? {};
    if (availableTags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 10,
      children: availableTags.entries.map((entry) {
        return ChoiceChip(
          label: Text(getTagLabel(context, tagCollection, entry.value)),
          selected: selectedTags.contains(entry.key),
          showCheckmark: false,
          onSelected: (selected) => onTagSelected(tagPath: entry.key, selected: selected),
        );
      }).toList(),
    );
  }
}
