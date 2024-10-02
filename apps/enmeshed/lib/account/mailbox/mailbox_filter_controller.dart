import 'package:flutter/material.dart';

import 'mailbox_filter_option.dart';

class MailboxFilterController extends ValueNotifier<Set<MailboxFilterOption>> {
  MailboxFilterController() : super({});

  VoidCallback? _onOpenMailboxFilter;
  set onOpenMailboxFilter(VoidCallback callback) => _onOpenMailboxFilter = callback;

  bool get isMailboxFilterSet => value.isNotEmpty;

  @override
  void dispose() {
    super.dispose();

    _onOpenMailboxFilter = null;
  }

  void openMailboxFilter() => _onOpenMailboxFilter?.call();

  void removeFilter(MailboxFilterOption filterOption) {
    value.remove(filterOption);
    notifyListeners();
  }
}
