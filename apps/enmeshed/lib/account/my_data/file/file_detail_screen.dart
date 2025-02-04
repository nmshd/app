import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/core.dart';
import 'modals/edit_file.dart';
import 'widgets/widgets.dart';

class FileDetailScreen extends StatefulWidget {
  final String accountId;
  final String fileId;
  final FileDVO preLoadedFile;
  final LocalAttributeDVO? fileReferenceAttribute;

  const FileDetailScreen({
    required this.accountId,
    required this.fileId,
    required this.preLoadedFile,
    this.fileReferenceAttribute,
    super.key,
  });

  @override
  State<FileDetailScreen> createState() => _FileDetailScreenState();
}

class _FileDetailScreenState extends State<FileDetailScreen> {
  late final Session _session;

  late FileDVO _fileDVO;

  LocalAttributeDVO? _fileReferenceAttribute;
  List<String>? _tags;
  AttributeTagCollectionDTO? _tagCollection;

  bool _isLoadingFile = false;
  bool _isOpeningFile = false;

  @override
  void initState() {
    super.initState();

    _session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    _fileDVO = widget.preLoadedFile;
    _fileReferenceAttribute = widget.fileReferenceAttribute;
    _tags = widget.fileReferenceAttribute?.tags;

    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(_fileDVO.title, style: Theme.of(context).textTheme.titleLarge)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    FileIcon(filename: _fileDVO.filename, color: Theme.of(context).colorScheme.primary, size: 40),
                    Gaps.h8,
                    Text(_fileDVO.filename, style: Theme.of(context).textTheme.labelLarge),
                    Text('${bytesText(context: context, bytes: _fileDVO.filesize)} - ${getFileExtension(_fileDVO.filename)}'),
                  ],
                ),
              ),
              Gaps.h48,
              if (_isEditable) ...[
                if (_tags == null || _tags!.isEmpty)
                  FileTagsContainer(onEditFile: _onEditFilePressed)
                else
                  SelectedTagsSection(tagCollection: _tagCollection!, selectedTagsList: _tags!),
                Gaps.h16,
              ],
              FileInfoContainer(createdBy: _fileDVO.createdBy.name, createdAt: _fileDVO.createdAt),
              Gaps.h32,
              Row(
                spacing: 8,
                children: [
                  if (_isEditable) IconButton(onPressed: _onEditFilePressed, icon: const Icon(Icons.edit_outlined, size: 24)),
                  IconButton(
                    onPressed: _isLoadingFile || DateTime.parse(_fileDVO.expiresAt).isBefore(DateTime.now()) ? null : _downloadAndSaveFile,
                    icon: _isLoadingFile ? const _LoadingIndicator() : const Icon(Icons.file_download, size: 24),
                  ),
                  IconButton(
                    onPressed: _isOpeningFile || DateTime.parse(_fileDVO.expiresAt).isBefore(DateTime.now()) ? null : _openFile,
                    icon: _isOpeningFile ? const _LoadingIndicator() : const Icon(Icons.open_with, size: 24),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _isEditable => _fileReferenceAttribute != null && _tagCollection != null;

  Future<void> _load() async {
    await _loadFile();
    await _loadTagCollection();
    await _loadTags();
  }

  Future<void> _loadFile() async {
    final response = await _session.transportServices.files.getFile(fileId: widget.preLoadedFile.id);
    final expanded = await _session.expander.expandFileDTO(response.value);

    setState(() => _fileDVO = expanded);
  }

  Future<void> _loadTagCollection() async {
    final tagCollectionResult = await _session.consumptionServices.attributes.getAttributeTagCollection();

    if (tagCollectionResult.isError) return;

    setState(() => _tagCollection = tagCollectionResult.value);
  }

  Future<void> _loadTags({String? attributeId}) async {
    if (_fileReferenceAttribute == null) return;

    final response = await _session.consumptionServices.attributes.getAttribute(attributeId: attributeId ?? _fileReferenceAttribute!.id);
    final expanded = await _session.expander.expandLocalAttributeDTO(response.value);

    setState(() {
      _tags = expanded.tags;
      _fileReferenceAttribute = expanded;
    });
  }

  Future<void> _downloadAndSaveFile() async {
    setState(() => _isLoadingFile = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    await moveFileOnDevice(
      session: session,
      fileDVO: _fileDVO,
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
      fileDVO: _fileDVO,
      onError: () {
        if (mounted) showDownloadFileErrorDialog(context);
      },
    );

    if (mounted) setState(() => _isOpeningFile = false);
  }

  void _onEditFilePressed() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditFile(
        accountId: widget.accountId,
        fileTitle: _fileDVO.title,
        fileReferenceAttribute: _fileReferenceAttribute!,
        tagCollection: _tagCollection!,
        onSave: _loadTags,
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) => const SizedBox(width: 24, height: 24, child: CircularProgressIndicator());
}
