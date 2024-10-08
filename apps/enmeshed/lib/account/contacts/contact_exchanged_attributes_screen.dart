import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:renderers/renderers.dart';

import '/core/core.dart';

class ContactExchangedAttributesScreen extends StatefulWidget {
  final String accountId;
  final String contactId;
  final bool showSharedAttributes;

  const ContactExchangedAttributesScreen({
    required this.accountId,
    required this.contactId,
    required this.showSharedAttributes,
    super.key,
  });

  @override
  State<ContactExchangedAttributesScreen> createState() => _ContactExchangedAttributesScreenState();
}

class _ContactExchangedAttributesScreenState extends State<ContactExchangedAttributesScreen> {
  late final Session _session;

  List<LocalAttributeDVO>? _receivedAttributes;
  List<LocalAttributeDVO>? _sentAttributes;
  String? _contactName;

  @override
  void initState() {
    super.initState();

    _session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    _loadReceivedPeerAttributes();
    _loadSentPeerAttribute();
    _loadContactName();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.showSharedAttributes ? 1 : 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(context.l10n.contactDetail_sharedInformation),
          notificationPredicate: (notification) => notification.depth == 1,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text(
                  context.l10n.contactDetail_receivedAttributes,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Tab(
                child: Text(
                  context.l10n.contactDetail_sharedAttributes,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: _sentAttributes == null || _receivedAttributes == null || _contactName == null
                ? [const Center(child: CircularProgressIndicator()), const Center(child: CircularProgressIndicator())]
                : [
                    RefreshIndicator(
                      onRefresh: () => _loadReceivedPeerAttributes(syncBefore: true),
                      child: _AttributeListView(
                        attributes: _receivedAttributes!,
                        headerText: context.l10n.contactDetail_receivedAttributesDescription(_contactName!),
                        emptyText: context.l10n.contactDetail_noReceivedAttributes,
                        accountId: widget.accountId,
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () => _loadSentPeerAttribute(syncBefore: true),
                      child: _AttributeListView(
                        attributes: _sentAttributes!,
                        headerText: context.l10n.contactDetail_overviewSharedAttributes(_contactName!),
                        emptyText: context.l10n.contactDetail_noSharedAttributes,
                        accountId: widget.accountId,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadReceivedPeerAttributes({bool syncBefore = false}) async {
    if (syncBefore) await _session.transportServices.account.syncDatawallet();

    final receivedAttributesResult = await _session.consumptionServices.attributes.getPeerSharedAttributes(peer: widget.contactId);

    if (receivedAttributesResult.isError) return;
    final receivedAttributes = await _session.expander.expandLocalAttributeDTOs(receivedAttributesResult.value);

    receivedAttributes.sort((a, b) => context.i18nTranslate(a.name).compareTo(context.i18nTranslate(b.name)));

    if (mounted) setState(() => _receivedAttributes = receivedAttributes);
  }

  Future<void> _loadSentPeerAttribute({bool syncBefore = false}) async {
    if (syncBefore) await _session.transportServices.account.syncDatawallet();

    final sentAttributesResult = await _session.consumptionServices.attributes.getOwnSharedAttributes(peer: widget.contactId);

    if (sentAttributesResult.isError) return;
    final sentAttributes = await _session.expander.expandLocalAttributeDTOs(sentAttributesResult.value);

    sentAttributes.sort((a, b) => context.i18nTranslate(a.name).compareTo(context.i18nTranslate(b.name)));

    if (mounted) setState(() => _sentAttributes = sentAttributes);
  }

  Future<void> _loadContactName() async {
    final contact = await _session.expander.expandAddress(widget.contactId);

    if (mounted) setState(() => _contactName = contact.name);
  }
}

class _AttributeListView extends StatelessWidget {
  final String headerText;
  final String emptyText;
  final List<LocalAttributeDVO> attributes;
  final String accountId;

  const _AttributeListView({
    required this.headerText,
    required this.emptyText,
    required this.attributes,
    required this.accountId,
  });

  @override
  Widget build(BuildContext context) {
    if (attributes.isEmpty) return EmptyListIndicator(icon: Icons.three_p, text: emptyText, wrapInListView: true);

    return ListView.separated(
      itemCount: attributes.length + 1,
      separatorBuilder: (context, index) => index == 0 ? const SizedBox.shrink() : const Divider(),
      itemBuilder: (context, index) {
        if (index == 0) return Padding(padding: const EdgeInsets.all(16), child: Text(headerText));

        final attribute = attributes[index - 1];
        Text? extraLine;

        if (attribute is SharedToPeerAttributeDVO) {
          final extraLineTextStyle = Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.error);

          if (attribute.deletionStatus == LocalAttributeDeletionStatus.DeletionRequestSent.name && attribute.sourceAttribute == null) {
            extraLine = Text(context.l10n.contactDetail_deletionRequested, style: extraLineTextStyle);
          }

          if (attribute.deletionStatus == LocalAttributeDeletionStatus.ToBeDeletedByPeer.name && attribute.deletionDate != null) {
            extraLine = Text(
              context.l10n.contactDetail_willBeDeletedOn(DateTime.parse(attribute.deletionDate!).toLocal()),
              style: extraLineTextStyle,
            );
          }

          if (attribute.deletionStatus == LocalAttributeDeletionStatus.DeletionRequestRejected.name) {
            extraLine = Text(context.l10n.contactDetail_deletionRejected, style: extraLineTextStyle);
          }
        }

        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AttributeRenderer.localAttribute(
            attribute: attribute,
            expandFileReference: (fileReference) => expandFileReference(accountId: accountId, fileReference: fileReference),
            openFileDetails: (file) => context.push('/account/$accountId/my-data/files/${file.id}', extra: file),
            extraLine: extraLine,
          ),
        );
      },
    );
  }
}
