import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '../utils/get_tag_label.dart';
import 'widgets.dart';

class MultiStageTagsSection extends StatefulWidget {
  final AttributeTagCollectionDTO tagCollection;
  final List<String> selectedTags;
  final void Function({required String tagPath, required bool selected}) handleTagSelection;

  const MultiStageTagsSection({required this.tagCollection, required this.selectedTags, required this.handleTagSelection, super.key});

  @override
  State<MultiStageTagsSection> createState() => _MultiStageTagsSectionState();
}

class _MultiStageTagsSectionState extends State<MultiStageTagsSection> {
  String _tagString = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.selectedTags.isNotEmpty)
          SelectedTagsSection(tagCollection: widget.tagCollection, selectedTagsList: widget.selectedTags, onTagDeleted: widget.handleTagSelection),

        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              _tagString = '';

              final button = context.findRenderObject()! as RenderBox;
              final position = button.localToGlobal(Offset.zero);
              final overlay = Overlay.of(context).context.findRenderObject()! as RenderBox;
              final relativePosition = position - overlay.localToGlobal(Offset.zero);

              final availableTags = widget.tagCollection.tagsForAttributeValueTypes['IdentityFileReference'] ?? {};
              _showTagMenu(context, availableTags, relativePosition, button.size.height);
            },
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(20)),
                child: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showTagMenu(BuildContext context, Map<String, AttributeTagDTO> tags, Offset position, double buttonHeight, {bool isFirstLevel = true}) {
    final overlay = Overlay.of(context).context.findRenderObject()! as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect((position + Offset(0, buttonHeight)) & Size.zero, Offset.zero & overlay.size),
      useRootNavigator: true,
      items:
          tags.entries.map((entry) {
            final hasChildren = entry.value.children != null && entry.value.children!.isNotEmpty;

            return PopupMenuItem<String>(
              onTap: () {
                if (hasChildren) {
                  _tagString = isFirstLevel ? entry.key : _tagString = '$_tagString+%+${entry.key}';

                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (context.mounted) _showTagMenu(context, entry.value.children!, position, buttonHeight, isFirstLevel: false);
                  });
                } else {
                  _tagString = '$_tagString+%+${entry.key}';
                  if (!widget.selectedTags.any((tag) => tag == _tagString)) widget.handleTagSelection(tagPath: _tagString, selected: true);
                }
              },
              child: Row(
                children: [
                  Expanded(child: Text(getTagLabel(context, widget.tagCollection, entry.value), style: Theme.of(context).textTheme.bodyMedium)),
                  Gaps.w8,
                  if (hasChildren) const Icon(Icons.chevron_right),
                  if (!hasChildren && widget.selectedTags.any((tag) => tag == '$_tagString+%+${entry.key}')) const Icon(Icons.check),
                ],
              ),
            );
          }).toList(),
    );
  }
}
