import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'extensions.dart';

String createdDayText({required DateTime itemCreatedAt, required BuildContext context}) {
  if (DateTime.now().difference(itemCreatedAt).inDays == 0 && DateTime.now().day == itemCreatedAt.day) {
    return context.l10n.mailbox_today;
  } else if (DateTime.now().day - 1 == itemCreatedAt.day) {
    return context.l10n.mailbox_yesterday;
  }

  return DateFormat.yMd(Localizations.localeOf(context).languageCode).format(itemCreatedAt);
}

String bytesText({required BuildContext context, required int bytes}) {
  final format = NumberFormat('#.##', Localizations.localeOf(context).languageCode);

  if (bytes < 1000) {
    return '$bytes B';
  } else if (bytes < 1000 * 1000) {
    return '${format.format(bytes / 1000)} KB';
  } else if (bytes < 1000 * 1000 * 1000) {
    return '${format.format(bytes / (1000 * 1000))} MB';
  } else {
    return '${format.format(bytes / (1000 * 1000 * 1000))} GB';
  }
}
