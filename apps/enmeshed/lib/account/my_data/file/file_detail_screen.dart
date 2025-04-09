import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '/core/core.dart';

class FileDetailScreen extends StatefulWidget {
  final String accountId;
  final String fileId;
  final FileDVO? preLoadedFile;
  final LocalAttributeDVO? fileReferenceAttribute;

  const FileDetailScreen({required this.accountId, required this.fileId, required this.preLoadedFile, this.fileReferenceAttribute, super.key});

  @override
  State<FileDetailScreen> createState() => _FileDetailScreenState();
}

class _FileDetailScreenState extends State<FileDetailScreen> {
  FileDVO? _fileDVO;
  List<String>? _tags;
  bool _isLoadingFile = false;
  bool _isOpeningFile = false;

  @override
  void initState() {
    super.initState();

    _fileDVO = widget.preLoadedFile;
    _tags = widget.fileReferenceAttribute?.tags;

    if (_fileDVO == null) _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(_fileDVO!.title, style: Theme.of(context).textTheme.titleLarge)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child:
              _fileDVO == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            FileIcon(filename: _fileDVO!.filename, color: Theme.of(context).colorScheme.primary, size: 40),
                            Gaps.h8,
                            Text(_fileDVO!.filename, style: Theme.of(context).textTheme.labelLarge),
                            Text('${bytesText(context: context, bytes: _fileDVO!.filesize)} - ${getFileExtension(_fileDVO!.filename)}'),
                          ],
                        ),
                      ),
                      if (_tags != null)
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 12,
                            children:
                                _tags!
                                    .map(
                                      (e) => Chip(
                                        label: Text(e, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                                          side: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                        padding: EdgeInsets.zero,
                                        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                                        visualDensity: const VisualDensity(horizontal: -2),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      Card(
                        margin: EdgeInsets.zero,
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${context.l10n.files_owner}: ',
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                  Text(
                                    '${context.l10n.files_createdAt}: ',
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ),
                              Gaps.w24,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(context.i18nTranslate(_fileDVO!.createdBy.name), style: Theme.of(context).textTheme.bodyMedium),
                                  Text(
                                    context.i18nTranslate(_formatDate(context, _fileDVO!.createdAt)),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          IconButton(
                            onPressed: _isLoadingFile || DateTime.parse(_fileDVO!.expiresAt).isBefore(DateTime.now()) ? null : _downloadAndSaveFile,
                            icon:
                                _isLoadingFile
                                    ? const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 3))
                                    : const Icon(Icons.file_download_outlined, size: 24),
                          ),
                          IconButton(
                            onPressed: _isOpeningFile || DateTime.parse(_fileDVO!.expiresAt).isBefore(DateTime.now()) ? null : _openFile,
                            icon:
                                _isOpeningFile
                                    ? const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 3))
                                    : const Icon(Icons.file_open_outlined, size: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  String _formatDate(BuildContext context, String date) {
    final locale = Localizations.localeOf(context);
    final parsedDate = DateTime.parse(date).toLocal();
    return DateFormat.yMd(locale.languageCode).format(parsedDate);
  }

  Future<void> _load() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final response = await session.transportServices.files.getFile(fileId: widget.fileId);
    final expanded = await session.expander.expandFileDTO(response.value);

    setState(() => _fileDVO = expanded);
  }

  Future<void> _downloadAndSaveFile() async {
    setState(() => _isLoadingFile = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    await moveFileOnDevice(
      session: session,
      fileDVO: _fileDVO!,
      onError: () {
        if (mounted) showDownloadFileErrorDialog(context);
      },
    );

    if (mounted) setState(() => _isLoadingFile = false);
  }

  Future<void> _openFile() async {
    setState(() => _isOpeningFile = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    await openFile(
      session: session,
      fileDVO: _fileDVO!,
      onError: () {
        if (mounted) showDownloadFileErrorDialog(context);
      },
    );

    if (mounted) setState(() => _isOpeningFile = false);
  }
}
