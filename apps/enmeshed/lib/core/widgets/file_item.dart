import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import 'file_icon.dart';

class FileItem extends StatelessWidget {
  final String accountId;
  final FileDVO file;

  const FileItem({required this.accountId, required this.file, super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onPrimary,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 8),
        title: TranslatedText(file.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: file.name != file.filename ? Text(file.filename, maxLines: 1, overflow: TextOverflow.ellipsis) : null,
        leading: FileIcon(filename: file.filename),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/account/$accountId/my-data/files/${file.id}', extra: file),
      ),
    );
  }
}
