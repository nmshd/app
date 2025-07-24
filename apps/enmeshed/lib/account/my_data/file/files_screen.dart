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
import 'files_filter_option.dart';
import 'modals/modals.dart';

class FilesScreen extends StatefulWidget {
  final String accountId;
  final bool initialCreation;
  final FilesFilterOption? preselectedFilter;

  const FilesScreen({required this.accountId, this.initialCreation = false, this.preselectedFilter, super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  List<FileRecord>? _fileRecords;
  List<FileRecord> _filteredFileRecords = [];

  Set<String> _availableTags = {};
  Set<String> _activeTagFilters = {};
  Set<FileFilterType> _activeTypeFilters = {};

  bool _selectTagsEnabled = true;
  bool _selectTypesEnabled = true;

  late FilesFilterOption _filterOption;
  late final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _filterOption = widget.preselectedFilter ?? FilesFilterOption.all;

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    _subscriptions
      ..add(runtime.eventBus.on<AttributeDeletedEvent>().listen((_) => _reloadAndApplyFilters().catchError((_) {})))
      ..add(runtime.eventBus.on<AttributeWasViewedAtChangedEvent>().listen((_) => _reloadAndApplyFilters().catchError((_) {})));

    _reloadAndApplyFilters().then((_) => widget.initialCreation ? _uploadFile() : null);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FilesFilterChipBar(
              selectTagsEnabled: _selectTagsEnabled,
              selectTypesEnabled: _selectTypesEnabled,
              selectedFilterOption: _filterOption,
              typeFiltersActive: _activeTypeFilters.isNotEmpty,
              tagFiltersActive: _activeTagFilters.isNotEmpty,
              showTags: () async {
                setState(() => _selectTagsEnabled = false);
                await _loadFiles(applyFilters: false);

                if (!context.mounted) {
                  setState(() => _selectTagsEnabled = true);
                  return;
                }

                if (_availableTags.isEmpty) {
                  return showEmptyFileFilters(
                    context,
                    title: context.l10n.files_filter_byTag,
                    description: context.l10n.files_filter_byTagEmpty,
                    enableShowEmptyFilters: () => setState(() => _selectTagsEnabled = true),
                  );
                }
                return showSelectFileTags(
                  context,
                  availableTags: _availableTags,
                  activeTags: _activeTagFilters,
                  enableSelectTags: () => setState(() => _selectTagsEnabled = true),
                  onApplyTags: (selectedTags) {
                    setState(() => _activeTagFilters = selectedTags);
                    _reloadAndApplyFilters();
                  },
                );
              },
              showTypes: () async {
                setState(() => _selectTypesEnabled = false);
                await _loadFiles(applyFilters: false);

                if (!context.mounted) {
                  setState(() => _selectTypesEnabled = true);
                  return;
                }

                final availableTypes = _fileRecords!.map((fileRecord) => fileRecord.file.mimetype).toSet().map(FileFilterType.fromMimetype).toSet();

                if (availableTypes.isEmpty) {
                  return showEmptyFileFilters(
                    context,
                    title: context.l10n.files_filter_byFileType,
                    description: context.l10n.files_filter_byFileTypeEmpty,
                    enableShowEmptyFilters: () => setState(() => _selectTypesEnabled = true),
                  );
                }
                return showSelectFileTypes(
                  context,
                  availableTypes: availableTypes,
                  activeTypes: _activeTypeFilters,
                  enableSelectTypes: () => setState(() => _selectTypesEnabled = true),
                  onApplyTypes: (selectedFilters) {
                    setState(() => _activeTypeFilters = selectedFilters);
                    _reloadAndApplyFilters();
                  },
                );
              },
              setFilter: (filter) async {
                setState(() => _filterOption = filter);
                await _reloadAndApplyFilters();
              },
            ),
            if (_activeTypeFilters.isNotEmpty)
              _TypesBar(
                activeTypes: _activeTypeFilters,
                onRemoveType: (removedFilter) {
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
            if (_filteredFileRecords.isEmpty && _filterOption.emptyListIcon != null)
              _EmptyFilesIndicator(accountId: widget.accountId, filterOption: _filterOption, uploadFile: _uploadFile)
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => _reloadAndApplyFilters(syncBefore: true),
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

  Future<void> _reloadAndApplyFilters({bool syncBefore = false}) async {
    await _loadFiles(syncBefore: syncBefore);
    _filterAndSort();
  }

  Future<void> _loadFiles({bool syncBefore = false, bool applyFilters = true}) async {
    final fileRecords = <FileRecord>[];
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final result = await session.consumptionServices.attributes.getRepositoryAttributes(
      query: {
        'content.value.@type': QueryValue.string('IdentityFileReference'),
        if (applyFilters && _filterOption == FilesFilterOption.unviewed) 'wasViewedAt': QueryValue.string('!'),
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

      if (!applyFilters || _filterOption != FilesFilterOption.expired || DateTime.parse(file.expiresAt).isBefore(DateTime.now())) {
        fileRecords.add(
          createFileRecord(file: file, fileReferenceAttribute: fileReferenceAttribute as RepositoryAttributeDVO),
        );
      }
    }
    final tags = <String>{};
    _fileRecords = fileRecords;
    _fileRecords?.forEach((element) => element.fileReferenceAttribute?.tags?.forEach(tags.add));

    setState(() => _availableTags = tags);
  }

  void _filterAndSort() {
    if (_activeTypeFilters.isNotEmpty || _activeTagFilters.isNotEmpty) {
      final filteredFiles = _fileRecords!.where((file) {
        final matchesType = _activeTypeFilters.isEmpty || _activeTypeFilters.contains(FileFilterType.fromMimetype(file.file.mimetype));
        final matchesTags = _activeTagFilters.isEmpty || (file.fileReferenceAttribute?.tags?.any(_activeTagFilters.contains) ?? false);

        return matchesType && matchesTags;
      }).toList()..sort(_compareFunction());

      setState(() => _filteredFileRecords = filteredFiles);
      return;
    }

    final sorted = _fileRecords!..sort(_compareFunction());
    setState(() => _filteredFileRecords = sorted);
  }

  int Function(FileRecord, FileRecord) _compareFunction() => switch (_filterOption) {
    FilesFilterOption.type => (a, b) {
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
  final Set<FileFilterType> activeTypes;
  final void Function(FileFilterType) onRemoveType;

  const _TypesBar({required this.activeTypes, required this.onRemoveType});

  @override
  Widget build(BuildContext context) {
    final activeTypes = this.activeTypes.map((e) => (filter: e, label: e.toLabel(context))).toList()
      ..sort((a, b) {
        if (a.filter is OtherFileFilterType) return 1;
        if (b.filter is OtherFileFilterType) return -1;
        return a.label.compareTo(b.label);
      });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: activeTypes
              .map(
                (e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 2,
                  children: [
                    Text(e.label, style: Theme.of(context).textTheme.labelSmall),
                    GestureDetector(
                      child: const Icon(Icons.close, size: 16),
                      onTap: () => onRemoveType(e.filter),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: activeTags
              .map(
                (e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 2,
                  children: [
                    Text(e, style: Theme.of(context).textTheme.labelSmall),
                    GestureDetector(
                      child: const Icon(Icons.close, size: 16),
                      onTap: () => onRemoveTag(e),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _FilesFilterChipBar extends StatelessWidget {
  final FilesFilterOption selectedFilterOption;
  final Future<void> Function(FilesFilterOption option) setFilter;
  final bool typeFiltersActive;
  final bool tagFiltersActive;
  final bool selectTagsEnabled;
  final bool selectTypesEnabled;
  final VoidCallback showTags;
  final VoidCallback showTypes;

  const _FilesFilterChipBar({
    required this.selectedFilterOption,
    required this.setFilter,
    required this.typeFiltersActive,
    required this.tagFiltersActive,
    required this.selectTagsEnabled,
    required this.selectTypesEnabled,
    required this.showTags,
    required this.showTypes,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChipBar(
      onInfoPressed: () => showFilesFilterHelpModal(context: context),
      children: [
        for (final option in FilesFilterOption.values)
          _FilesCondensedFilterChip(
            onPressed: () => switch (option) {
              FilesFilterOption.tag => selectTagsEnabled ? showTags() : null,
              FilesFilterOption.type => selectTypesEnabled ? showTypes() : null,
              _ => setFilter(option),
            },
            icon: option.filterIcon,
            filterOption: option,
            isTagBadgeVisible: tagFiltersActive,
            isTypeBadgeVisible: typeFiltersActive,
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
  final bool isTagBadgeVisible;
  final bool isTypeBadgeVisible;
  final FilesFilterOption filterOption;
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const _FilesCondensedFilterChip({
    required this.onPressed,
    required this.icon,
    required this.isSelected,
    required this.isTagBadgeVisible,
    required this.isTypeBadgeVisible,
    required this.filterOption,
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

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: switch (filterOption) {
          FilesFilterOption.type || FilesFilterOption.tag => onPressed,
          _ => isSelected ? null : onPressed,
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: isSelected
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        icon,
                        if (label != null)
                          Text(
                            label!,
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: foregroundColor),
                          ),
                      ],
                    )
                  : icon,
            ),

            if (isTagBadgeVisible && filterOption == FilesFilterOption.tag || isTypeBadgeVisible && filterOption == FilesFilterOption.type)
              Positioned(
                top: -1,
                right: -1,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, shape: BoxShape.circle),
                  child: Badge(backgroundColor: Theme.of(context).colorScheme.primary),
                ),
              ),
          ],
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
        icon: filterOption.emptyListIcon!,
        text: switch (filterOption) {
          FilesFilterOption.unviewed => context.l10n.files_noNewFiles,
          FilesFilterOption.expired => context.l10n.files_noExpiredFiles,
          _ => context.l10n.files_noFilesAvailable,
        },
        description: switch (filterOption) {
          FilesFilterOption.unviewed || FilesFilterOption.expired => null,
          _ => context.l10n.files_noFilesAvailable_description,
        },
        action: filterOption == FilesFilterOption.all
            ? TextButton(onPressed: uploadFile, child: Text(context.l10n.files_noFilesAvailable_addFiles))
            : null,
      ),
    );
  }
}
