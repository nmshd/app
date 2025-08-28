import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher_string.dart' as url_launcher;

import '/core/core.dart';
import 'send_mail_screen/widgets/attachments_list.dart';

class MessageDetailScreen extends StatefulWidget {
  final String messageId;
  final String accountId;

  const MessageDetailScreen({required this.messageId, required this.accountId, super.key});

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  MessageDVO? _message;
  LocalAccountDTO? _account;
  bool _markingMessageAsUnread = false;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(context.l10n.mailbox_message),
      actions: [
        IconButton(
          icon: const Icon(Icons.mark_email_unread),
          onPressed: _markingMessageAsUnread ? null : _markMessageAsUnread,
        ),
      ],
    );

    if (_message == null || _account == null) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final subject = switch (_message!) {
      final MailDVO mail => mail.subject.trim(),
      final RequestMessageDVO requestMessage => requestMessage.request.content.title?.trim(),
      _ => null,
    };

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: _MessageInformationHeader(account: _account!, message: _message!),
        ),
        if (subject != null && subject.isNotEmpty) ...[
          const Divider(height: 2),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(subject, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
        if (_message!.attachments.isNotEmpty) ...[
          const Divider(height: 2),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AttachmentsList(accountId: _account!.id, attachments: _message!.attachments),
          ),
        ],
        const Divider(height: 2),
        switch (_message!) {
          final MailDVO mail => _MailInformation(message: mail, id: widget.accountId),
          final RequestMessageDVO requestMessage => _RequestInformation(message: requestMessage, account: _account!),
          _ => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(context.l10n.mailbox_technicalMessage, style: Theme.of(context).textTheme.bodyLarge),
          ),
        },
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: _message is RequestMessageDVO ? column : Scrollbar(thumbVisibility: true, child: SingleChildScrollView(child: column)),
      ),
    );
  }

  Future<void> _loadData() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final account = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccount(widget.accountId);

    final messageResult = await session.transportServices.messages.getMessage(widget.messageId);
    final message = await session.expander.expandMessageDTO(messageResult.value);

    if (mounted) {
      setState(() {
        _account = account;
        _message = message;
      });
    }

    if (message.wasReadAt == null) await session.transportServices.messages.markMessageAsRead(widget.messageId);
  }

  Future<void> _markMessageAsUnread() async {
    if (_markingMessageAsUnread) return;

    setState(() => _markingMessageAsUnread = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final result = await session.transportServices.messages.markMessageAsUnread(widget.messageId);

    if (!mounted) return;

    if (result.isError) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('context.l10n.mailbox_markAsUnreadError')));
      return;
    }

    context.pop();
  }
}

class _MessageInformationHeader extends StatelessWidget {
  final MessageDVO message;
  final LocalAccountDTO account;

  const _MessageInformationHeader({required this.message, required this.account});

  @override
  Widget build(BuildContext context) {
    final messageCreated = DateTime.parse(message.createdAt).toLocal();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ContactCircleAvatar(contact: message.createdBy.isSelf ? message.recipients[0] : message.createdBy, radius: 24),
            Gaps.w16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.createdBy.isSelf ? context.l10n.mailbox_to : context.l10n.mailbox_from,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Text(
                        createdDayText(itemCreatedAt: messageCreated, context: context),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Expanded(
                        child: Text(
                          message.createdBy.isSelf ? message.recipients[0].name : message.createdBy.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm', Localizations.localeOf(context).languageCode).format(messageCreated),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MailInformation extends StatelessWidget {
  final MailDVO message;
  final String id;
  String credentialOffer = '';

  _MailInformation({required this.message, required this.id});

  @override
  Widget build(BuildContext context) {
    // we want to collect all credential offers into a list and not display them in the text

    final body = message.body
        .replaceAll(CustomRegExp.html, '')
        .replaceAllMapped(RegExp(r'(https?:\/\/[^\s\\]+)'), (match) => '<link>${match.group(1)}</link>')
        .replaceAllMapped(RegExp(r'(openid-credential-offer:\/\/[^\s\\]+)'), (match) {
          credentialOffer = match.group(1)!;
          return '';
        })
        .replaceAllMapped(RegExp(r'(openid4vp:\/\/[^\s\\]+)'), (match) => '<link>${match.group(1)}</link>');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: StyledText(
            text: body,
            style: Theme.of(context).textTheme.bodyLarge,
            tags: {
              'link': StyledTextActionTag(
                (link, _) => _launchUrl(link!),
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            },
          ),
        ),
        if (credentialOffer.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.vpn_key),
              label: const Text('Accept Credential Offer'),
              onPressed: () => _acceptCredentialOffer(credentialOffer),
            ),
          ),
      ],
    );
  }

  Future<void> _acceptCredentialOffer(String url) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(id);
    final result = await session.consumptionServices.openId4Vc.acceptCredentialOffer(credentialOffer);
  }

  Future<void> _launchUrl(String url) async {
    final canLaunch = await url_launcher.canLaunchUrlString(url);
    if (!canLaunch) return;

    await url_launcher.launchUrlString(url);
  }
}

class _RequestInformation extends StatefulWidget {
  final RequestMessageDVO message;
  final LocalAccountDTO account;

  const _RequestInformation({required this.message, required this.account});

  @override
  State<_RequestInformation> createState() => _RequestInformationState();
}

class _RequestInformationState extends State<_RequestInformation> {
  bool useRequestFromMessage = true;

  @override
  Widget build(BuildContext context) {
    final request = widget.message.request;

    return Expanded(
      child: RequestDVORenderer(
        accountId: widget.account.id,
        requestId: request.id,
        isIncoming: !request.isOwn,
        requestDVO: useRequestFromMessage ? request : null,
        acceptRequestText: context.l10n.accept,
        validationErrorDescription: context.l10n.message_request_validationErrorDescription,
        showHeader: false,
        onAfterAccept: () => setState(() => useRequestFromMessage = false),
        validateCreateRelationship: null,
      ),
    );
  }
}
