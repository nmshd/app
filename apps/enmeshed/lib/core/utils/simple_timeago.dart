import 'package:flutter/material.dart';

import 'extensions.dart';

String simpleTimeago(BuildContext context, DateTime date) {
  final currentDay = DateTime.now();
  if (DateUtils.dateOnly(date) == DateUtils.dateOnly(currentDay)) return context.l10n.sorting_group_date_today;

  final daysBefore = date.difference(currentDay).inDays;

  if (DateTime(currentDay.year, currentDay.month) == DateTime(date.year, date.month) && daysBefore > 14) {
    return context.l10n.sorting_group_date_thisMonth;
  }

  return switch (daysBefore) {
    <= 7 => context.l10n.sorting_group_date_thisWeek,
    <= 14 => context.l10n.sorting_group_date_lastWeek,
    <= 365 => context.l10n.sorting_group_date_thisYear,
    _ => context.l10n.sorting_group_date_older,
  };
}
