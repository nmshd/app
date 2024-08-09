import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

enum _FilesSortingType { date, name, type, size }

class FilesScreen extends StatefulWidget {
  final String accountId;
  final bool initialCreation;

  const FilesScreen({required this.accountId, this.initialCreation = false, super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  List<FileDVO>? _files;
  _FilesSortingType _sortingType = _FilesSortingType.date;
  bool _isSortedAscending = false;

  @override
  void initState() {
    super.initState();

    _loadFiles().then((_) => widget.initialCreation ? _uploadFile() : null);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(context.l10n.files),
      actions: [
        SearchAnchor(
          suggestionsBuilder: _buildSuggestions,
          builder: (BuildContext context, SearchController controller) => IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => controller.openView(),
          ),
        ),
        IconButton(onPressed: _uploadFile, icon: const Icon(Icons.add)),
      ],
    );

    if (_files == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: [
            _SortBar(
              sortingType: _sortingType,
              isSortedAscending: _isSortedAscending,
              onSortingConditionChanged: ({required _FilesSortingType type, required bool isSortedAscending}) => _sortFiles(
                _files!,
                type,
                isSortedAscending,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _loadFiles(syncBefore: true),
                child: _files!.isEmpty
                    ? EmptyListIndicator(icon: Icons.file_copy, text: context.l10n.files_noFilesAvailable, wrapInListView: true)
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          final file = _files![index];
                          return FileItem(accountId: widget.accountId, file: file, trailing: const Icon(Icons.chevron_right));
                        },
                        itemCount: _files!.length,
                        separatorBuilder: (context, index) => const Divider(height: 2, indent: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadFiles({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final filesResult = await session.transportServices.files.getFiles();
    final files = await session.expander.expandFileDTOs(filesResult.value);

    _sortFiles(files, _sortingType, _isSortedAscending);
  }

  void _sortFiles(List<FileDVO> files, _FilesSortingType sortingType, bool isSortedAscending) {
    final sortedFiles = files..sort(_compareFunction(sortingType, isSortedAscending));

    if (mounted) {
      setState(() {
        _files = sortedFiles;
        _isSortedAscending = isSortedAscending;
        _sortingType = sortingType;
      });
    }
  }

  int Function(FileDVO, FileDVO) _compareFunction(_FilesSortingType type, bool isSortedAscending) => switch (type) {
        _FilesSortingType.date => (a, b) => isSortedAscending ? a.createdAt.compareTo(b.createdAt) : b.createdAt.compareTo(a.createdAt),
        _FilesSortingType.name => (a, b) {
            if (isSortedAscending) return a.name.toLowerCase().compareTo(b.name.toLowerCase());
            return b.name.toLowerCase().compareTo(a.name.toLowerCase());
          },
        _FilesSortingType.type => (a, b) {
            final aType = a.mimetype.split('/').last;
            final bType = b.mimetype.split('/').last;
            return isSortedAscending ? aType.compareTo(bType) : bType.compareTo(aType);
          },
        _FilesSortingType.size => (a, b) => isSortedAscending ? a.filesize.compareTo(b.filesize) : b.filesize.compareTo(a.filesize),
      };

  void _uploadFile() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => UploadFile(accountId: widget.accountId, onFileUploaded: (_) => _loadFiles()),
    );
  }

  Iterable<Widget> _buildSuggestions(BuildContext context, SearchController controller) {
    final keyword = controller.value.text;

    if (_files!.isEmpty && keyword.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: EmptyListIndicator(icon: Icons.file_copy, text: context.l10n.files_noFilesAvailable),
        ),
      ];
    }

    bool containsKeyword(FileDVO file, String keyword) {
      return [
        file.name.toLowerCase(),
        file.filename.toLowerCase(),
        getFileExtension(file.filename).toLowerCase(),
      ].any((element) => element.contains(keyword.toLowerCase()));
    }

    final matchingFiles = List<FileDVO>.of(_files!).where((element) => containsKeyword(element, keyword)).toList();

    if (matchingFiles.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: EmptyListIndicator(
            icon: Icons.filter_alt_outlined,
            text: context.l10n.files_noResults,
            description: context.l10n.files_noResultsDescription,
          ),
        ),
      ];
    }

    return matchingFiles.map(
      (item) => FileItem(
        file: item,
        query: keyword,
        accountId: widget.accountId,
        onTap: () {
          controller
            ..clear()
            ..closeView(null);
          FocusScope.of(context).unfocus();

          context.push('/account/${widget.accountId}/my-data/files/${item.id}', extra: item);
        },
      ),
    );
  }
}

class _SortBar extends StatefulWidget {
  final _FilesSortingType sortingType;
  final bool isSortedAscending;
  final void Function({required _FilesSortingType type, required bool isSortedAscending}) onSortingConditionChanged;

  const _SortBar({
    required this.sortingType,
    required this.isSortedAscending,
    required this.onSortingConditionChanged,
  });

  @override
  State<_SortBar> createState() => _SortBarState();
}

class _SortBarState extends State<_SortBar> {
  bool _isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _isOpened
                ? '${context.l10n.files_sortBy} ...'
                : switch (widget.sortingType) {
                    _FilesSortingType.date => context.l10n.files_sortedByDate,
                    _FilesSortingType.name => context.l10n.files_sortedByName,
                    _FilesSortingType.type => context.l10n.files_sortedByType,
                    _FilesSortingType.size => context.l10n.files_sortedBySize,
                  },
          ),
          PopupMenuButton<_FilesSortingType>(
            icon: const Icon(Icons.sort),
            offset: const Offset(40, 48),
            onOpened: () => setState(() => _isOpened = true),
            onCanceled: () => setState(() => _isOpened = false),
            onSelected: (type) {
              setState(() => _isOpened = false);

              widget.onSortingConditionChanged(type: type, isSortedAscending: widget.isSortedAscending);
            },
            itemBuilder: (context) {
              return <PopupMenuEntry<_FilesSortingType>>[
                PopupMenuItem<_FilesSortingType>(value: _FilesSortingType.date, child: Text(context.l10n.files_creationDate)),
                PopupMenuItem<_FilesSortingType>(value: _FilesSortingType.name, child: Text(context.l10n.name)),
                PopupMenuItem<_FilesSortingType>(value: _FilesSortingType.type, child: Text(context.l10n.files_fileType)),
                PopupMenuItem<_FilesSortingType>(value: _FilesSortingType.size, child: Text(context.l10n.files_fileSize)),
              ];
            },
          ),
          IconButton(
            onPressed: () => widget.onSortingConditionChanged(type: widget.sortingType, isSortedAscending: !widget.isSortedAscending),
            icon: Icon(widget.isSortedAscending ? Icons.arrow_downward : Icons.arrow_upward),
          ),
        ],
      ),
    );
  }
}
