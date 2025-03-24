import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'widgets/widgets.dart';

class ContactDetailScreen extends ContactSharedFilesWidget {
  const ContactDetailScreen({required super.accountId, required super.contactId, super.key});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> with ContactSharedFilesMixin<ContactDetailScreen> {
  late final ScrollController _scrollController;

  late final Session _session;

  IdentityDVO? _contact;
  bool _showSendCertificateButton = false;
  int _unreadMessagesCount = 0;
  List<MessageDVO>? _incomingMessages;
  List<LocalRequestDVO>? _openRequests;

  final List<StreamSubscription<void>> _subscriptions = [];

  bool? get _isFavoriteContact => _contact?.relationship?.isPinned;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    _reload();

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<MessageSentEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<MessageWasReadAtChangedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<IncomingRequestStatusChangedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<RelationshipChangedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reloadMessages()))
      ..add(runtime.eventBus.on<ContactNameUpdatedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(
        runtime.eventBus.on<LocalAccountDeletionDateChangedEvent>().listen((event) {
          if (!mounted || event.data.deletionDate == null) return;
          context.go('/account/${widget.accountId}/identity-in-deletion');
        }),
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();

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
            controller: _scrollController,
            thumbVisibility: true,
            child: ListView(
              controller: _scrollController,
              children: [
                ContactDetailHeader(contact: contact, request: _openRequests?.firstOrNull),
                ContactStatusInfoContainer(contact: contact),
                if (_openRequests?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ComplexInformationCard(
                      title: context.l10n.contactDetail_openRequestsTitle,
                      icon: Icon(Icons.info, color: Theme.of(context).colorScheme.secondary),
                      description: context.l10n.contactDetail_openRequestsDescription,
                      actionButtons: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () async {
                              await context.push(
                                '/account/${widget.accountId}/contacts/contact-request/${_openRequests!.first.id}',
                                extra: _openRequests!.first,
                              );
                              await _reloadContact();
                            },
                            child: Text(context.l10n.contactDetail_checkRequests),
                          ),
                        ),
                      ],
                    ),
                  ),
                ContactDetailIconBar(
                  session: _session,
                  accountId: widget.accountId,
                  contact: contact,
                  showSendCertificateButton: _showSendCertificateButton,
                  isFavoriteContact: _isFavoriteContact,
                  reloadContact: _reloadContact,
                ),
                Gaps.h16,
                ContactDetailSharedInformation(accountId: widget.accountId, contactId: widget.contactId),
                Gaps.h16,
                MessagesContainer(
                  accountId: widget.accountId,
                  messages: _incomingMessages,
                  unreadMessagesCount: _unreadMessagesCount,
                  seeAllMessages:
                      _incomingMessages != null && _incomingMessages!.isNotEmpty
                          ? () => context.go('/account/${widget.accountId}/mailbox', extra: widget.contactId)
                          : null,
                  title: context.l10n.contact_information_messages,
                  noMessagesText: context.l10n.contact_information_noMessages,
                  hideAvatar: true,
                ),
                Gaps.h16,
                ContactSharedFiles(accountId: widget.accountId, contactId: widget.contactId, sharedFiles: sharedFiles),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _reload() async {
    await _reloadContact();

    unawaited(_loadShowSendCertificateButton());
    unawaited(_reloadMessages());
  }

  Future<void> _reloadContact() async {
    final contact = await _session.expander.expandAddress(widget.contactId);

    final openRequests = await incomingOpenRequestsFromRelationshipTemplate(session: _session, peer: widget.contactId);

    if (!mounted) return;

    setState(() {
      _contact = contact;
      _openRequests = openRequests;
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
}
