import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '/core/core.dart';

class FileDetailScreen extends StatefulWidget {
  final String accountId;
  final String fileId;
  final FileDVO? preLoadedFile;

  const FileDetailScreen({required this.accountId, required this.fileId, required this.preLoadedFile, super.key});

  @override
  State<FileDetailScreen> createState() => _FileDetailScreenState();
}

class _FileDetailScreenState extends State<FileDetailScreen> {
  FileDVO? _fileDVO;
  File? _cachedFile;
  bool _isLoadingFile = false;

  @override
  void initState() {
    super.initState();

    _fileDVO = widget.preLoadedFile;

    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 42),
      child: _fileDVO == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.l10n.files_fileInformation, style: Theme.of(context).textTheme.titleLarge),
                    IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
                  ],
                ),
                Gaps.h32,
                _InfoText(title: '${context.l10n.title}: ', content: _fileDVO!.title),
                Gaps.h24,
                _InfoText(title: '${context.l10n.files_filename}: ', content: _fileDVO!.filename),
                Gaps.h24,
                _InfoText(
                  title: '${context.l10n.files_expiryDate}: ',
                  content: DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(_fileDVO!.expiresAt).toLocal()),
                ),
                Gaps.h24,
                _InfoText(title: '${context.l10n.files_filesize}: ', content: bytesText(context: context, bytes: _fileDVO!.filesize)),
                Gaps.h24,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          if (_isLoadingFile)
                            const Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator())
                          else
                            IconButton(
                              onPressed: _cachedFile == null ? _downloadAndCacheFile : null,
                              icon: Icon(Icons.file_download, size: 40, color: _cachedFile == null ? Theme.of(context).colorScheme.primary : null),
                            ),
                          Text(context.l10n.files_download, style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: _cachedFile != null ? () => OpenFile.open(_cachedFile!.path) : null,
                            icon: Icon(Icons.file_open, size: 40, color: _cachedFile != null ? Theme.of(context).colorScheme.primary : null),
                          ),
                          Text(context.l10n.files_openFile, style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Future<void> _load() async {
    if (_fileDVO == null) {
      final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
      final response = await session.transportServices.files.getFile(fileId: widget.fileId);
      final expanded = await session.expander.expandFileDTO(response.value);

      setState(() => _fileDVO = expanded);
    }

    final cacheDir = await getTemporaryDirectory();

    final cachedFile = _fileDVO!.getCacheFile(cacheDir);
    if (cachedFile.existsSync()) setState(() => _cachedFile = cachedFile);
  }

  Future<void> _downloadAndCacheFile() async {
    if (mounted) setState(() => _isLoadingFile = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final cachedFile = await downloadAndCacheFile(
      session: session,
      fileDVO: _fileDVO!,
      onError: () {
        if (mounted) showDownloadFileErrorDialog(context);
      },
    );

    if (mounted) {
      setState(() {
        _isLoadingFile = false;
        if (cachedFile != null) _cachedFile = cachedFile;
      });
    }
  }
}

class _InfoText extends StatelessWidget {
  final String title;
  final String content;

  const _InfoText({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: title, style: Theme.of(context).textTheme.titleSmall),
          TextSpan(text: context.i18nTranslate(content)),
        ],
      ),
    );
  }
}
