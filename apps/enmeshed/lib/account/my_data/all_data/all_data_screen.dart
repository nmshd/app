import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';

import '/core/core.dart';

class AllDataScreen extends StatefulWidget {
  final String accountId;

  const AllDataScreen({required this.accountId, super.key});

  @override
  State<AllDataScreen> createState() => _AllDataScreenState();
}

class _AllDataScreenState extends State<AllDataScreen> {
  List<LocalAttributeDVO>? _attributes;

  @override
  void initState() {
    super.initState();

    _loadAttributes();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(context.l10n.myData_allData),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => showCreateAttributeModal(
            context: context,
            accountId: widget.accountId,
            onAttributeCreated: () => _loadAttributes(syncBefore: true),
            onCreateAttributePressed: null,
          ),
        ),
      ],
    );

    if (_attributes == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _loadAttributes(syncBefore: true),
          child: _attributes!.isEmpty
              ? EmptyListIndicator(icon: Icons.co_present_outlined, text: context.l10n.no_data_available, wrapInListView: true)
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final attribute = _attributes![index];

                    return Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: AttributeRenderer.localAttribute(
                        attribute: attribute,
                        trailing: IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () => context.push(
                            '/account/${widget.accountId}/my-data/details/${attribute.id}',
                            extra: attribute is RepositoryAttributeDVO ? attribute : null,
                          ),
                        ),
                        expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                        openFileDetails: (file) => context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: file),
                      ),
                    );
                  },
                  itemCount: _attributes!.length,
                  separatorBuilder: (context, index) => const Divider(indent: 16),
                ),
        ),
      ),
    );
  }

  Future<void> _loadAttributes({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final result = await session.consumptionServices.attributes.getRepositoryAttributes();

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

    attributes.sort((a, b) => context.i18nTranslate(a.name).compareTo(context.i18nTranslate(b.name)));

    if (mounted) setState(() => _attributes = attributes);
  }
}
