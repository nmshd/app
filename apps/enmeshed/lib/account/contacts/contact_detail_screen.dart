import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/core/core.dart';
import 'modals/rename_contact.dart';
import 'modals/request_certificate.dart';
import 'widgets/contact_shared_files.dart';
import 'widgets/contact_shared_files_mixin.dart';

class ContactDetailScreen extends ContactSharedFilesWidget {
  const ContactDetailScreen({required super.accountId, required super.contactId, super.key});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> with ContactSharedFilesMixin<ContactDetailScreen> {
  bool _loadingFavoriteContact = false;

  late final Session _session;

  IdentityDVO? _contact;
  bool _showSendCertificateButton = false;
  int _unreadMessagesCount = 0;
  List<MessageDVO>? _incomingMessages;

  final List<StreamSubscription<void>> _subscriptions = [];

  bool? get _isFavoriteContact => _contact?.relationship?.isPinned;

  @override
  void initState() {
    super.initState();

    _session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    _reloadContact().then((_) {
      _loadShowSendCertificateButton();
      _reloadMessages();
    });

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<MessageSentEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<MessageWasReadAtChangedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<IncomingRequestStatusChangedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<RelationshipChangedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reloadMessages()));
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

    if (_contact == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    final contact = _contact!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _reloadContact();
            await _reloadMessages();
            await _loadShowSendCertificateButton();
            await loadSharedFiles(syncBefore: true);
          },
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      ContactCircleAvatar(contact: contact, radius: 32),
                      Gaps.w16,
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact.isUnknown ? context.l10n.contacts_unknown : contact.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            switch (contact.relationship?.status) {
                              RelationshipStatus.Active => Text(
                                  context.l10n.contactDetail_connectedSince(
                                    DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(DateTime.parse(contact.date!).toLocal()),
                                  ),
                                ),
                              RelationshipStatus.Pending => Text(
                                  context.l10n.contactDetail_requestedAt(
                                    DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(DateTime.parse(contact.date!).toLocal()),
                                  ),
                                ),
                              _ => const SizedBox.shrink(),
                            },
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (contact.relationship?.status == RelationshipStatus.Pending)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ColoredBox(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.hourglass_top, color: Theme.of(context).colorScheme.onSurfaceVariant),
                            Gaps.w8,
                            Text(
                              context.l10n.contactDetail_notAcceptedYet,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      if (_loadingFavoriteContact)
                        const IconButton(onPressed: null, icon: SizedBox(width: 24, height: 24, child: CircularProgressIndicator()))
                      else
                        IconButton(
                          icon: _isFavoriteContact ?? false ? const Icon(Icons.star) : const Icon(Icons.star_border),
                          color: _isFavoriteContact ?? false ? Theme.of(context).colorScheme.primary : null,
                          onPressed: _isFavoriteContact == null ? null : _toggleFavoriteContact,
                          tooltip: switch (_isFavoriteContact) {
                            true => context.l10n.contactDetail_removeFromFavorites,
                            false => context.l10n.contactDetail_addToFavorites,
                            null => null,
                          },
                        ),
                      IconButton(
                        onPressed: _renameContact,
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: context.l10n.contactDetail_editContact,
                      ),
                      if (contact.relationship?.status == RelationshipStatus.Active)
                        IconButton(
                          onPressed: () => context.push('/account/${widget.accountId}/mailbox/send', extra: _contact),
                          icon: const Icon(Icons.mail_outlined),
                          tooltip: context.l10n.contactDetail_sendMessage,
                        ),
                      if (_showSendCertificateButton)
                        IconButton(
                          onPressed: () => showRequestCertificateModal(context: context, session: _session, peer: contact.id),
                          icon: const Icon(Icons.security),
                          tooltip: context.l10n.contactDetail_requestCertificate,
                        ),
                      IconButton(
                        onPressed: () => deleteContact(
                          context: context,
                          accountId: widget.accountId,
                          contact: contact,
                          onContactDeleted: () {
                            if (context.mounted) context.pop();
                          },
                        ),
                        icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                        tooltip: context.l10n.contacts_delete_deleteContact,
                      ),
                    ],
                  ),
                ),
                Gaps.h16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                Gaps.h16,
                MessagesContainer(
                  accountId: widget.accountId,
                  messages: _incomingMessages,
                  unreadMessagesCount: _unreadMessagesCount,
                  seeAllMessages: _incomingMessages != null && _incomingMessages!.isNotEmpty
                      ? () => context.go('/account/${widget.accountId}/mailbox', extra: widget.contactId)
                      : null,
                  title: context.l10n.contact_information_messages,
                  noMessagesText: context.l10n.contact_information_noMessages,
                  hideAvatar: true,
                ),
                Gaps.h16,
                ContactSharedFiles(
                  accountId: widget.accountId,
                  contactId: widget.contactId,
                  sharedFiles: sharedFiles,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _reloadContact() async {
    final contact = await _session.expander.expandAddress(widget.contactId);

    if (!mounted) return;

    setState(() {
      _contact = contact;
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
    setState(() => _loadingFavoriteContact = true);

    await toggleContactPinned(
      relationshipId: _contact!.relationship!.id,
      session: GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId),
    );

    await _reloadContact();

    setState(() => _loadingFavoriteContact = false);
  }

  Future<void> _renameContact() async {
    if (_contact == null) return;

    final contact = _contact!;

    var newName = await showRenameContactModal(context: context, contact: contact);
    if (newName == null) return;

    if (newName == contact.name) return;
    if (newName == contact.originalName) newName = null;

    await setContactName(relationshipId: contact.relationship!.id, session: _session, accountId: widget.accountId, contactName: newName);
    await _reloadContact();

    if (mounted) showSuccessSnackbar(context: context, text: context.l10n.contactDetail_editContact_displayNameChangedMessage);
  }
}
