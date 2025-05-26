import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../utils/extensions.dart';
import 'contact_circle_avatar.dart';
import 'highlight_text.dart';

class MessageDVORenderer extends StatelessWidget {
  final MessageDVO message;
  final String accountId;
  final SearchController? controller;
  final String? query;
  final bool hideAvatar;

  const MessageDVORenderer({required this.message, required this.accountId, super.key, this.controller, this.query, this.hideAvatar = false});

  @override
  Widget build(BuildContext context) {
    final color = switch (message) {
      final MailDVO mail => mail.wasReadAt == null && !mail.isOwn ? Theme.of(context).colorScheme.secondary : Colors.transparent,
      final RequestMessageDVO requestMessage =>
        requestMessage.request.status == LocalRequestStatus.ManualDecisionRequired ? Theme.of(context).colorScheme.error : Colors.transparent,
      _ => Colors.transparent,
    };

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      minLeadingWidth: 0,
      leading: hideAvatar
          ? CircleAvatar(radius: 4, backgroundColor: color)
          : ContactCircleAvatar(radius: 20, contact: message.peer, borderColor: color),
      title: _MessagesContent(message: message, query: query),
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    if (controller != null) {
      controller!.clear();
      controller!.closeView(null);
    }

    context.push('/account/$accountId/mailbox/${message.id}');
  }
}

class _MessagesContent extends StatelessWidget {
  final MessageDVO message;
  final String? query;

  const _MessagesContent({required this.message, this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MessageHeader(message: message, query: query),
        switch (message) {
          final MailDVO mail => _MailContent(message: mail, query: query),
          final RequestMessageDVO requestMessage => _RequestMessageContent(message: requestMessage),
          _ => Text(context.l10n.mailbox_technicalMessage, style: Theme.of(context).textTheme.bodyLarge),
        },
      ],
    );
  }
}

class _MailContent extends StatelessWidget {
  final MailDVO message;
  final String? query;

  const _MailContent({required this.message, this.query});

  @override
  Widget build(BuildContext context) {
    final subjectStyle = message.wasReadAt == null && !message.isOwn
        ? Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)
        : Theme.of(context).textTheme.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.subject.trim().isNotEmpty)
          HighlightText(text: message.subject, query: query, textStyle: subjectStyle, maxLines: 1)
        else
          Text(context.l10n.mailbox_noSubject, style: subjectStyle!.copyWith(color: Theme.of(context).colorScheme.outline)),
        if (message.body.isNotEmpty)
          HighlightText(
            text: message.body.replaceAll(CustomRegExp.html, ''),
            query: query,
            textStyle: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
          ),
      ],
    );
  }
}

class _RequestMessageContent extends StatelessWidget {
  final RequestMessageDVO message;

  const _RequestMessageContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.request.content.title != null && message.request.content.title!.trim().isNotEmpty)
          Text(
            message.request.content.title!,
            style: message.wasReadAt == null && !message.isOwn
                ? Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)
                : Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
          )
        else
          Text(context.l10n.mailbox_noSubject, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline)),
        if (message.request.content.description != null)
          Text(message.request.content.description!.replaceAll(CustomRegExp.html, ''), style: Theme.of(context).textTheme.bodyMedium, maxLines: 1),
      ],
    );
  }
}

class _MessageHeader extends StatelessWidget {
  final MessageDVO message;
  final String? query;

  const _MessageHeader({required this.message, this.query});

  @override
  Widget build(BuildContext context) {
    final contactName = message.peer.name == unknownContactName ? context.l10n.contacts_unknown : message.peer.name;

    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: HighlightText(
            text: contactName,
            query: query,
            textStyle: message.wasReadAt == null && !message.isOwn
                ? Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)
                : Theme.of(context).textTheme.labelMedium,
            maxLines: 1,
          ),
        ),
        if (message.attachments.isNotEmpty) Icon(Icons.attachment, size: 15, color: Theme.of(context).colorScheme.outline),
        Text(
          timeago.format(DateTime.parse(message.createdAt), locale: Localizations.localeOf(context).languageCode),
          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
