import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

Future<FileDVO?> openFileChooser(BuildContext context, String accountId) {
  final file = showModalBottomSheet<FileDVO?>(
    context: context,
    builder: (context) => FileChooser(accountId: accountId),
  );

  return file;
}

enum _FileChooserMode { existing, create }

class FileChooser extends StatefulWidget {
  final String accountId;

  const FileChooser({required this.accountId, super.key});

  @override
  State<FileChooser> createState() => _FileChooserState();
}

class _FileChooserState extends State<FileChooser> {
  _FileChooserMode _mode = _FileChooserMode.existing;
  List<FileDVO>? _existingFiles;

  @override
  void initState() {
    super.initState();

    _reload();
  }

  @override
  Widget build(BuildContext context) {
    if (_existingFiles == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_mode == _FileChooserMode.existing) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8, top: 8),
            child: Row(
              children: [
                Text(context.l10n.fileChooser_title, style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _mode = _FileChooserMode.create),
                  icon: const Icon(Icons.upload),
                  label: Text(context.l10n.fileChooser_uploadFile),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: _existingFiles!.isEmpty
                  ? EmptyListIndicator(icon: Icons.file_copy, text: context.l10n.fileChooser_noFilesFound)
                  : Scrollbar(
                      thumbVisibility: true,
                      child: ListView.separated(
                        clipBehavior: Clip.antiAlias,
                        itemCount: _existingFiles!.length,
                        itemBuilder: (context, index) {
                          final file = _existingFiles![index];

                          return ListTile(
                            title: Text(file.title),
                            subtitle: Text(file.filename),
                            onTap: () => context.pop(file),
                            trailing: const Icon(Icons.chevron_right),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(height: 0, indent: 16, endIndent: 16),
                      ),
                    ),
            ),
          ),
        ],
      );
    }

    return UploadFile(
      accountId: widget.accountId,
      onFileUploaded: (file) => context.pop(file),
      popOnUpload: false,
      leading: IconButton(
        icon: Icon(context.adaptiveBackIcon),
        onPressed: () => setState(() => _mode = _FileChooserMode.existing),
      ),
    );
  }

  Future<void> _reload() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final files = await session.transportServices.files.getFiles();
    final expanded = await session.expander.expandFileDTOs(files.value);
    setState(() {
      _existingFiles = expanded;
    });
  }
}
