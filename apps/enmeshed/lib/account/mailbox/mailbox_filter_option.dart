import 'package:flutter/foundation.dart';

sealed class FilterOption {
  const FilterOption();
}

@immutable
class ActionRequiredFilterOption extends FilterOption {
  const ActionRequiredFilterOption();

  @override
  bool operator ==(Object other) => other is ActionRequiredFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class UnreadFilterOption extends FilterOption {
  const UnreadFilterOption();

  @override
  bool operator ==(Object other) => other is UnreadFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class WithAttachmentFilterOption extends FilterOption {
  const WithAttachmentFilterOption();

  @override
  bool operator ==(Object other) => other is WithAttachmentFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class ContactFilterOption extends FilterOption {
  final String contactId;

  const ContactFilterOption(this.contactId);

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContactFilterOption && contactId == other.contactId;

  @override
  int get hashCode => runtimeType.hashCode ^ contactId.hashCode;
}
