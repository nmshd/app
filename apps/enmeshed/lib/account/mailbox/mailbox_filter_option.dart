import 'package:flutter/foundation.dart';

sealed class MailboxFilterOption {
  const MailboxFilterOption();
}

@immutable
class ActionRequiredFilterOption extends MailboxFilterOption {
  const ActionRequiredFilterOption();

  @override
  bool operator ==(Object other) => other is ActionRequiredFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class UnreadFilterOption extends MailboxFilterOption {
  const UnreadFilterOption();

  @override
  bool operator ==(Object other) => other is UnreadFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class WithAttachmentFilterOption extends MailboxFilterOption {
  const WithAttachmentFilterOption();

  @override
  bool operator ==(Object other) => other is WithAttachmentFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class ContactFilterOption extends MailboxFilterOption {
  final String contactId;

  const ContactFilterOption(this.contactId);

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContactFilterOption && contactId == other.contactId;

  @override
  int get hashCode => runtimeType.hashCode ^ contactId.hashCode;
}
