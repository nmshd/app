import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/core.dart';

class FileInfoContainer extends StatelessWidget {
  final String createdBy;
  final String createdAt;

  const FileInfoContainer({required this.createdBy, required this.createdAt, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.l10n.files_owner}: ',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              Text(
                '${context.l10n.files_createdAt}: ',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          Gaps.w24,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.i18nTranslate(createdBy), style: Theme.of(context).textTheme.bodyMedium),
              Text(context.i18nTranslate(_formatDate(context, createdAt)), style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(BuildContext context, String date) {
    final locale = Localizations.localeOf(context);
    final parsedDate = DateTime.parse(date).toLocal();
    return DateFormat('EEEE, d. MMMM y', locale.toString()).format(parsedDate);
  }
}
