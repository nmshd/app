import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../widgets/widgets.dart';

class EditFile extends StatefulWidget {
  final String accountId;
  final String fileTitle;
  final LocalAttributeDVO fileReferenceAttribute;
  final void Function({String? attributeId}) onSave;
  final AttributeTagCollectionDTO tagCollection;

  const EditFile({
    required this.accountId,
    required this.fileTitle,
    required this.fileReferenceAttribute,
    required this.onSave,
    required this.tagCollection,
    super.key,
  });

  @override
  State<EditFile> createState() => _EditFileState();
}

class _EditFileState extends State<EditFile> {
  late final TextEditingController _titleController;
  bool _loading = false;

  List<String> _selectedTags = [];

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.fileTitle)..addListener(() => setState(() {}));
    if (widget.fileReferenceAttribute.tags != null && widget.fileReferenceAttribute.tags!.isNotEmpty) {
      _selectedTags = widget.fileReferenceAttribute.tags!;
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
              Gaps.h24,
              Text(context.l10n.files_assignTags, style: Theme.of(context).textTheme.titleMedium),
              if (_isMultiStageTag) ...[
                if (_selectedTags.isEmpty) Gaps.h8 else Gaps.h24,
                MultiStageTagsSection(tagCollection: widget.tagCollection, selectedTags: _selectedTags, handleTagSelection: _handleTagSelection),
                const Spacer(),
              ] else ...[
                Gaps.h24,
                AvailableTagsSection(tagCollection: widget.tagCollection, selectedTags: _selectedTags, onTagSelected: _handleTagSelection),
              ],
              Gaps.h40,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.l10n.cancel)),
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

  bool get _isMultiStageTag => widget.tagCollection.tagsForAttributeValueTypes.values.any(
    (tags) => tags.values.any((tag) => tag.children != null && tag.children!.isNotEmpty),
  );

  Future<void> _confirm() async {
    if (_confirmEnabled) setState(() => _loading = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final succeedAttributeResult = await session.consumptionServices.attributes.succeedRepositoryAttribute(
      predecessorId: widget.fileReferenceAttribute.id,
      value: (widget.fileReferenceAttribute as RepositoryAttributeDVO).value as IdentityFileReferenceAttributeValue,
      tags: _selectedTags,
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

  void _handleTagSelection({required String tagPath, required bool selected}) {
    setState(() {
      if (selected) {
        _selectedTags = [..._selectedTags, tagPath];
      } else {
        _selectedTags = _selectedTags.where((tag) => tag != tagPath).toList();
      }
    });
  }
}
