import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/core.dart';

class FilesScreen extends StatefulWidget {
  final String accountId;

  const FilesScreen({required this.accountId, super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  List<FileDVO>? _files;

  @override
  void initState() {
    super.initState();

    _loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(context.l10n.files),
      actions: [IconButton(onPressed: _uploadFile, icon: const Icon(Icons.file_upload_outlined))],
    );

    if (_files == null) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _loadFiles(syncBefore: true),
          child: _files!.isEmpty
              ? EmptyListIndicator(icon: Icons.file_copy, text: context.l10n.files_noFilesAvailable, wrapInListView: true)
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final file = _files![index];
                    return FileItem(accountId: widget.accountId, file: file);
                  },
                  itemCount: _files!.length,
                  separatorBuilder: (context, index) => const Divider(height: 0),
                ),
        ),
      ),
    );
  }

  Future<void> _loadFiles({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final filesResult = await session.transportServices.files.getFiles();
    final files = await session.expander.expandFileDTOs(filesResult.value);

    if (mounted) setState(() => _files = files);
  }

  void _uploadFile() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => UploadFile(accountId: widget.accountId, onFileUploaded: (_) => _loadFiles()),
    );
  }
}
