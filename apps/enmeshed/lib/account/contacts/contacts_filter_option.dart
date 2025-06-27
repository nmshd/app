import 'package:flutter/material.dart';

enum ContactsFilterOption {
  all(Icons.contacts, Icons.contacts_outlined),
  active(Icons.check_circle, Icons.check_circle_outline),
  unconfirmed(Icons.sms, Icons.sms_outlined),
  actionRequired(Icons.error, Icons.error_outline);

  final IconData filterIcon;
  final IconData emptyListIcon;

  const ContactsFilterOption(this.filterIcon, this.emptyListIcon);
}
