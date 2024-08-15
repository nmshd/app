import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(context.l10n.mailbox_message));

    if (_message == null || _account == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: _MessageInformationHeader(account: _account!, message: _message!),
        ),
        const Divider(height: 2),
        Padding(
          padding: const EdgeInsets.all(16),
          child: switch (_message!) {
            final RequestMessageDVO requestMessage => TranslatedText(
                requestMessage.request.statusText,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            _ => TranslatedText(_message!.name, style: Theme.of(context).textTheme.bodyLarge),
          },
        ),
        if (_message!.attachments.isNotEmpty) ...[
          const Divider(height: 2),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AttachmentsList(accountId: _account!.id, attachments: _message!.attachments),
          ),
        ],
        const Divider(height: 2),
        switch (_message!) {
          final MailDVO mail => _MailInformation(message: mail),
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

  const _MailInformation({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        message.body.replaceAll(CustomRegExp.html, ''),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _RequestInformation extends StatefulWidget {
  final RequestMessageDVO message;
  final LocalAccountDTO account;

  const _RequestInformation({
    required this.message,
    required this.account,
  });

  @override
  State<_RequestInformation> createState() => _RequestInformationState();
}

class _RequestInformationState extends State<_RequestInformation> {
  bool useRequestFromMessage = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RequestDVORenderer(
          accountId: widget.account.id,
          requestId: widget.message.request.id,
          isIncoming: !widget.message.request.isOwn,
          requestDVO: useRequestFromMessage ? widget.message.request : null,
          acceptRequestText: context.l10n.accept,
          onAfterAccept: () => setState(() {
            useRequestFromMessage = false;
          }),
        ),
      ),
    );
  }
}
