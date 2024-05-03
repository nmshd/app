import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class SelectAttachmentsScreen extends StatefulWidget {
  final List<FileDVO> previouslySelectedAttachments;
  final String accountId;

  const SelectAttachmentsScreen({
    required this.previouslySelectedAttachments,
    required this.accountId,
    super.key,
  });

  @override
  State<SelectAttachmentsScreen> createState() => _SelectAttachmentsScreenState();
}

class _SelectAttachmentsScreenState extends State<SelectAttachmentsScreen> {
  List<FileDVO> _selectedAttachments = [];
  List<FileDVO>? _possibleAttachments;

  @override
  void initState() {
    super.initState();

    _selectedAttachments = [...widget.previouslySelectedAttachments];
    _loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(context.l10n.mailbox_addFile),
      leading: BackButton(onPressed: () => context.pop(widget.previouslySelectedAttachments)),
      actions: [IconButton(onPressed: _uploadFile, icon: const Icon(Icons.file_upload_outlined))],
    );

    if (_possibleAttachments == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    if (_possibleAttachments!.isEmpty) {
      return Scaffold(
        appBar: appBar,
        body: EmptyListIndicator(
          icon: Icons.file_copy,
          text: context.l10n.files_noFilesAvailable,
          wrapInListView: true,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: appBar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Text(context.l10n.mailbox_selectFromExistingFiles, style: Theme.of(context).textTheme.bodyMedium),
            ),
            Gaps.h8,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final file = _possibleAttachments![index];

                  return ListTile(
                    selectedColor: Theme.of(context).colorScheme.onPrimary,
                    contentPadding: const EdgeInsets.only(left: 16, right: 8),
                    leading: FileIcon(filename: file.filename),
                    title: Text(file.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: file.name != file.filename ? Text(file.filename, maxLines: 1, overflow: TextOverflow.ellipsis) : null,
                    trailing: Checkbox(
                      onChanged: (value) => setState(() => _selectedAttachments.toggle(file)),
                      value: _selectedAttachments.contains(file),
                    ),
                    onTap: () => setState(() => _selectedAttachments.toggle(file)),
                  );
                },
                itemCount: _possibleAttachments!.length,
                separatorBuilder: (context, index) => const Divider(height: 0, indent: 16, endIndent: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(context.l10n.cancel),
                    onPressed: () => context.pop(widget.previouslySelectedAttachments),
                  ),
                  Gaps.w16,
                  FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: () => context.pop(_selectedAttachments),
                    child: Text(context.l10n.mailbox_add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadFiles() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final filesResult = await session.transportServices.files.getFiles();
    final files = await session.expander.expandFileDTOs(filesResult.value);

    if (mounted) {
      setState(() {
        _possibleAttachments = files;
      });
    }
  }

  Future<void> _uploadFile() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => UploadFile(accountId: widget.accountId, onFileUploaded: (_) => _loadFiles()),
    );
  }
}

extension _Toggle<T> on List<T> {
  void toggle(T value) {
    contains(value) ? remove(value) : add(value);
  }
}
