import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/constants.dart';
import '/core/utils/extensions.dart';
import '../utils/get_tag_label.dart';

class SelectedTagSection extends StatelessWidget {
  final AttributeTagCollectionDTO? tagCollection;
  final List<String> selectedTagsList;
  final void Function(String)? onTagDeleted;

  const SelectedTagSection({required this.tagCollection, required this.selectedTagsList, this.onTagDeleted, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onTagDeleted != null) ...[
          Text(context.l10n.files_selectedTags, style: Theme.of(context).textTheme.titleMedium),
          Gaps.h8,
        ],
        Wrap(
          spacing: onTagDeleted == null ? 4 : 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: selectedTagsList.asMap().entries.expand<Widget>((entry) {
            final index = entry.key;
            final tagPath = entry.value;
            final tag = _getTagByPath(tagPath);
            if (tag == null) return const <Widget>[];

            return [
              Chip(
                label: Text(
                  getTagLabel(context, tagCollection, tag),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                deleteIcon: const Icon(Icons.close),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                side: BorderSide.none,
                onDeleted: onTagDeleted != null ? () => onTagDeleted!(tagPath) : null,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              ),
              if (onTagDeleted == null && index < selectedTagsList.length - 1)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
            ];
          }).toList(),
        ),
      ],
    );
  }

  AttributeTagDTO? _getTagByPath(String simplifiedTag) {
    if (tagCollection == null) return null;

    var currentLevel = tagCollection!.tagsForAttributeValueTypes['IdentityFileReference'] ?? {};

    for (var i = 0; i < selectedTagsList.length; i++) {
      final tag = selectedTagsList[i];
      if (tag == simplifiedTag) {
        if (i == 0) return currentLevel[tag];

        for (var j = 0; j < i; j++) {
          final previousTag = selectedTagsList[j];
          if (j == 0) {
            currentLevel = currentLevel[previousTag]!.children ?? {};
          } else {
            var found = false;
            currentLevel.forEach((key, value) {
              if (key.split('.').last == previousTag && !found) {
                currentLevel = value.children ?? {};
                found = true;
              }
            });
          }
        }

        AttributeTagDTO? foundTag;
        currentLevel.forEach((key, value) {
          if (key.split('.').last == tag) foundTag = value;
        });

        return foundTag;
      }
    }

    return null;
  }
}
