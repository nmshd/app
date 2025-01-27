import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../utils/get_tag_label.dart';

class SelectedTagsSection extends StatelessWidget {
  final AttributeTagCollectionDTO tagCollection;
  final List<String> selectedTagsList;

  const SelectedTagsSection({required this.tagCollection, required this.selectedTagsList, super.key});

  @override
  Widget build(BuildContext context) {
    final availableTags = tagCollection.tagsForAttributeValueTypes['IdentityFileReference'] ?? {};
    if (availableTags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 10,
      children: selectedTagsList.map((tagPath) {
        final tag = availableTags[tagPath];
        if (tag == null) return const SizedBox.shrink();

        return Chip(
          label: Text(
            getTagLabel(context, tagCollection, tag),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          side: BorderSide.none,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        );
      }).toList(),
    );
  }
}
