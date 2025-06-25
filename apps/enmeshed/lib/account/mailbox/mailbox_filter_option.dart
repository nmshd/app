import 'package:flutter/material.dart';

enum MailboxFilterOption {
  incoming(Icons.mail, Icons.mail_outline),
  actionRequired(Icons.chat_bubble, Icons.chat_bubble_outline),
  unread(Icons.mark_email_unread, Icons.mark_email_unread_outlined),
  withAttachment(Icons.attachment, Icons.attachment_outlined),
  outgoing(Icons.send, Icons.send_outlined);

  final IconData filterIcon;
  final IconData emptyListIcon;

  const MailboxFilterOption(this.filterIcon, this.emptyListIcon);
}
