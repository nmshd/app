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
import 'modals/modals.dart';

enum _FilesFilterOption {
  all(Icons.format_list_bulleted, Icons.format_list_bulleted),
  unviewed(Icons.new_releases, Icons.new_releases_outlined),
  expired(Icons.error, Icons.error_outline),
  type(Icons.insert_drive_file, null),
  tags(Icons.bookmark, null);

  final IconData filterIcon;
  final IconData? emptyListIcon;

  const _FilesFilterOption(this.filterIcon, this.emptyListIcon);
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

  Set<String> _availableTags = {};
  Set<String> _activeTagFilters = {};
  Set<FileFilterType> _activeTypeFilters = {};

  _FilesFilterOption _filterOption = _FilesFilterOption.all;

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
            _FilesFilterChipBar(
              selectedFilterOption: _filterOption,
              isBadgeLabelVisible: _activeTypeFilters.isNotEmpty || _activeTagFilters.isNotEmpty,
              activeTypeFilters: _activeTypeFilters,
              activeTagFilters: _activeTagFilters,
              showTags: () {
                if (_availableTags.isEmpty) {
                  return showEmptyFileFilters(
                    context,
                    title: context.l10n.files_filter_byTag,
                    description: context.l10n.files_filter_byTagEmpty,
                  );
                }
                return showSelectFileTags(
                  context,
                  availableTags: _availableTags,
                  activeTags: _activeTagFilters,
                  onApplyTags: (selectedTags) {
                    if (selectedTags.isEmpty) return;
                    setState(() {
                      _activeTagFilters = selectedTags;
                      _activeTypeFilters = {};
                    });
                    _filterAndSort();
                  },
                );
              },
              showTypes: () {
                final availableFilters = _fileRecords!.map((fileRecord) => fileRecord.file.mimetype).toSet().map(FileFilterType.fromMimetype).toSet();

                if (availableFilters.isEmpty) {
                  return showEmptyFileFilters(
                    context,
                    title: context.l10n.files_filter_byFileType,
                    description: context.l10n.files_filter_byFileTypeEmpty,
                  );
                }

                return showSelectFileTypes(
                  context,
                  availableTypes: availableFilters,
                  activeTypes: _activeTypeFilters,
                  onApplyTypes: (selectedFilters) {
                    if (selectedFilters.isEmpty) return;
                    setState(() {
                      _activeTypeFilters = selectedFilters;
                      _activeTagFilters = {};
                    });
                    _filterAndSort();
                  },
                );
              },

              setFilter: (filter) async {
                setState(() => _filterOption = filter);
                if (filter == _FilesFilterOption.expired || filter == _FilesFilterOption.unviewed) setState(() => _activeTypeFilters = {});
                await _loadFiles();
              },
            ),
            if (_activeTypeFilters.isNotEmpty)
              _TypesBar(
                activeFilters: _activeTypeFilters,
                onRemoveFilter: (removedFilter) {
                  _activeTypeFilters.remove(removedFilter);
                  _filterAndSort();
                },
              ),

            if (_activeTagFilters.isNotEmpty)
              _TagsBar(
                activeTags: _activeTagFilters,
                onRemoveTag: (removedTag) {
                  _activeTagFilters.remove(removedTag);
                  _filterAndSort();
                },
              ),
            if (_fileRecords!.isEmpty && _filterOption.emptyListIcon != null)
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
        if (_filterOption == _FilesFilterOption.unviewed) 'wasViewedAt': QueryValue.string('!'),
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

