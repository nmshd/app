import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

Future<FileDVO?> openFileChooser({
  required BuildContext context,
  required String accountId,
  List<FileDVO>? selectedFiles,
  VoidCallback? onSelectedAttachmentsChanged,
  String? title,
  String? description,
}) async {
  final file = await showModalBottomSheet<FileDVO?>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _FileChooser(
      accountId: accountId,
      selectedFiles: selectedFiles,
      onSelectedAttachmentsChanged: onSelectedAttachmentsChanged,
      title: title,
      description: description,
    ),
  );

  return file;
}

enum _FileChooserMode { existing, create }

class _FileChooser extends StatefulWidget {
  final String accountId;
  final List<FileDVO>? selectedFiles;
  final VoidCallback? onSelectedAttachmentsChanged;
  final String? title;
  final String? description;

  const _FileChooser({
    required this.accountId,
    required this.selectedFiles,
    required this.onSelectedAttachmentsChanged,
    required this.title,
    required this.description,
  });

  @override
  State<_FileChooser> createState() => _FileChooserState();
}

class _FileChooserState extends State<_FileChooser> {
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
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 8, top: 8),
              child: Row(
                children: [
                  Text(widget.title ?? context.l10n.fileChooser_title, style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.close), onPressed: context.pop),
                ],
              ),
            ),
            if (widget.description != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(widget.description!),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: OutlinedButton(
                onPressed: () => setState(() => _mode = _FileChooserMode.create),
                child: Text(context.l10n.fileChooser_uploadFile),
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
                              onTap: () {
                                if (widget.selectedFiles == null) return context.pop(file);

                                setState(() => widget.selectedFiles!.toggle(file));
                                widget.onSelectedAttachmentsChanged?.call();
                              },
                              leading: FileIcon(filename: file.filename),
                              trailing: widget.selectedFiles == null
                                  ? const Icon(Icons.chevron_right)
                                  : Checkbox(
                                      value: widget.selectedFiles!.contains(file),
                                      onChanged: (_) {
                                        setState(() => widget.selectedFiles!.toggle(file));
                                        widget.onSelectedAttachmentsChanged?.call();
                                      },
                                    ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(height: 0, indent: 16),
                        ),
                      ),
              ),
            ),
          ],
        ),
      );
    }

    return UploadFile(
      accountId: widget.accountId,
      onFileUploaded: (file) async {
        if (widget.selectedFiles == null) return context.pop(file);

        await _reload();
        setState(() {
          widget.selectedFiles!.toggle(file);
          _mode = _FileChooserMode.existing;
        });

        widget.onSelectedAttachmentsChanged?.call();
      },
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

extension _Toggle<T> on List<T> {
  void toggle(T value) {
    contains(value) ? remove(value) : add(value);
  }
}
