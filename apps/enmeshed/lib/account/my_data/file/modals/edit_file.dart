import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../widgets/available_tags_section.dart';
import '../widgets/selected_tag_section.dart';

class EditFile extends StatefulWidget {
  final String accountId;
  final String fileTitle;
  final LocalAttributeDVO fileReferenceAttribute;
  final void Function({String? attributeId}) onSave;
  final AttributeTagCollectionDTO? tagCollection;

  const EditFile({
    required this.accountId,
    required this.fileTitle,
    required this.fileReferenceAttribute,
    required this.onSave,
    this.tagCollection,
    super.key,
  });

  @override
  State<EditFile> createState() => _EditFileState();
}

class _EditFileState extends State<EditFile> {
  late final TextEditingController _titleController;
  bool _loading = false;

  String _selectedTags = '';

  List<String> get _selectedTagsList => _selectedTags.isEmpty ? [] : _selectedTags.split('+%+');

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.fileTitle)..addListener(() => setState(() {}));
    if (widget.fileReferenceAttribute.tags != null && widget.fileReferenceAttribute.tags!.isNotEmpty) {
      _selectedTags = widget.fileReferenceAttribute.tags!.first;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.files_editFile, style: Theme.of(context).textTheme.titleLarge),
              Gaps.h24,
              Text(context.l10n.mandatoryField),
              Gaps.h24,
              TextField(
                controller: _titleController,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: const IconButton(onPressed: null, icon: Icon(Icons.cancel_outlined)),
                  labelText: context.l10n.title,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              Gaps.h40,
              Text(context.l10n.files_tags, style: Theme.of(context).textTheme.titleMedium),
              Gaps.h24,
              Text(context.l10n.files_assignTagsDescription, style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 0.4)),
              Gaps.h24,
              if (_selectedTags.isNotEmpty) ...[
                SelectedTagSection(
                  tagCollection: widget.tagCollection,
                  selectedTagsList: _selectedTagsList,
                  onTagDeleted: (tagPath) {
                    setState(() {
                      final tagIndex = _selectedTagsList.indexOf(tagPath);
                      if (tagIndex != -1) {
                        _selectedTags = tagIndex == 0 ? '' : _selectedTagsList.take(tagIndex).join('+%+');
                      }
                    });
                  },
                ),
              ],
              if (widget.tagCollection != null) ...[
                Gaps.h24,
                AvailableTagsSection(
                  tagCollection: widget.tagCollection,
                  selectedTags: _selectedTagsList,
                  onTagSelected: _handleTagSelected,
                ),
              ],
              Gaps.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.l10n.cancel)),
                  Gaps.w8,
                  FilledButton(onPressed: _confirmEnabled ? _confirm : null, child: Text(context.l10n.save)),
                ],
              ),
            ],
          ),
        ),
        if (_loading) ModalLoadingOverlay(text: context.l10n.files_saving, isDialog: false),
      ],
    );
  }

  bool get _confirmEnabled => _titleController.text.isNotEmpty;

  Future<void> _confirm() async {
    if (_confirmEnabled) setState(() => _loading = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final succeedAttributeResult = await session.consumptionServices.attributes.succeedRepositoryAttribute(
      predecessorId: widget.fileReferenceAttribute.id,
      value: (widget.fileReferenceAttribute as RepositoryAttributeDVO).value as IdentityFileReferenceAttributeValue,
      tags: [_selectedTags],
    );

    if (succeedAttributeResult.isError) {
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
            content: Text(context.l10n.error_succeedAttribute),
          );
        },
      );

      setState(() => _loading = false);
      return;
    }

    widget.onSave(attributeId: succeedAttributeResult.value.successor.id);
    if (mounted) context.pop();
  }

  void _handleTagSelected({
    required String tagPath,
    required AttributeTagDTO tagData,
    required bool selected,
  }) {
    if (selected) {
      final pathParts = tagPath.split('.');
      final lastPart = pathParts.last;

      if (_selectedTagsList.isEmpty) {
        setState(() => _selectedTags = pathParts.first);

        return;
      }

      setState(() => _selectedTags = [..._selectedTagsList, lastPart].join('+%+'));
    } else {
      final pathParts = tagPath.split('.');
      final lastPart = pathParts.last;

      final tagIndex = _selectedTagsList.indexOf(lastPart);
      if (tagIndex != -1) setState(() => _selectedTags = tagIndex == 0 ? '' : _selectedTagsList.take(tagIndex).join('+%+'));
    }
  }
}
