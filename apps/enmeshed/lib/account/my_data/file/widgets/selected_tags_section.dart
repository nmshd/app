import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../utils/get_tag_label.dart';

class SelectedTagsSection extends StatelessWidget {
  final AttributeTagCollectionDTO tagCollection;
  final List<String> selectedTagsList;
  final void Function({required String tagPath, required bool selected})? onTagDeleted;

  const SelectedTagsSection({required this.tagCollection, required this.selectedTagsList, this.onTagDeleted, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children:
          selectedTagsList.map((tagPath) {
            final tag = _getTagByPath(context, tagCollection, tagPath);

            if (tag == null) return const SizedBox.shrink();

            return Chip(
              label: Text(
                getTagLabel(context, tagCollection, tag),
                style:
                    onTagDeleted == null
                        ? Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer)
                        : Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
              deleteIcon: onTagDeleted == null ? null : const Icon(Icons.close),
              onDeleted: onTagDeleted == null ? null : () => onTagDeleted!(tagPath: tagPath, selected: false),
              side: BorderSide.none,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            );
          }).toList(),
    );
  }

  AttributeTagDTO? _getTagByPath(BuildContext context, AttributeTagCollectionDTO tagCollection, String tagPath) {
    if (tagPath.isEmpty) return null;

    final availableTags = tagCollection.tagsForAttributeValueTypes['IdentityFileReference'] ?? {};
    if (!tagPath.contains('+%+')) return availableTags[tagPath];

    return tagPath.split('+%+').fold<AttributeTagDTO?>(null, (currentTag, part) {
      if (currentTag == null) return availableTags[part];
      return currentTag.children?[part];
    });
  }
}
