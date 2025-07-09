import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'file_filter_type.dart';
import 'modals/select_file_filters.dart';

enum _FilesSortingType { date, name, type, size }

enum FilesFilterOption {
  all(Icons.format_list_bulleted, Icons.format_list_bulleted),
  unviewed(Icons.new_releases, Icons.new_releases_outlined),
  expired(Icons.error, Icons.error_outline),
  type(Icons.insert_drive_file, Icons.insert_drive_file),
  tags(Icons.bookmark, Icons.bookmark);

  final IconData filterIcon;
  final IconData emptyListIcon;

  const FilesFilterOption(this.filterIcon, this.emptyListIcon);
}

class FilesScreen extends StatefulWidget {
  final String accountId;
  final bool initialCreation;

  const FilesScreen({required this.accountId, this.initialCreation = false, super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  List<FileRecord>? _fileRecords;
  List<FileRecord> _filteredFileRecords = [];

  Set<FileFilterType> _activeFilters = {};
  _FilesSortingType _sortingType = _FilesSortingType.date;
  bool _isSortedAscending = false;

  FilesFilterOption _filterOption = FilesFilterOption.all;

  late final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    _subscriptions
      ..add(runtime.eventBus.on<AttributeDeletedEvent>().listen((_) => _loadFiles().catchError((_) {})))
      ..add(runtime.eventBus.on<AttributeWasViewedAtChangedEvent>().listen((_) => _loadFiles().catchError((_) {})));

    _loadFiles().then((_) => widget.initialCreation ? _uploadFile() : null);
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(context.l10n.files, maxLines: 2),
      actions: [
        SearchAnchor(
          suggestionsBuilder: _buildSuggestions,
          builder: (BuildContext context, SearchController controller) =>
              IconButton(icon: const Icon(Icons.search), onPressed: () => controller.openView()),
        ),
        IconButton(
          onPressed: _fileRecords != null && _fileRecords!.isNotEmpty
              ? () => showSelectFileFilters(
                  context,
                  availableFilters: _fileRecords!.map((fileRecord) => fileRecord.file.mimetype).toSet().map(FileFilterType.fromMimetype).toSet(),
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

    if (_fileRecords == null) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
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
            _FilesFilterChipBar(
              selectedFilterOption: _filterOption,
              isBadgeLabelVisible: _activeFilters.isNotEmpty,
              setFilter: (filter) {
                setState(() => _filterOption = filter);
                if (filter == FilesFilterOption.type && _fileRecords != null && _fileRecords!.isNotEmpty) {
                  return showSelectFileFilters(
                    context,
                    availableFilters: _fileRecords!.map((fileRecord) => fileRecord.file.mimetype).toSet().map(FileFilterType.fromMimetype).toSet(),
                    activeFilters: _activeFilters,
                    onApplyFilters: (selectedFilters) {
                      setState(() => _activeFilters = selectedFilters);
                      _filterAndSort();
                    },
                  );
                }
                _loadFiles();
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
            if (_fileRecords!.isEmpty)
              _EmptyFilesIndicator(accountId: widget.accountId, filterOption: _filterOption, uploadFile: _uploadFile)
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => _loadFiles(syncBefore: true),
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        FileItem(accountId: widget.accountId, fileRecord: _filteredFileRecords[index], trailing: const Icon(Icons.chevron_right)),
                    itemCount: _filteredFileRecords.length,
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
    final fileRecords = <FileRecord>[];
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final result = await session.consumptionServices.attributes.getRepositoryAttributes(
      query: {
        'content.value.@type': QueryValue.string('IdentityFileReference'),
        if (_filterOption == FilesFilterOption.unviewed) 'wasViewedAt': QueryValue.string('!'),
      },
    );

    if (result.isError) {
      GetIt.I.get<Logger>().e('Receiving FileReference Attributes failed caused by: ${result.error}');

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
            content: Text(context.l10n.errorDialog_description),
          );
        },
      );

      return;
    }

    final fileReferenceAttributes = await session.expander.expandLocalAttributeDTOs(result.value);

    for (final fileReferenceAttribute in fileReferenceAttributes) {
      final fileReference = fileReferenceAttribute.value as IdentityFileReferenceAttributeValue;
      final file = await expandFileReference(accountId: widget.accountId, fileReference: fileReference.value);

      if (_filterOption != FilesFilterOption.expired || DateTime.parse(file.expiresAt).isBefore(DateTime.now())) {
        fileRecords.add(
          createFileRecord(file: file, fileReferenceAttribute: fileReferenceAttribute as RepositoryAttributeDVO),
        );
      }
    }
    _fileRecords = fileRecords;
    _filterAndSort();
  }

  void _filterAndSort() {
    if (_activeFilters.isEmpty) {
      final sorted = _fileRecords!..sort(_compareFunction(_sortingType, _isSortedAscending));
      setState(() => _filteredFileRecords = sorted);
      return;
    }

    final filteredFiles = _fileRecords!.where((fileRecord) => _activeFilters.contains(FileFilterType.fromMimetype(fileRecord.file.mimetype))).toList()
      ..sort(_compareFunction(_sortingType, _isSortedAscending));

    setState(() => _filteredFileRecords = filteredFiles);
  }

  int Function(FileRecord, FileRecord) _compareFunction(_FilesSortingType type, bool isSortedAscending) => switch (type) {
    _FilesSortingType.date =>
      (a, b) => isSortedAscending ? a.file.createdAt.compareTo(b.file.createdAt) : b.file.createdAt.compareTo(a.file.createdAt),
    _FilesSortingType.name => (a, b) {
      if (isSortedAscending) return a.file.name.toLowerCase().compareTo(b.file.name.toLowerCase());
      return b.file.name.toLowerCase().compareTo(a.file.name.toLowerCase());
    },
    _FilesSortingType.type => (a, b) {
      final aType = a.file.mimetype.split('/').last;
      final bType = b.file.mimetype.split('/').last;
      return isSortedAscending ? aType.compareTo(bType) : bType.compareTo(aType);
    },
    _FilesSortingType.size => (a, b) => isSortedAscending ? a.file.filesize.compareTo(b.file.filesize) : b.file.filesize.compareTo(a.file.filesize),
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

    if (_fileRecords!.isEmpty && keyword.isEmpty) {
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
        getFileExtension(file.filename).toLowerCase(),
      ].any((element) => element.contains(keyword.toLowerCase()));
    }

    final matchingFiles = List<FileRecord>.of(_fileRecords!).where((element) => containsKeyword(element.file, keyword)).toList();

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
        fileRecord: item,
        query: keyword,
        accountId: widget.accountId,
        onTap: () {
          controller
            ..clear()
            ..closeView(null);
          FocusScope.of(context).unfocus();

          context.push('/account/${widget.accountId}/my-data/files/${item.file.id}', extra: item);
        },
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final Set<FileFilterType> activeFilters;
  final void Function(FileFilterType) onRemoveFilter;
  final void Function() onResetFilters;

  const _FilterBar({required this.activeFilters, required this.onRemoveFilter, required this.onResetFilters});

  @override
  Widget build(BuildContext context) {
    final activeFilters = this.activeFilters.map((e) => (filter: e, label: e.toLabel(context))).toList()
      ..sort((a, b) {
        if (a.filter is OtherFileFilterType) return 1;
        if (b.filter is OtherFileFilterType) return -1;
        return a.label.compareTo(b.label);
      });

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: 12,
              children: activeFilters.map((e) {
                return Chip(
                  label: Text(e.label, style: Theme.of(context).textTheme.labelSmall),
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
                  labelPadding: const EdgeInsets.only(left: 8),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () => onRemoveFilter(e.filter),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilesFilterChipBar extends StatelessWidget {
  final FilesFilterOption selectedFilterOption;
  final void Function(FilesFilterOption option) setFilter;
  final bool isBadgeLabelVisible;

  const _FilesFilterChipBar({required this.selectedFilterOption, required this.setFilter, required this.isBadgeLabelVisible});

  @override
  Widget build(BuildContext context) {
    return FilterChipBar(
      onInfoPressed: () => (),
      children: [
        for (final option in FilesFilterOption.values)
          _FilesCondensedFilterChip(
            onPressed: () => setFilter(option),
            icon: option.filterIcon,
            filterOption: option,
            isBadgeLabelVisible: isBadgeLabelVisible,
            label: switch (option) {
              FilesFilterOption.all => context.l10n.files_filterOption_all,
              FilesFilterOption.unviewed => context.l10n.files_filterOption_new,
              FilesFilterOption.expired => context.l10n.files_filterOption_expired,
              _ => null,
            },
            isSelected: selectedFilterOption == option,
            foregroundColor: switch (option) {
              FilesFilterOption.unviewed => Theme.of(context).colorScheme.secondary,
              FilesFilterOption.expired => Theme.of(context).colorScheme.error,
              _ => Theme.of(context).colorScheme.onSurfaceVariant,
            },
            backgroundColor: switch (option) {
              FilesFilterOption.unviewed => Theme.of(context).colorScheme.secondaryContainer,
              FilesFilterOption.expired => Theme.of(context).colorScheme.errorContainer,
              _ => Theme.of(context).colorScheme.surfaceContainerHighest,
            },
          ),
      ],
    );
  }
}

class _FilesCondensedFilterChip extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool isSelected;
  final FilesFilterOption filterOption;
  final bool isBadgeLabelVisible;
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const _FilesCondensedFilterChip({
    required this.onPressed,
    required this.icon,
    required this.isSelected,
    required this.filterOption,
    required this.isBadgeLabelVisible,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest;
    final foregroundColor = this.foregroundColor ?? Theme.of(context).colorScheme.onSurface;

    final icon = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Icon(this.icon, size: 18, color: foregroundColor),
    );

    final filterChipIcon = switch (filterOption) {
      FilesFilterOption.type || FilesFilterOption.tags => Badge(
        isLabelVisible: isBadgeLabelVisible && isSelected,
        backgroundColor: Theme.of(context).primaryColor,
        child: icon,
      ),
      _ => icon,
    };

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: switch (filterOption) {
          FilesFilterOption.type || FilesFilterOption.tags => onPressed,
          _ => isSelected ? null : onPressed,
        },
        child: Container(
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: isSelected
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    filterChipIcon,
                    if (label != null) Text(label!, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: foregroundColor)),
                  ],
                )
              : filterChipIcon,
        ),
      ),
    );
  }
}

class _EmptyFilesIndicator extends StatelessWidget {
  final String accountId;
  final FilesFilterOption filterOption;
  final VoidCallback uploadFile;

  const _EmptyFilesIndicator({required this.accountId, required this.filterOption, required this.uploadFile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: EmptyListIndicator(
        icon: filterOption.emptyListIcon,
        text: switch (filterOption) {
          FilesFilterOption.unviewed => context.l10n.files_noNewFiles,
          FilesFilterOption.expired => context.l10n.files_noExpiredFiles,
          _ => context.l10n.files_noFilesAvailable,
        },
        description: switch (filterOption) {
          FilesFilterOption.unviewed || FilesFilterOption.expired => null,
          _ => context.l10n.files_noFilesAvailable_description,
        },
        action: filterOption != FilesFilterOption.all
            ? null
            : TextButton(onPressed: uploadFile, child: Text(context.l10n.files_noFilesAvailable_addFiles)),
      ),
    );
  }
}
