import 'package:flutter/material.dart';

import 'mailbox_filter_option.dart';

class MailboxFilterController extends ValueNotifier<bool> {
  MailboxFilterController() : super(false);

  VoidCallback? _onOpenMailboxFilter;
  set onOpenMailboxFilter(VoidCallback callback) => _onOpenMailboxFilter = callback;

  bool _isMailboxFilterSet = false;
  bool get isMailboxFilterSet => _isMailboxFilterSet;

  @override
  void dispose() {
    super.dispose();

    _onOpenMailboxFilter = null;
  }

  void openMailboxFilter() => _onOpenMailboxFilter?.call();

  void updateMailboxFilterStatus({required Set<FilterOption> activeFilters}) {
    _isMailboxFilterSet = activeFilters.isNotEmpty;
    notifyListeners();
  }
}
