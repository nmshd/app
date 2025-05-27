import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../utils/extensions.dart';
import 'contact_circle_avatar.dart';
import 'highlight_text.dart';

class MessageListTile extends StatelessWidget {
  final MessageDVO message;
  final String accountId;
  final SearchController? controller;
  final String? query;
  final bool hideAvatar;

  const MessageListTile({required this.message, required this.accountId, super.key, this.controller, this.query, this.hideAvatar = false});

  @override
  Widget build(BuildContext context) {
    final color = switch (message) {
      final MailDVO mail => mail.wasReadAt == null && !mail.isOwn ? Theme.of(context).colorScheme.secondary : Colors.transparent,
      final RequestMessageDVO requestMessage =>
        requestMessage.request.status == LocalRequestStatus.ManualDecisionRequired ? Theme.of(context).colorScheme.error : Colors.transparent,
      _ => Colors.transparent,
    };

    return ListTile(
      visualDensity: hideAvatar ? VisualDensity.compact : null,
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
    final contactName = message.peer.name == unknownContactName ? context.l10n.contacts_unknown : message.peer.name;

    final subjectStyle = message.wasReadAt == null && !message.isOwn
        ? Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)
        : Theme.of(context).textTheme.bodyLarge;

    final subject = switch (message) {
      final MailDVO mail => mail.subject.trim(),
      final RequestMessageDVO requestMessage => requestMessage.request.content.title?.trim() ?? '',
      _ => context.l10n.mailbox_technicalMessage,
    };

    final body = switch (message) {
      final MailDVO mail => mail.body.trim().replaceAll(CustomRegExp.html, ''),
      final RequestMessageDVO requestMessage => requestMessage.request.content.description?.replaceAll(CustomRegExp.html, '').trim() ?? '',
      _ => '',
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 4,
          children: [
            Text(
              timeago.format(DateTime.parse(message.createdAt), locale: Localizations.localeOf(context).languageCode),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              overflow: TextOverflow.ellipsis,
            ),
            if (message.attachments.isNotEmpty) Icon(Icons.attachment, size: 15, color: Theme.of(context).colorScheme.outline),
          ],
        ),
        HighlightText(
          text: contactName,
          query: query,
          textStyle: message.wasReadAt == null && !message.isOwn
              ? Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)
              : Theme.of(context).textTheme.labelMedium,
          maxLines: 1,
        ),
        if (subject.isNotEmpty)
          HighlightText(text: subject, query: query, textStyle: subjectStyle, maxLines: 1)
        else
          Text(context.l10n.mailbox_noSubject, style: subjectStyle!.copyWith(color: Theme.of(context).colorScheme.outline)),
        if (body.isNotEmpty) HighlightText(text: body, query: query, textStyle: Theme.of(context).textTheme.labelMedium, maxLines: 1),
      ],
    );
  }
}
