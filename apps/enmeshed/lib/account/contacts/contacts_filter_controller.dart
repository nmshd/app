import 'package:flutter/material.dart';

import 'contacts_filter_option.dart';

class ContactsFilterController extends ValueNotifier<Set<ContactsFilterOption>> {
  ContactsFilterController() : super({});

  VoidCallback? _onOpenContactsFilter;
  set onOpenContactsFilter(VoidCallback callback) => _onOpenContactsFilter = callback;

  bool get isContactsFilterSet => value.isNotEmpty;

  @override
  void dispose() {
    super.dispose();

    _onOpenContactsFilter = null;
  }

  void openContactsFilter() => _onOpenContactsFilter?.call();

  void removeFilter(ContactsFilterOption filter) {
    value.remove(filter);
    notifyListeners();
  }
}
