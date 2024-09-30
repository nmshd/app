import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'file_filter_type.dart';
import 'modals/select_file_filters.dart';

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
  List<FileDVO> _filteredFiles = [];
  Set<FileFilterType> _activeFilters = {};
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
      title: Text(context.l10n.files, maxLines: 2),
      actions: [
        SearchAnchor(
          suggestionsBuilder: _buildSuggestions,
          builder: (BuildContext context, SearchController controller) => IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => controller.openView(),
          ),
        ),
        IconButton(
          onPressed: _files != null && _files!.isNotEmpty
              ? () => showSelectFileFilters(
                    context,
                    availableFilters: _files!.map((file) => file.mimetype).toSet().map(FileFilterType.fromMimetype).toSet(),
                    activeFilters: _activeFilters,
                    onApplyFilters: (selectedFilters) {
                      setState(() => _activeFilters = selectedFilters);
                      _filterAndSort();
                    },
                  )
              : null,
          icon: Badge(isLabelVisible: _activeFilters.isNotEmpty, child: const Icon(Icons.filter_list)),
        ),
        IconButton(onPressed: _uploadFile, icon: const Icon(Icons.add)),
      ],
    );

    if (_files == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    if (_files!.isEmpty) {
      return Scaffold(
        appBar: appBar,
        body: RefreshIndicator(
          onRefresh: () => _loadFiles(syncBefore: true),
          child: EmptyListIndicator(icon: Icons.file_copy, text: context.l10n.files_noFilesAvailable, wrapInListView: true),
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: [
            SortBar<_FilesSortingType>(
              sortingType: _sortingType,
              isSortedAscending: _isSortedAscending,
              translate: (s) => switch (s) {
                _FilesSortingType.date => context.l10n.sortedByCreationDate,
                _FilesSortingType.name => context.l10n.sortedByName,
                _FilesSortingType.type => context.l10n.sortedByType,
                _FilesSortingType.size => context.l10n.sortedBySize,
              },
              sortMenuItem: [
                (value: _FilesSortingType.date, label: context.l10n.files_creationDate),
                (value: _FilesSortingType.name, label: context.l10n.name),
                (value: _FilesSortingType.type, label: context.l10n.files_fileType),
                (value: _FilesSortingType.size, label: context.l10n.files_fileSize),
              ],
              onSortingConditionChanged: ({required type, required isSortedAscending}) {
                _isSortedAscending = isSortedAscending;
                _sortingType = type;

                _filterAndSort();
              },
            ),
            if (_activeFilters.isNotEmpty)
              _FilterBar(
                activeFilters: _activeFilters,
                onRemoveFilter: (removedFilter) {
                  _activeFilters.remove(removedFilter);
                  _filterAndSort();
                },
                onResetFilters: () {
                  _activeFilters = {};
                  _filterAndSort();
                },
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _loadFiles(syncBefore: true),
                child: ListView.separated(
                  itemBuilder: (context, index) => FileItem(
                    accountId: widget.accountId,
                    file: _filteredFiles[index],
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  itemCount: _filteredFiles.length,
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

    _files = files;
    _filterAndSort();
  }

  void _filterAndSort() {
    if (_activeFilters.isEmpty) {
      final sorted = _files!..sort(_compareFunction(_sortingType, _isSortedAscending));
      setState(() => _filteredFiles = sorted);
      return;
    }

    final filteredFiles = _files!.where((file) => _activeFilters.contains(FileFilterType.fromMimetype(file.mimetype))).toList()
      ..sort(_compareFunction(_sortingType, _isSortedAscending));

    setState(() => _filteredFiles = filteredFiles);
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

class _FilterBar extends StatelessWidget {
  final Set<FileFilterType> activeFilters;
  final void Function(FileFilterType) onRemoveFilter;
  final void Function() onResetFilters;

  const _FilterBar({
    required this.activeFilters,
    required this.onRemoveFilter,
    required this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    final activeFilters = this.activeFilters.map((e) => (filter: e, label: e.toLabel(context))).toList()
      ..sort((a, b) {
        if (a.filter is OtherFileFilterType) return 1;
        if (b.filter is OtherFileFilterType) return -1;
        return a.label.compareTo(b.label);
      });

    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 12,
                children: activeFilters.map((e) {
                  return FilterChip(
                    label: Text(e.label),
                    selected: true,
                    showCheckmark: false,
                    padding: EdgeInsets.zero,
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => onRemoveFilter(e.filter),
                    onSelected: (value) => value,
                  );
                }).toList(),
              ),
            ),
            IconButton(onPressed: onResetFilters, icon: const Icon(Icons.close)),
          ],
        ),
      ),
    );
  }
}
