import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';

import '/core/core.dart';

class DataDetailsScreen extends StatefulWidget {
  final String valueType;
  final String accountId;

  const DataDetailsScreen({required this.valueType, required this.accountId, super.key});

  @override
  State<DataDetailsScreen> createState() => _DataDetailsScreenState();
}

class _DataDetailsScreenState extends State<DataDetailsScreen> {
  List<LocalAttributeDVO>? _attributes;

  @override
  void initState() {
    super.initState();

    _loadAttributes();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: TranslatedText('i18n://dvo.attribute.name.${widget.valueType}'));

    if (_attributes == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: [
            _CreateAttribute(
              accountId: widget.accountId,
              valueType: widget.valueType,
              onAttributeCreated: () => _loadAttributes(syncBefore: true),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _attributes!.length,
                itemBuilder: (context, index) => _AttributeItem(attribute: _attributes![index], accountId: widget.accountId),
                separatorBuilder: (context, index) => ColoredBox(color: Theme.of(context).colorScheme.onPrimary, child: const Divider(indent: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadAttributes({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final result = await session.consumptionServices.attributes.getRepositoryAttributes(
      query: {'content.value.@type': QueryValue.string(widget.valueType)},
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

    if (mounted) setState(() => _attributes = attributes);
  }
}

class _CreateAttribute extends StatelessWidget {
  final String valueType;
  final String accountId;
  final VoidCallback onAttributeCreated;

  const _CreateAttribute({required this.valueType, required this.accountId, required this.onAttributeCreated});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.personalData_details_addEntry),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.myEntries, style: const TextStyle(fontWeight: FontWeight.bold)),
              TextButton.icon(
                icon: const Icon(Icons.add, size: 16),
                label: Text(context.l10n.contactDetail_addEntry),
                onPressed: () => showCreateAttributeModal(
                  initialValueType: valueType,
                  context: context,
                  accountId: accountId,
                  onAttributeCreated: onAttributeCreated,
                  onCreateAttributePressed: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttributeItem extends StatelessWidget {
  final LocalAttributeDVO attribute;
  final String accountId;

  const _AttributeItem({required this.attribute, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AttributeRenderer.localAttribute(
              attribute: attribute,
              showTitle: false,
              expandFileReference: (fileReference) => expandFileReference(accountId: accountId, fileReference: fileReference),
              openFileDetails: (file) => context.push('/account/$accountId/my-data/files/${file.id}', extra: file),
            ),
            IconButton(
              icon: const Icon(Icons.info_outlined),
              onPressed: () => context.push(
                '/account/$accountId/my-data/details/${attribute.id}',
                extra: attribute is RepositoryAttributeDVO ? attribute : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
