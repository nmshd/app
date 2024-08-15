import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class ContactSharedFiles extends StatelessWidget {
  final Set<FileDVO>? sharedFiles;
  final String accountId;
  final String contactId;

  const ContactSharedFiles({
    required this.sharedFiles,
    required this.accountId,
    required this.contactId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Row(
              children: [
                Text(
                  context.l10n.contact_information_sharedFiles,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                if (sharedFiles != null && sharedFiles!.isNotEmpty)
                  TextButton(
                    onPressed: () => context.push('/account/$accountId/contacts/$contactId/shared-files', extra: sharedFiles),
                    child: Text(context.l10n.home_seeAll),
                  ),
              ],
            ),
          ),
        ),
        if (sharedFiles == null)
          const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()))
        else
          sharedFiles!.isEmpty
              ? EmptyListIndicator(
                  icon: Icons.file_copy,
                  text: context.l10n.files_noFilesAvailable,
                )
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => FileItem(
                    accountId: accountId,
                    file: sharedFiles!.elementAt(index),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  itemCount: sharedFiles!.length,
                  separatorBuilder: (context, index) => const Divider(height: 2),
                ),
      ],
    );
  }
}
