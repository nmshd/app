import 'package:flutter/foundation.dart';

sealed class ContactsFilterOption {
  const ContactsFilterOption();
}

@immutable
class ActionRequiredContactsFilterOption extends ContactsFilterOption {
  const ActionRequiredContactsFilterOption();

  @override
  bool operator ==(Object other) => other is ActionRequiredContactsFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class ActiveContactsFilterOption extends ContactsFilterOption {
  const ActiveContactsFilterOption();

  @override
  bool operator ==(Object other) => other is ActiveContactsFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class PendingContactsFilterOption extends ContactsFilterOption {
  const PendingContactsFilterOption();

  @override
  bool operator ==(Object other) => other is PendingContactsFilterOption;

  @override
  int get hashCode => runtimeType.hashCode;
}
