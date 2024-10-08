import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';

import '/core/core.dart';

class FilteredDataScreen extends StatefulWidget {
  final String accountId;
  final String title;
  final List<String> valueTypes;
  final bool emphasizeAttributeHeadings;

  const FilteredDataScreen({
    required this.accountId,
    required this.title,
    required this.valueTypes,
    this.emphasizeAttributeHeadings = false,
    super.key,
  });

  @override
  State<FilteredDataScreen> createState() => _FilteredDataScreenState();
}

class _FilteredDataScreenState extends State<FilteredDataScreen> {
  Map<String, List<LocalAttributeDVO>>? _attributes;

  @override
  void initState() {
    super.initState();

    _loadAttributes();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(widget.title));

    if (_attributes == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _loadAttributes(syncBefore: true),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(context.l10n.personalData_filteredData_description(widget.title)),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: widget.valueTypes.length,
                  itemBuilder: (context, index) {
                    final valueType = widget.valueTypes[index];
                    final attributes = _attributes![valueType] ?? [];

                    return _AttributeEntry(
                      valueType: valueType,
                      attributes: attributes,
                      accountId: widget.accountId,
                      loadAttributes: _loadAttributes,
                      emphasizeAttributeHeadings: widget.emphasizeAttributeHeadings,
                    );
                  },
                  separatorBuilder: (context, index) => widget.emphasizeAttributeHeadings ? const SizedBox.shrink() : const Divider(indent: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadAttributes({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final result = await session.consumptionServices.attributes.getRepositoryAttributes(
      query: {'content.value.@type': QueryValue.stringList(widget.valueTypes)},
    );

    if (result.isError) {
      GetIt.I.get<Logger>().e('Getting attributes failed caused by: ${result.error}');

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

    final attributes = await session.expander.expandLocalAttributeDTOs(result.value);

    final map = Map.fromEntries(
      widget.valueTypes.map(
        (e) => MapEntry(
          e,
          attributes.where((element) => (element.content as IdentityAttribute).value.atType == e).toList(),
        ),
      ),
    );

    if (mounted) setState(() => _attributes = map);
  }
}

class _AttributeEntry extends StatelessWidget {
  final String valueType;
  final List<LocalAttributeDVO> attributes;
  final String accountId;
  final Future<void> Function({bool syncBefore}) loadAttributes;
  final bool emphasizeAttributeHeadings;

  const _AttributeEntry({
    required this.valueType,
    required this.attributes,
    required this.accountId,
    required this.loadAttributes,
    required this.emphasizeAttributeHeadings,
  });

  @override
  Widget build(BuildContext context) {
    if (attributes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: _EmptyAttributeEntry(
          valueType: valueType,
          accountId: accountId,
          onAttributeCreated: () => loadAttributes(syncBefore: true),
          emphasizeAttributeHeadings: emphasizeAttributeHeadings,
        ),
      );
    }

    final renderer = Ink(
      child: InkWell(
        onTap: () async {
          await context.push('/account/$accountId/my-data/data-details/$valueType');
          await loadAttributes();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AttributeRenderer.localAttribute(
            attribute: attributes.firstWhere((e) => e.isDefaultRepositoryAttribute, orElse: () => attributes.first),
            showTitle: !emphasizeAttributeHeadings,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (attributes.length > 1) Flexible(child: Text('+${attributes.length - 1}')),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.chevron_right)),
              ],
            ),
            expandFileReference: (fileReference) => expandFileReference(accountId: accountId, fileReference: fileReference),
            openFileDetails: (file) => context.push('/account/$accountId/my-data/files/${file.id}', extra: file),
            valueTextStyle: Theme.of(context).textTheme.bodyLarge!,
          ),
        ),
      ),
    );

    if (!emphasizeAttributeHeadings) return renderer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(context.i18nTranslate('i18n://attributes.values.$valueType._title'), style: Theme.of(context).textTheme.labelMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: renderer,
        ),
      ],
    );
  }
}

class _EmptyAttributeEntry extends StatelessWidget {
  final String valueType;
  final String accountId;
  final VoidCallback onAttributeCreated;
  final bool emphasizeAttributeHeadings;

  const _EmptyAttributeEntry({
    required this.valueType,
    required this.accountId,
    required this.onAttributeCreated,
    required this.emphasizeAttributeHeadings,
  });

  @override
  Widget build(BuildContext context) {
    if (emphasizeAttributeHeadings) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.i18nTranslate('i18n://attributes.values.$valueType._title'),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          TextButton.icon(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary, size: 20),
            label: Text(context.l10n.myData_createEntryForAttributeType),
            onPressed: () => showCreateAttributeModal(
              initialValueType: valueType,
              context: context,
              accountId: accountId,
              onAttributeCreated: onAttributeCreated,
              onCreateAttributePressed: null,
            ),
          ),
        ],
      );
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      tileColor: Theme.of(context).colorScheme.surface,
      title: TranslatedText(
        'i18n://dvo.attribute.name.$valueType',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
      subtitle: Text(
        context.l10n.myData_noEntryForAttributeType,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
      ),
      trailing: TextButton.icon(
        icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary, size: 20),
        label: Text(context.l10n.myData_createEntryForAttributeType),
        onPressed: () => showCreateAttributeModal(
          initialValueType: valueType,
          context: context,
          accountId: accountId,
          onAttributeCreated: onAttributeCreated,
          onCreateAttributePressed: null,
        ),
      ),
    );
  }
}
