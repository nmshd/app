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
                itemBuilder: (context, index) => _AttributeItem(
                  attribute: _attributes![index],
                  sameTypeAttributes: _attributes!,
                  accountId: widget.accountId,
                  reload: () => _loadAttributes(syncBefore: true),
                ),
                separatorBuilder: (context, index) => const Divider(indent: 16),
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

    if (result.value.isEmpty && mounted) context.pop();

    result.value.sort((a, b) {
      final defaultComparison = (b.isDefault != null && b.isDefault! ? 1 : 0) - (a.isDefault != null && a.isDefault! ? 1 : 0);
      return defaultComparison != 0 ? defaultComparison : a.createdAt.compareTo(b.createdAt);
    });

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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(context.l10n.personalData_details_manageEntries),
          ),
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

class _AttributeItem extends StatefulWidget {
  final LocalAttributeDVO attribute;
  final List<LocalAttributeDVO> sameTypeAttributes;
  final String accountId;
  final VoidCallback reload;

  const _AttributeItem({required this.attribute, required this.accountId, required this.sameTypeAttributes, required this.reload});

  @override
  State<_AttributeItem> createState() => _AttributeItemState();
}

class _AttributeItemState extends State<_AttributeItem> {
  bool _isLoadingOnFavoriteAttribute = false;

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
              attribute: widget.attribute,
              showTitle: false,
              expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
              openFileDetails: (file) => context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: file),
            ),
            Row(
              children: [
                if (_isLoadingOnFavoriteAttribute)
                  const IconButton(onPressed: null, icon: SizedBox(width: 24, height: 24, child: CircularProgressIndicator()))
                else
                  IconButton(
                    icon: widget.attribute.isDefaultRepositoryAttribute ? const Icon(Icons.star) : const Icon(Icons.star_border),
                    color: widget.attribute.isDefaultRepositoryAttribute ? Theme.of(context).colorScheme.primary : null,
                    onPressed: _toggleFavoriteAttribute,
                  ),
                Gaps.w24,
                IconButton(
                  icon: const Icon(Icons.mode_edit_outline_outlined),
                  onPressed: () => showSucceedAttributeModal(
                    context: context,
                    accountId: widget.accountId,
                    attribute: widget.attribute,
                    sameTypeAttributes: widget.sameTypeAttributes,
                    onAttributeSucceeded: () {
                      widget.reload();
                      showSuccessSnackbar(context: context, text: context.l10n.personalData_details_attributeSuccessfullySucceeded);
                    },
                  ),
                ),
                Gaps.w24,
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () => context.push('/account/${widget.accountId}/my-data/details/${widget.attribute.id}'),
                ),
                Gaps.w24,
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                  onPressed: () => showDeleteAttributeModal(
                    context: context,
                    accountId: widget.accountId,
                    attribute: widget.attribute,
                    onAttributeDeleted: () {
                      widget.reload();
                      showSuccessSnackbar(context: context, text: context.l10n.personalData_details_attributeSuccessfullyDeleted);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleFavoriteAttribute() async {
    if (widget.attribute.isDefaultRepositoryAttribute) return;

    setState(() => _isLoadingOnFavoriteAttribute = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final result = await session.consumptionServices.attributes.changeDefaultRepositoryAttribute(attributeId: widget.attribute.id);

    if (result.isSuccess) {
      widget.reload();
      setState(() => _isLoadingOnFavoriteAttribute = false);
      if (mounted) showSuccessSnackbar(context: context, text: context.l10n.personalData_details_attributeSuccessfullyFavored);
      return;
    }

    if (mounted) {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
            content: Text(context.l10n.error_changeFavoriteRepositoryAttribute),
          );
        },
      );
    }

    setState(() => _isLoadingOnFavoriteAttribute = false);
  }
}