      if (_filterOption != _FilesFilterOption.expired || DateTime.parse(file.expiresAt).isBefore(DateTime.now())) {
        fileRecords.add(
          createFileRecord(file: file, fileReferenceAttribute: fileReferenceAttribute as RepositoryAttributeDVO),
        );
      }
    }
    _fileRecords = fileRecords;

    final tags = <String>{};

    _fileRecords?.forEach((element) => element.fileReferenceAttribute?.tags?.forEach(tags.add));
    setState(() => _availableTags = tags);

    _filterAndSort();
  }

  void _filterAndSort() {
    if (_activeTypeFilters.isEmpty && _activeTagFilters.isEmpty) {
      final sorted = _fileRecords!..sort(_compareFunction());
      setState(() => _filteredFileRecords = sorted);
      return;
    }

    if (_activeTypeFilters.isNotEmpty) {
      final filteredFiles =
          _fileRecords!.where((fileRecord) => _activeTypeFilters.contains(FileFilterType.fromMimetype(fileRecord.file.mimetype))).toList()
            ..sort(_compareFunction());
      setState(() => _filteredFileRecords = filteredFiles);
      return;
    } else if (_activeTagFilters.isNotEmpty) {
      final filteredFiles = _fileRecords!.where((fileRecord) {
        final tags = fileRecord.fileReferenceAttribute?.tags;
        if (tags == null) return false;
        return tags.any((tag) => _activeTagFilters.contains(tag));
      }).toList()..sort(_compareFunction());
      setState(() => _filteredFileRecords = filteredFiles);
    }
  }

  int Function(FileRecord, FileRecord) _compareFunction() => switch (_filterOption) {
    _FilesFilterOption.type => (a, b) {
      final aType = a.file.mimetype.split('/').last;
      final bType = b.file.mimetype.split('/').last;
      return bType.compareTo(aType);
    },
    _ => (a, b) => b.file.createdAt.compareTo(a.file.createdAt),
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

class _TypesBar extends StatelessWidget {
  final Set<FileFilterType> activeFilters;
  final void Function(FileFilterType) onRemoveFilter;

  const _TypesBar({required this.activeFilters, required this.onRemoveFilter});

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

class _TagsBar extends StatelessWidget {
  final Set<String> activeTags;
  final void Function(String) onRemoveTag;

  const _TagsBar({required this.activeTags, required this.onRemoveTag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: 12,
              children: activeTags.map((e) {
                return Chip(
                  label: Text(e, style: Theme.of(context).textTheme.labelSmall),
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
                  labelPadding: const EdgeInsets.only(left: 8),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () => onRemoveTag(e),
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
  final _FilesFilterOption selectedFilterOption;
  final Future<void> Function(_FilesFilterOption option) setFilter;
  final bool isBadgeLabelVisible;
  final VoidCallback showTags;
  final VoidCallback showTypes;
  final Set<FileFilterType> activeTypeFilters;
  final Set<String> activeTagFilters;

  const _FilesFilterChipBar({
    required this.selectedFilterOption,
    required this.setFilter,
    required this.isBadgeLabelVisible,
    required this.showTags,
    required this.showTypes,
    required this.activeTypeFilters,
    required this.activeTagFilters,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChipBar(
      onInfoPressed: () => (),
      children: [
        for (final option in _FilesFilterOption.values)
          _FilesCondensedFilterChip(
            activeTypeFilters: activeTypeFilters,
            activeTagFilters: activeTagFilters,
            onPressed: () async => switch (option) {
              _FilesFilterOption.tags => {await setFilter(_FilesFilterOption.all), showTags()},
              _FilesFilterOption.type => {await setFilter(_FilesFilterOption.all), showTypes()},
              _ => setFilter(option),
            },
            icon: option.filterIcon,
            filterOption: option,
            isBadgeLabelVisible: isBadgeLabelVisible,
            label: switch (option) {
              _FilesFilterOption.all => context.l10n.files_filterOption_all,
              _FilesFilterOption.unviewed => context.l10n.files_filterOption_new,
              _FilesFilterOption.expired => context.l10n.files_filterOption_expired,
              _ => null,
            },
            isSelected: selectedFilterOption == option,
            foregroundColor: switch (option) {
              _FilesFilterOption.unviewed => Theme.of(context).colorScheme.secondary,
              _FilesFilterOption.expired => Theme.of(context).colorScheme.error,
              _ => Theme.of(context).colorScheme.onSurfaceVariant,
            },
            backgroundColor: switch (option) {
              _FilesFilterOption.unviewed => Theme.of(context).colorScheme.secondaryContainer,
              _FilesFilterOption.expired => Theme.of(context).colorScheme.errorContainer,
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
  final _FilesFilterOption filterOption;
  final bool isBadgeLabelVisible;
  final Set<FileFilterType> activeTypeFilters;
  final Set<String> activeTagFilters;
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const _FilesCondensedFilterChip({
    required this.onPressed,
    required this.icon,
    required this.isSelected,
    required this.filterOption,
    required this.isBadgeLabelVisible,
    required this.activeTypeFilters,
    required this.activeTagFilters,
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

    final filterChipIcon =
        (activeTypeFilters.isNotEmpty && filterOption == _FilesFilterOption.type) ||
            (activeTagFilters.isNotEmpty && filterOption == _FilesFilterOption.tags)
        ? Badge(
            isLabelVisible: isBadgeLabelVisible,
            backgroundColor: Theme.of(context).primaryColor,
            child: icon,
          )
        : icon;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: isSelected ? null : onPressed,
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
  final _FilesFilterOption filterOption;
  final VoidCallback uploadFile;

  const _EmptyFilesIndicator({required this.accountId, required this.filterOption, required this.uploadFile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: EmptyListIndicator(
        icon: filterOption.emptyListIcon!,
        text: switch (filterOption) {
          _FilesFilterOption.unviewed => context.l10n.files_noNewFiles,
          _FilesFilterOption.expired => context.l10n.files_noExpiredFiles,
          _ => context.l10n.files_noFilesAvailable,
        },
        description: switch (filterOption) {
          _FilesFilterOption.unviewed || _FilesFilterOption.expired => null,
          _ => context.l10n.files_noFilesAvailable_description,
        },
        action: filterOption != _FilesFilterOption.all
            ? null
            : TextButton(onPressed: uploadFile, child: Text(context.l10n.files_noFilesAvailable_addFiles)),
      ),
    );
  }
}
