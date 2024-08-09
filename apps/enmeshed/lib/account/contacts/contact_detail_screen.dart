import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/core/core.dart';
import 'modals/request_certificate.dart';
import 'widgets/contact_shared_files.dart';
import 'widgets/contact_shared_files_mixin.dart';

class ContactDetailScreen extends ContactSharedFilesWidget {
  const ContactDetailScreen({required super.accountId, required super.contactId, super.key});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> with ContactSharedFilesMixin<ContactDetailScreen> {
  bool? _isFavoriteContact;
  bool _loadingFavoriteContact = false;

  late final Session _session;

  IdentityDVO? _contact;
  bool _showSendCertificateButton = false;
  int _unreadMessagesCount = 0;
  List<MessageDVO>? _incomingMessages;

  final List<StreamSubscription<void>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    _loadContact().then((_) {
      _loadShowSendCertificateButton();
      _reloadMessages();
    });

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<MessageSentEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<MessageWasReadAtChangedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<IncomingRequestStatusChangedEvent>().listen((_) => _reloadMessages()));
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
    final appBar = AppBar(title: Text(context.l10n.contact_information));

    // TODO(aince42): do not check _incomingMessages for null here, instead make the component handle a null value and show a loading indicator
    if (_contact == null || _incomingMessages == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadContact();
            await _reloadMessages();
            await _loadShowSendCertificateButton();
            await loadSharedFiles(syncBefore: true);
          },
          child: ListView(
            children: [
              ColoredBox(
                color: Theme.of(context).colorScheme.onPrimary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      ContactCircleAvatar(contactName: _contact!.name, radius: 32),
                      Gaps.w8,
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_contact!.name, style: Theme.of(context).textTheme.bodyLarge),
                            if (_contact!.date != null)
                              Text(
                                context.l10n.contactDetail_connectedSince(
                                  DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(DateTime.parse(_contact!.date!).toLocal()),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (context.isFeatureEnabled('DELETE_RELATIONSHIP'))
                        IconButton(
                          onPressed: () => showNotImplementedDialog(context),
                          icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                        ),
                      if (_loadingFavoriteContact)
                        const IconButton(onPressed: null, icon: CircularProgressIndicator())
                      else
                        Align(
                          child: IconButton(
                            icon: _isFavoriteContact ?? false ? const Icon(Icons.star) : const Icon(Icons.star_border),
                            color: _isFavoriteContact ?? false ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.shadow,
                            onPressed: _isFavoriteContact == null ? null : _toggleFavoriteContact,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () => context.push('/account/${widget.accountId}/mailbox/send', extra: _contact),
                        style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.mail, size: 16),
                            Gaps.w8,
                            Text(context.l10n.contactDetail_sendMessage),
                          ],
                        ),
                      ),
                    ),
                    if (_showSendCertificateButton) ...[
                      Gaps.w8,
                      Expanded(
                        child: FilledButton(
                          onPressed: () => showRequestCertificateModal(context: context, session: _session, peer: _contact!.id),
                          style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(AppIcons.requestCertificate, size: 16),
                              Gaps.w8,
                              Text(context.l10n.contactDetail_requestCertificate),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  context.l10n.contactDetail_sharedInformation,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: Text(context.l10n.contactDetail_receivedAttributes),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/account/${widget.accountId}/contacts/${widget.contactId}/exchangedData'),
                  ),
                  const Divider(height: 2),
                  ListTile(
                    title: Text(context.l10n.contactDetail_sharedAttributes),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/account/${widget.accountId}/contacts/${widget.contactId}/exchangedData?showSharedAttributes=true'),
                  ),
                ],
              ),
              MessagesContainer(
                accountId: widget.accountId,
                messages: _incomingMessages!,
                unreadMessagesCount: _unreadMessagesCount,
                seeAllMessages: () => context.go('/account/${widget.accountId}/mailbox', extra: widget.contactId),
                title: context.l10n.contact_information_messages,
                noMessagesText: context.l10n.contact_information_noMessages,
                hideAvatar: true,
              ),
              ContactSharedFiles(
                accountId: widget.accountId,
                contactId: widget.contactId,
                sharedFiles: sharedFiles,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadContact() async {
    final contact = await _session.expander.expandAddress(widget.contactId);
    final isFavorite = await isContactFavorite(relationshipId: contact.relationship!.id, session: _session);

    setState(() {
      _contact = contact;
      _isFavoriteContact = isFavorite;
    });
  }

  Future<void> _reloadMessages() async {
    final messageResult = await _session.transportServices.messages.getMessages(
      query: {
        'createdBy': QueryValue.string(widget.contactId),
        if (!context.showTechnicalMessages) 'content.@type': QueryValue.string(r'~^(Request|Mail)$'),
      },
    );
    final messages = await _session.expander.expandMessageDTOs(messageResult.value);
    messages.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));
    final unreadMessagesCount = messages.where((element) => element.wasReadAt == null).toList().length;
    final limitedMessages = messages.take(5).toList();

    if (mounted) {
      setState(() {
        _unreadMessagesCount = unreadMessagesCount;
        _incomingMessages = limitedMessages;
      });
    }
  }

  Future<void> _loadShowSendCertificateButton() async {
    if (_contact == null) return;
    final peer = _contact!.id;

    final attributesResult = await _session.consumptionServices.attributes.getPeerSharedAttributes(
      peer: peer,
      query: {
        'content.isTechnical': QueryValue.string('true'),
        'content.key': QueryValue.string('AllowCertificateRequest'),
        'content.value.@type': QueryValue.string('ProprietaryBoolean'),
      },
    );

    if (attributesResult.isError) return;

    final attributes = await _session.expander.expandLocalAttributeDTOs(attributesResult.value);

    if (attributes.any((element) => ((element.content as RelationshipAttribute).value as ProprietaryBooleanAttributeValue).value)) {
      setState(() => _showSendCertificateButton = true);
    }
  }

  Future<void> _toggleFavoriteContact() async {
    setState(() {
      _loadingFavoriteContact = true;
    });

    await toggleContactFavorite(
      relationshipId: _contact!.relationship!.id,
      session: _session,
      accountId: widget.accountId,
    );

    if (mounted) {
      setState(() {
        _isFavoriteContact = !_isFavoriteContact!;
        _loadingFavoriteContact = false;
      });
    }
  }
}
