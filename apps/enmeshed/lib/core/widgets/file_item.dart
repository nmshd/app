import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../types/types.dart';
import '../utils/utils.dart';
import 'file_icon.dart';
import 'highlight_text.dart';

class FileItem extends StatelessWidget {
  final String accountId;
  final FileRecord fileRecord;
  final Widget? trailing;
  final String? query;
  final void Function()? onTap;

  const FileItem({required this.accountId, required this.fileRecord, this.trailing, this.query, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 24, top: 12, bottom: 12),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fileRecord.file.name != fileRecord.file.filename)
            HighlightText(
              query: query,
              text: fileRecord.file.filename,
              maxLines: 1,
              textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          HighlightText(query: query, text: fileRecord.file.name, maxLines: 1),
        ],
      ),
      subtitle: Row(
        children: [
          Text('${bytesText(context: context, bytes: fileRecord.file.filesize)}, '),
          HighlightText(text: getFileExtension(fileRecord.file.filename), query: query),
        ],
      ),
      leading: FileIcon(filename: fileRecord.file.filename),
      trailing: trailing,
      onTap: onTap ?? () => context.push('/account/$accountId/my-data/files/${fileRecord.file.id}', extra: fileRecord),
    );
  }
}
