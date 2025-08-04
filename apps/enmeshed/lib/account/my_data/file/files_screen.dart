import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'file_filter_type.dart';
import 'files_filter_option.dart';
import 'modals/modals.dart';
import 'widgets/widgets.dart';

class FilesScreen extends StatefulWidget {
  final String accountId;
  final bool initialCreation;
  final bool showUnviewedFiles;

  const FilesScreen({required this.accountId, this.initialCreation = false, this.showUnviewedFiles = false, super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  List<FileRecord>? _fileRecords;
  List<FileRecord> _filteredFileRecords = [];

  Set<String> _availableTags = {};
  Set<String> _activeTagFilters = {};
  Set<FileFilterType> _activeTypeFilters = {};

  bool _filteringFiles = false;

  late FilesFilterOption _filterOption;
  late final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _filterOption = widget.showUnviewedFiles ? FilesFilterOption.unviewed : FilesFilterOption.all;

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
            FilesFilterChipBar(
              selectedFilterOption: _filterOption,
              typeFiltersActive: _activeTypeFilters.isNotEmpty,
              tagFiltersActive: _activeTagFilters.isNotEmpty,
              showTags: _showTags,
              showTypes: _showTypes,
              setFilter: (filter) async {
                setState(() => _filterOption = filter);
                _filterAndSort();
              },
            ),
            if (_activeTypeFilters.isNotEmpty || _activeTagFilters.isNotEmpty)
              ActiveTypesAndTagsBar(
                activeTags: _activeTagFilters,
                activeTypes: _activeTypeFilters,
                onRemoveType: (filter) {
                  _activeTypeFilters.remove(filter);
                  _filterAndSort();
                },
                onRemoveTag: (tag) {
                  _activeTagFilters.remove(tag);
                  _filterAndSort();
                },
              ),
            if (_filteringFiles)
              const Center(child: CircularProgressIndicator())
            else if (_filteredFileRecords.isEmpty && _filterOption.emptyListIcon != null)
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

  Future<void> _loadFiles({bool syncBefore = false}) async {
    final fileRecords = <FileRecord>[];
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final result = await session.consumptionServices.attributes.getRepositoryAttributes(
      query: {'content.value.@type': QueryValue.string('IdentityFileReference')},
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
      fileRecords.add(createFileRecord(file: file, fileReferenceAttribute: fileReferenceAttribute as RepositoryAttributeDVO));
    }

    final tags = fileRecords.expand((fileRecord) => fileRecord.fileReferenceAttribute?.tags ?? <String>[]).toSet();

    setState(() {
      _availableTags = tags;
      _fileRecords = fileRecords;
    });
  }

  void _filterAndSort() {
    if (_fileRecords == null) return;

    setState(() => _filteringFiles = true);

    var filteredFiles = <FileRecord>[];

    if (_filterOption == FilesFilterOption.unviewed) {
      filteredFiles = _fileRecords!.where((e) => e.fileReferenceAttribute?.wasViewedAt == null).toList();
    } else if (_filterOption == FilesFilterOption.expired) {
      filteredFiles = _fileRecords!.where((e) {
        final expiresAt = DateTime.tryParse(e.file.expiresAt);
        return expiresAt != null && expiresAt.isBefore(DateTime.now());
      }).toList();
    } else {
      filteredFiles = _fileRecords!;
    }

    if (_activeTagFilters.isEmpty && _activeTypeFilters.isEmpty) {
      filteredFiles.sort(_compareFunction());
      setState(() {
        _filteredFileRecords = filteredFiles;
        _filteringFiles = false;
      });
      return;
    }

    final filteredFilesWithTypesAndTags = filteredFiles.where((file) {
      final matchesType = _activeTypeFilters.isEmpty || _activeTypeFilters.contains(FileFilterType.fromMimetype(file.file.mimetype));
      final matchesTags = _activeTagFilters.isEmpty || (file.fileReferenceAttribute?.tags?.any(_activeTagFilters.contains) ?? false);
      return matchesType && matchesTags;
    }).toList()..sort(_compareFunction());

    setState(() {
      _filteredFileRecords = filteredFilesWithTypesAndTags;
      _filteringFiles = false;
    });
  }

  int Function(FileRecord, FileRecord) _compareFunction() {
    if (_activeTypeFilters.isNotEmpty) {
      return (a, b) {
        final aType = a.file.mimetype.split('/').last;
        final bType = b.file.mimetype.split('/').last;
        return bType.compareTo(aType);
      };
    }
    return (a, b) => b.file.createdAt.compareTo(a.file.createdAt);
  }

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

  Future<void> _showTags() async {
    return showSelectFileTags(
      context,
      availableTags: _availableTags,
      activeTags: _activeTagFilters,
      onApplyTags: (selectedTags) {
        setState(() => _activeTagFilters = selectedTags);
        _filterAndSort();
      },
    );
  }

  Future<void> _showTypes() async {
    final availableTypes = _fileRecords!.map((fileRecord) => fileRecord.file.mimetype).toSet().map(FileFilterType.fromMimetype).toSet();

    return showSelectFileTypes(
      context,
      availableTypes: availableTypes,
      activeTypes: _activeTypeFilters,
      onApplyTypes: (selectedFilters) {
        setState(() => _activeTypeFilters = selectedFilters);
        _filterAndSort();
      },
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
