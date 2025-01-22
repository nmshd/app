import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:renderers/renderers.dart';

import '/core/core.dart';

class AttributeDetailScreen extends StatefulWidget {
  final String accountId;
  final String attributeId;

  const AttributeDetailScreen({
    required this.accountId,
    required this.attributeId,
    super.key,
  });

  @override
  State<AttributeDetailScreen> createState() => _AttributeDetailScreenState();
}

class _AttributeDetailScreenState extends State<AttributeDetailScreen> {
  late final Session _session;

  RepositoryAttributeDVO? _attribute;
  String? _firstVersionCreationDate;
  late List<({IdentityDVO contact, LocalAttributeDVO sharedAttribute})> _sharedWith;

  @override
  void initState() {
    super.initState();

    _session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(_attribute != null ? context.i18nTranslate(_attribute!.name) : ''));

    if (_attribute == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    final lastEditingDate = _firstVersionCreationDate != null ? _attribute!.createdAt : null;
    final creationDate = _firstVersionCreationDate != null ? _firstVersionCreationDate! : _attribute!.createdAt;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: [
            ColoredBox(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AttributeRenderer.localAttribute(
                      attribute: _attribute!,
                      showTitle: false,
                      valueTextStyle: Theme.of(context).textTheme.titleLarge!,
                      expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                      openFileDetails: (file) => context.push(
                        '/account/${widget.accountId}/my-data/files/${file.id}',
                        extra: createFileRecord(file: file, fileReferenceAttribute: _attribute),
                      ),
                    ),
                    if (lastEditingDate != null) ...[
                      Gaps.h8,
                      Text(
                        context.l10n.attributeDetails_succeededAt(
                          _getDateType(DateTime.parse(lastEditingDate).toLocal()),
                          DateTime.parse(lastEditingDate).toLocal(),
                          DateTime.parse(lastEditingDate).toLocal(),
                        ),
                        style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ],
                    Gaps.h8,
                    Text(
                      context.l10n.attributeDetails_createdOn(
                        _getDateType(DateTime.parse(creationDate).toLocal()),
                        DateTime.parse(creationDate).toLocal(),
                        DateTime.parse(creationDate).toLocal(),
                      ),
                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.attributeDetails_info),
                  Gaps.h16,
                  Text(context.l10n.attributeDetails_sharedWith, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _reload(syncBefore: true),
                child: _sharedWith.isEmpty
                    ? EmptyListIndicator(icon: Icons.sensors_off, text: context.l10n.attributeDetails_sharedWithNobody, wrapInListView: true)
                    : ListView.separated(
                        itemCount: _sharedWith.length,
                        itemBuilder: (context, index) {
                          final contact = _sharedWith[index].contact;
                          final sharedAttribute = _sharedWith[index].sharedAttribute;

                          return ContactItem(
                            contact: contact,
                            subtitle: Text(
                              context.l10n.attributeDetails_sharedAt(
                                _getDateType(DateTime.parse(sharedAttribute.createdAt).toLocal()),
                                DateTime.parse(sharedAttribute.createdAt).toLocal(),
                                DateTime.parse(sharedAttribute.createdAt).toLocal(),
                              ),
                            ),
                            onTap: () => context.go('/account/${widget.accountId}/contacts/${contact.id}'),
                            trailing: const Icon(Icons.chevron_right),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(indent: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reload({bool syncBefore = false}) async {
    if (syncBefore) await _session.transportServices.account.syncDatawallet();

    final versionsResult = await _session.consumptionServices.attributes.getVersionsOfAttribute(attributeId: widget.attributeId);
    if (versionsResult.isError) return;
    final versions = versionsResult.value..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final attribute = await _session.expander.expandLocalAttributeDTO(versions.last);

    if (attribute is! RepositoryAttributeDVO) {
      if (!mounted) return;

      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            content: Text(context.l10n.errorDialog_description, textAlign: TextAlign.center),
            actions: [
              FilledButton(
                onPressed: () => context
                  ..pop()
                  ..pop(),
                child: Text(context.l10n.back),
              ),
            ],
          );
        },
      );
    }

    final firstVersionCreationDate = versions.length > 1 ? versions.first.createdAt : null;

    await _loadSharedWith(attribute, firstVersionCreationDate);
  }

  Future<void> _loadSharedWith(RepositoryAttributeDVO attribute, String? firstVersionCreationDate) async {
    final sharedWith = await Future.wait(
      attribute.sharedWith.map(
        (e) async => (
          contact: await _session.expander.expandAddress(e.peer),
          sharedAttribute: e,
        ),
      ),
    );

    if (!mounted) return;

    setState(() {
      _attribute = attribute;
      _firstVersionCreationDate = firstVersionCreationDate;
      _sharedWith = sharedWith;
    });
  }

  String _getDateType(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (dateTime.year == today.year && dateTime.month == today.month && dateTime.day == today.day) {
      return 'today';
    } else if (dateTime.year == yesterday.year && dateTime.month == yesterday.month && dateTime.day == yesterday.day) {
      return 'yesterday';
    } else {
      return 'other';
    }
  }
}
