import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import 'widgets/contact_shared_files_mixin.dart';

class ContactSharedFilesScreen extends ContactSharedFilesWidget {
  final Set<FileDVO>? sharedFiles;

  const ContactSharedFilesScreen({required super.accountId, required super.contactId, this.sharedFiles, super.key});

  @override
  State<ContactSharedFilesScreen> createState() => _ContactSharedFilesScreenState();
}

class _ContactSharedFilesScreenState extends State<ContactSharedFilesScreen> with ContactSharedFilesMixin<ContactSharedFilesScreen> {
  @override
  void initState() {
    sharedFiles = widget.sharedFiles;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(context.l10n.files));

    if (sharedFiles == null) {
      return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => loadSharedFiles(syncBefore: true),
          child:
              sharedFiles!.isEmpty
                  ? EmptyListIndicator(icon: Icons.file_copy, text: context.l10n.files_noFilesAvailable, wrapInListView: true)
                  : ListView.separated(
                    itemBuilder:
                        (context, index) => FileItem(
                          accountId: widget.accountId,
                          fileRecord: createFileRecord(file: sharedFiles!.elementAt(index)),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                    itemCount: sharedFiles!.length,
                    separatorBuilder: (context, index) => const Divider(height: 2),
                  ),
        ),
      ),
    );
  }
}
