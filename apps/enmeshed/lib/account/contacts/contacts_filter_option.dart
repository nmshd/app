import 'package:flutter/material.dart';

enum ContactsFilterOption {
  all(Icons.contacts, Icons.contacts_outlined),
  active(Icons.check_circle, Icons.check_circle_outline),
  actionRequired(Icons.error, Icons.error_outline);

  final IconData filterIcon;
  final IconData emptyListIcon;

  const ContactsFilterOption(this.filterIcon, this.emptyListIcon);
}
