import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../types/types.dart';
import '../utils/utils.dart';
import 'highlight_text.dart';

enum FileRecordStatus { fileExpired, unviewedRepositoryAttribute, viewed }

class FileItem extends StatelessWidget {
  final String accountId;
  final FileRecord fileRecord;
  final Widget? trailing;
  final String? query;
  final void Function()? onTap;

  const FileItem({required this.accountId, required this.fileRecord, this.trailing, this.query, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final fileNameStyle = fileRecord.fileReferenceAttribute?.wasViewedAt == null
        ? Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)
        : Theme.of(context).textTheme.bodyLarge;

    final fileIsExpired = DateTime.parse(fileRecord.file.expiresAt).isBefore(DateTime.now());

    final creationDate = DateFormat.yMd(Localizations.localeOf(context).languageCode).format(DateTime.parse(fileRecord.file.createdAt));

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 24, top: 12, bottom: 12),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 4,
            children: [
              Text(
                creationDate,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              if (fileIsExpired)
                Text(
                  context.l10n.files_fileExpired,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
          HighlightText(query: query, text: fileRecord.file.name, maxLines: 1, textStyle: fileNameStyle),
        ],
      ),
      subtitle: Row(
        children: [
          Text('${bytesText(context: context, bytes: fileRecord.file.filesize)}, '),
          HighlightText(text: getFileExtension(fileRecord.file.filename), query: query),
        ],
      ),
      leading: _FileCircleAvatar(fileRecord: fileRecord),
      trailing: trailing,
      onTap: onTap ?? () => context.push('/account/$accountId/my-data/files/${fileRecord.file.id}', extra: fileRecord),
    );
  }
}

class _FileCircleAvatar extends StatelessWidget {
  final FileRecord fileRecord;

  const _FileCircleAvatar({required this.fileRecord});

  @override
  Widget build(BuildContext context) {
    final fileRecordStatus = _getFileRecordStatus();

    final circleAvatar = CircleAvatar(
      backgroundColor: switch (fileRecordStatus) {
        FileRecordStatus.fileExpired => Theme.of(context).colorScheme.errorContainer,
        FileRecordStatus.unviewedRepositoryAttribute => Theme.of(context).colorScheme.secondaryContainer,
        FileRecordStatus.viewed => Theme.of(context).colorScheme.surfaceContainer,
      },
      child: FileIcon(
        filename: fileRecord.file.filename,
        color: switch (fileRecordStatus) {
          FileRecordStatus.fileExpired => Theme.of(context).colorScheme.onErrorContainer,
          FileRecordStatus.unviewedRepositoryAttribute => Theme.of(context).colorScheme.onSecondaryContainer,
          FileRecordStatus.viewed => Theme.of(context).colorScheme.onSurfaceVariant,
        },
      ),
    );

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: switch (fileRecordStatus) {
            FileRecordStatus.fileExpired => Theme.of(context).colorScheme.error,
            FileRecordStatus.unviewedRepositoryAttribute => Theme.of(context).colorScheme.secondary,
            FileRecordStatus.viewed => Colors.transparent,
          },
          width: 3,
        ),
      ),
      padding: const EdgeInsets.all(1),
      child: circleAvatar,
    );
  }

  FileRecordStatus _getFileRecordStatus() {
    if (DateTime.parse(fileRecord.file.expiresAt).isBefore(DateTime.now())) return FileRecordStatus.fileExpired;
    if (fileRecord.fileReferenceAttribute is RepositoryAttributeDVO && fileRecord.fileReferenceAttribute?.wasViewedAt == null) {
      return FileRecordStatus.unviewedRepositoryAttribute;
    }
    return FileRecordStatus.viewed;
  }
}
