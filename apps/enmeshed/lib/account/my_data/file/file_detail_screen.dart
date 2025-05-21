import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
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
  List<({IdentityDVO contact, LocalAttributeDVO sharedAttribute})>? _sharedWith;
  bool _isSharingFile = false;
  bool _isLoadingFile = false;
  bool _isOpeningFile = false;

  @override
  void initState() {
    super.initState();

    _fileDVO = widget.preLoadedFile;
    _tags = <String>{..._fileDVO?.tags ?? [], ...widget.preLoadedFile?.tags ?? []}.toList();

    if (_fileDVO == null) {
      _load();
    } else {
      _loadSharedWith();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: TranslatedText(_fileDVO!.title, style: Theme.of(context).textTheme.titleLarge)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: _fileDVO == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Column(
                            children: [
                              FileIcon(filename: _fileDVO!.filename, color: Theme.of(context).colorScheme.primary, size: 40),
                              Gaps.h8,
                              Text(_fileDVO!.filename, style: Theme.of(context).textTheme.labelLarge),
                              Text('${bytesText(context: context, bytes: _fileDVO!.filesize)} - ${getFileExtension(_fileDVO!.filename)}'),
                            ],
                          ),
                        ),
                      ),
                      if (_tags != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 12,
                              children: _tags!
                                  .map(
                                    (e) => Chip(
                                      label: _TagLabel(e, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
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
                        ),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          spacing: 8,
                          children: [
                            IconButton(
                              onPressed: _isSharingFile || DateTime.parse(_fileDVO!.expiresAt).isBefore(DateTime.now()) ? null : _shareFile,
                              icon: _isSharingFile
                                  ? const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 3))
                                  : const Icon(Icons.share_outlined, size: 24),
                            ),
                            IconButton(
                              onPressed: _isLoadingFile || DateTime.parse(_fileDVO!.expiresAt).isBefore(DateTime.now()) ? null : _downloadAndSaveFile,
                              icon: _isLoadingFile
                                  ? const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 3))
                                  : const Icon(Icons.file_download_outlined, size: 28),
                            ),
                            IconButton(
                              onPressed: _isOpeningFile || DateTime.parse(_fileDVO!.expiresAt).isBefore(DateTime.now()) ? null : _openFile,
                              icon: _isOpeningFile
                                  ? const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 3))
                                  : const Icon(Icons.file_open_outlined, size: 24),
                            ),
                            if (widget.fileReferenceAttribute is RepositoryAttributeDVO)
                              IconButton(
                                icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                                onPressed: () => showDeleteAttributeModal(
                                  context: context,
                                  accountId: widget.accountId,
                                  attribute: widget.fileReferenceAttribute!,
                                  onAttributeDeleted: () {
                                    if (mounted && context.canPop()) context.pop();
                                    showSuccessSnackbar(context: context, text: context.l10n.personalData_details_attributeSuccessfullyDeleted);
                                  },
                                  attributeNameOverride: _fileDVO!.title,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (_sharedWith != null) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(context.l10n.attributeDetails_sharedWith, style: Theme.of(context).textTheme.titleMedium),
                            ),
                            if (_sharedWith!.isEmpty)
                              EmptyListIndicator(icon: Icons.sensors_off, text: context.l10n.attributeDetails_sharedWithNobody)
                            else
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _sharedWith!.length,
                                itemBuilder: (context, index) {
                                  final contact = _sharedWith![index].contact;
                                  final sharedAttribute = _sharedWith![index].sharedAttribute;

                                  return ContactItem(
                                    contact: contact,
                                    subtitle: Text(
                                      context.l10n.attributeDetails_sharedAt(
                                        DateTime.parse(sharedAttribute.createdAt).toLocal().dateType,
                                        DateTime.parse(sharedAttribute.createdAt).toLocal(),
                                        DateTime.parse(sharedAttribute.createdAt).toLocal(),
                                      ),
                                    ),
                                    onTap: () => context.push('/account/${widget.accountId}/contacts/${contact.id}'),
                                    trailing: const Icon(Icons.chevron_right),
                                  );
                                },
                                separatorBuilder: (context, index) => const Divider(indent: 16),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
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

    await _loadSharedWith();
  }

  Future<void> _loadSharedWith() async {
    if (widget.fileReferenceAttribute == null) return;

    final attribute = widget.fileReferenceAttribute!;
    if (attribute is! RepositoryAttributeDVO) return;

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final sharedWith = await Future.wait(
      attribute.sharedWith.map((e) async => (contact: await session.expander.expandAddress(e.peer), sharedAttribute: e)),
    );

    if (!mounted) return;

    setState(() => _sharedWith = sharedWith);
  }

  Future<void> _shareFile() async {
    setState(() => _isSharingFile = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    await shareFile(
      session: session,
      fileDVO: _fileDVO!,
      onError: () {
        if (mounted) showDownloadFileErrorDialog(context);
      },
    );

    if (mounted) setState(() => _isSharingFile = false);
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

class _TagLabel extends StatelessWidget {
  final String label;
  final TextStyle style;

  const _TagLabel(this.label, {required this.style});

  @override
  Widget build(BuildContext context) {
    if (label.startsWith('language:')) {
      return TranslatedText(context.i18nTranslate('i18n://attributes.values.languages.${label.substring(9)}'), style: style);
    }

    final i18nTranslatable = 'i18n://tags.${label.replaceAll('.', '%')}';
    final translatedLabel = context.i18nTranslate(i18nTranslatable);

    if (translatedLabel != i18nTranslatable) return Text(translatedLabel, style: style);

    return Text(label, style: style);
  }
}
