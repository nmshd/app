import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/constants.dart';
import '/core/utils/extensions.dart';
import 'selected_tag_section.dart';

class FileTagsContainer extends StatelessWidget {
  final List<String>? tags;
  final AttributeTagCollectionDTO? tagCollection;
  final VoidCallback onEditFile;

  const FileTagsContainer({required this.tags, required this.tagCollection, required this.onEditFile, super.key});

  @override
  Widget build(BuildContext context) {
    if (tags == null) {
      return Container(
        padding: const EdgeInsets.only(top: 16, bottom: 24, left: 16, right: 16),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.warning_rounded, color: context.customColors.warning),
                Gaps.w8,
                Text(context.l10n.files_assignTags),
              ],
            ),
            Gaps.h16,
            Text(context.l10n.files_assignTagsDescription, style: Theme.of(context).textTheme.bodySmall),
            Gaps.h24,
            OutlinedButton(
              onPressed: onEditFile,
              child: Text(context.l10n.files_assignTagsButton),
            ),
          ],
        ),
      );
    }

    return SelectedTagSection(tagCollection: tagCollection, selectedTagsList: tags!);
  }
}
