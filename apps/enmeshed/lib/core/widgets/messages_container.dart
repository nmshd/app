import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class MessagesContainer extends StatelessWidget {
  final String accountId;
  final List<MessageDVO> messages;
  final int unreadMessagesCount;
  final VoidCallback seeAllMessages;
  final bool hideAvatar;

  const MessagesContainer({
    required this.accountId,
    required this.messages,
    required this.unreadMessagesCount,
    required this.seeAllMessages,
    this.hideAvatar = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MessagesHeader(accountId: accountId, unreadMessagesCount: unreadMessagesCount, seeAllMessages: seeAllMessages),
        Gaps.h8,
        if (messages.isNotEmpty)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => ColoredBox(color: Theme.of(context).colorScheme.onPrimary, child: const Divider(indent: 16)),
            itemBuilder: (context, index) => MessageDVORenderer(message: messages[index], accountId: accountId, hideAvatar: hideAvatar),
            itemCount: messages.length,
          )
        else
          EmptyListIndicator(icon: Icons.mail_outline, text: context.l10n.home_noNewMessages),
      ],
    );
  }
}

class _MessagesHeader extends StatelessWidget {
  final String accountId;
  final int unreadMessagesCount;
  final VoidCallback seeAllMessages;

  const _MessagesHeader({required this.accountId, required this.unreadMessagesCount, required this.seeAllMessages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(context.l10n.home_messages, style: Theme.of(context).textTheme.titleLarge),
              Gaps.w8,
              Visibility(
                visible: unreadMessagesCount > 0,
                child: Badge(
                  label: Text(unreadMessagesCount.toString()),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
          TextButton(onPressed: seeAllMessages, child: Text(context.l10n.home_seeAll)),
        ],
      ),
    );
  }
}
