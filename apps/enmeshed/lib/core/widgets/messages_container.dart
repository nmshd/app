import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class MessagesContainer extends StatelessWidget {
  final String accountId;
  final List<MessageDVO>? messages;
  final int unreadMessagesCount;
  final VoidCallback? seeAllMessages;
  final String title;
  final String noMessagesText;
  final bool hideAvatar;

  const MessagesContainer({
    required this.accountId,
    required this.messages,
    required this.unreadMessagesCount,
    required this.seeAllMessages,
    required this.title,
    required this.noMessagesText,
    this.hideAvatar = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MessagesHeader(unreadMessagesCount: unreadMessagesCount, seeAllMessages: seeAllMessages, title: title),
        Gaps.h8,
        if (messages == null)
          const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()))
        else if (messages!.isNotEmpty)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(indent: 16),
            itemBuilder: (context, index) => MessageDVORenderer(
              message: messages![index],
              accountId: accountId,
              hideAvatar: hideAvatar,
            ),
            itemCount: messages!.length,
          )
        else
          EmptyListIndicator(icon: Icons.mail_outline, text: noMessagesText),
      ],
    );
  }
}

class _MessagesHeader extends StatelessWidget {
  final int unreadMessagesCount;
  final VoidCallback? seeAllMessages;
  final String title;

  const _MessagesHeader({
    required this.unreadMessagesCount,
    required this.seeAllMessages,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Gaps.w8,
            if (unreadMessagesCount > 0)
              Badge(
                label: Text(unreadMessagesCount.toString()),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            const Spacer(),
            if (seeAllMessages != null) TextButton(onPressed: seeAllMessages, child: Text(context.l10n.home_seeAll)),
          ],
        ),
      ),
    );
  }
}
