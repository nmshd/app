import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;

import '../core.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  File? _selectedFile;
  DateTime? _expiryDate;
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height - 100),
      child: Stack(
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
                        Gaps.h24,
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            maxLength: MaxLength.fileName,
                            controller: _controller,
                            onChanged: (value) => setState(() {}),
                            decoration: InputDecoration(
                              labelText: context.l10n.title,
                              errorMaxLines: 3,
                              suffixIcon: _controller.text.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: _controller.clear,
                                      icon: const Icon(Icons.cancel_outlined),
                                    ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                        Gaps.h8,
                        Row(
                          children: [
                            Text('${context.l10n.files_expiryDate}: ', style: Theme.of(context).textTheme.bodyLarge),
                            if (_expiryDate == null)
                              Text(
                                context.l10n.files_selectExpiryError,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.error),
                              ),
                            if (_expiryDate != null)
                              Text(
                                DateFormat('yMd', Localizations.localeOf(context).languageCode).format(_expiryDate!),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            const Spacer(),
                            IconButton(
                              onPressed: _pickDate,
                              icon: Icon(Icons.date_range, color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                        Gaps.h8,
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton(
                            onPressed: validateEverything() ? _submit : null,
                            style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                            child: Text(context.l10n.save),
                          ),
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
      ),
    );
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() => _selectedFile = File(result.files.single.path!));
  }

  Future<void> _pickDate() async {
    final initialDate = DateTime.now().add(const Duration(days: 1));
    final date = await showDatePicker(context: context, initialDate: initialDate, firstDate: initialDate, lastDate: DateTime(initialDate.year + 100));
    if (date != null) setState(() => _expiryDate = date);
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    if (mounted) setState(() => _loading = true);

    try {
      final file = await _uploadFile(_selectedFile!, _controller.text, _expiryDate!);

      widget.onFileUploaded(file);

      if (mounted && widget.popOnUpload) context.pop();
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

  Future<FileDVO> _uploadFile(File file, String title, DateTime expiryDate) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final bytes = await file.readAsBytes();
    final content = Uint8List.fromList(bytes).toList();
    final filename = path.basename(file.path);
    final mimetype = mime(filename) ?? 'application/octet-stream';
    final expiresAt = expiryDate.copyWith(microsecond: 0).toUtc().toIso8601String();

    final uploadedFile = await session.transportServices.files.uploadOwnFile(
      content: content,
      filename: filename,
      mimetype: mimetype,
      expiresAt: expiresAt,
      title: title.trim(),
    );

    final expanded = await session.expander.expandFileDTO(uploadedFile.value);
    return expanded;
  }

  bool get isTitleValid => validateTitle(_controller.text) == null;

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) return context.l10n.files_titleEmptyError;

    return null;
  }

  bool validateEverything() => _selectedFile != null && isTitleValid && _expiryDate != null;
}

class _FileSelected extends StatelessWidget {
  final File file;

  const _FileSelected({required this.file});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FileIcon(filename: file.path, color: Theme.of(context).colorScheme.primary, size: 40),
            Gaps.h16,
            Text(path.basename(file.path), style: Theme.of(context).textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _NoFileSelected extends StatelessWidget {
  final VoidCallback selectFile;

  const _NoFileSelected({required this.selectFile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectFile,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [10, 4],
        strokeCap: StrokeCap.round,
        padding: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.primary,
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.3), borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.folder_open, color: Theme.of(context).colorScheme.primary, size: 40),
              Gaps.h16,
              Text(context.l10n.files_selectFile, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
