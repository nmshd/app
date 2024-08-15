import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/file_utils.dart';
import '../utils/strings.dart';
import 'file_icon.dart';
import 'highlight_text.dart';

class FileItem extends StatelessWidget {
  final String accountId;
  final FileDVO file;
  final Widget? trailing;
  final String? query;
  final void Function()? onTap;

  const FileItem({required this.accountId, required this.file, this.trailing, this.query, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 24, top: 12, bottom: 12),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (file.name != file.filename)
            HighlightText(
              query: query,
              text: file.filename,
              maxLines: 1,
              textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          HighlightText(query: query, text: file.name, maxLines: 1),
        ],
      ),
      subtitle: Row(
        children: [
          Text('${bytesText(context: context, bytes: file.filesize)}, '),
          HighlightText(text: getFileExtension(file.filename), query: query),
        ],
      ),
      leading: FileIcon(filename: file.filename),
      trailing: trailing,
      onTap: onTap ?? () => context.push('/account/$accountId/my-data/files/${file.id}', extra: file),
    );
  }
}
