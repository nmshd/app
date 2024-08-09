import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;

import '../constants.dart';
import '../utils/utils.dart';
import 'file_icon.dart';
import 'modal_loading_overlay.dart';

class UploadFile extends StatefulWidget {
  final String accountId;
  final void Function(FileDVO) onFileUploaded;
  final bool popOnUpload;
  final Widget? leading;

  const UploadFile({
    required this.accountId,
    required this.onFileUploaded,
    this.popOnUpload = true,
    this.leading,
    super.key,
  });

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  late final TextEditingController _titleController;

  File? _selectedFile;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController()..addListener(() => setState(() => {}));
  }

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8, left: widget.leading == null ? 24 : 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.leading != null) widget.leading!,
                  Text(context.l10n.files_uploadFile, style: Theme.of(context).textTheme.titleLarge),
                  IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom, top: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_selectedFile != null) _FileSelected(file: _selectedFile!) else _NoFileSelected(selectFile: _selectFile),
                      Text(context.l10n.mandatoryField),
                      Gaps.h24,
                      TextFormField(
                        maxLength: MaxLength.fileName,
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: '${context.l10n.title}*',
                          errorMaxLines: 3,
                          suffixIcon:
                              _titleController.text.isEmpty ? null : IconButton(onPressed: _titleController.clear, icon: const Icon(Icons.clear)),
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateTitle,
                        onFieldSubmitted: validateEverything() ? (_) => _submit() : null,
                        inputFormatters: [
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            if (newValue.text.length == 1 && newValue.text == ' ') return oldValue;
                            if (newValue.text.endsWith('  ')) return oldValue;

                            return newValue;
                          }),
                        ],
                      ),
                      Gaps.h44,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => context.pop(),
                            child: Text(context.l10n.cancel),
                          ),
                          Gaps.w8,
                          FilledButton(
                            onPressed: validateEverything() ? _submit : null,
                            style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                            child: Text(context.l10n.save),
                          ),
                        ],
                      ),
                      Gaps.h24,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_loading) ModalLoadingOverlay(text: context.l10n.files_uploadInProgress, isDialog: false),
      ],
    );
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() => _selectedFile = File(result.files.single.path!));
  }

  Future<void> _submit() async {
    if (mounted) setState(() => _loading = true);

    FocusScope.of(context).unfocus();

    try {
      final file = await _uploadFile(_selectedFile!, _titleController.text);

      widget.onFileUploaded(file);

      if (mounted && widget.popOnUpload) {
        context.pop();
        await context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: file);
      }
    } on PlatformException catch (e) {
      GetIt.I.get<Logger>().e('Uploading file failed caused by: $e');
      if (mounted) {
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
              content: Text(context.l10n.error_upload_file),
            );
          },
        );
      }
    }
  }

  Future<FileDVO> _uploadFile(File file, String title) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final bytes = await file.readAsBytes();
    final content = Uint8List.fromList(bytes).toList();
    final filename = path.basename(file.path);
    final mimetype = mime(filename) ?? 'application/octet-stream';

    final uploadedFile = await session.transportServices.files.uploadOwnFile(
      content: content,
      filename: filename,
      mimetype: mimetype,
      title: title.trim(),
    );

    final expanded = await session.expander.expandFileDTO(uploadedFile.value);
    return expanded;
  }

  bool get isTitleValid => validateTitle(_titleController.text) == null;

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) return context.l10n.files_titleEmptyError;

    return null;
  }

  bool validateEverything() => _selectedFile != null && isTitleValid;
}

class _FileSelected extends StatefulWidget {
  final File file;

  const _FileSelected({required this.file});

  @override
  State<_FileSelected> createState() => _FileSelectedState();
}

class _FileSelectedState extends State<_FileSelected> {
  String? fileSize;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _updateFileSize();
  }

  @override
  void didUpdateWidget(covariant _FileSelected oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.file.path != widget.file.path) _updateFileSize();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FileIcon(
              filename: widget.file.path,
              color: Theme.of(context).colorScheme.primaryContainer,
              size: 48,
            ),
            Gaps.h8,
            Text(
              path.basename(widget.file.path),
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (isLoading)
              const CircularProgressIndicator()
            else if (fileSize != null)
              Text(
                fileSize!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateFileSize() async {
    final size = await _getFileSize(widget.file.path, context);

    if (mounted) {
      setState(() {
        fileSize = size;
        isLoading = false;
      });
    }
  }

  Future<String?> _getFileSize(String filePath, BuildContext context) async {
    final file = File(filePath);
    final fileSizeBytes = await file.length();

    if (!context.mounted) return null;

    return '${bytesText(context: context, bytes: fileSizeBytes)}, ${getFileExtension(filePath)}';
  }
}

class _NoFileSelected extends StatelessWidget {
  final VoidCallback selectFile;

  const _NoFileSelected({required this.selectFile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: FilledButton(
            onPressed: selectFile,
            child: Text(
              context.l10n.files_selectFile,
            ),
          ),
        ),
      ],
    );
  }
}
