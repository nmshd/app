import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/core.dart';

abstract class ContactSharedFilesWidget extends StatefulWidget {
  final String accountId;
  final String contactId;

  const ContactSharedFilesWidget({required this.accountId, required this.contactId, super.key});
}

mixin ContactSharedFilesMixin<T extends ContactSharedFilesWidget> on State<T> {
  final List<StreamSubscription<void>> _subscriptions = [];
  @protected
  List<FileRecord>? sharedFiles;

  @override
  void initState() {
    super.initState();

    loadSharedFiles(syncBefore: true);

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<MessageSentEvent>().listen((_) => loadSharedFiles()))
      ..add(runtime.eventBus.on<MessageReceivedEvent>().listen((_) => loadSharedFiles()));
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @protected
  Future<void> loadSharedFiles({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final messageResult = await session.transportServices.messages.getMessages(query: {'participant': QueryValue.string(widget.contactId)});

    final messages = await session.expander.expandMessageDTOs(messageResult.value);
    messages.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));

    final sharedFiles = <FileRecord>[];
    for (final message in messages) {
      sharedFiles.addAll(
        message.attachments
            .where((attachment) => !sharedFiles.any((FileRecord file) => file.file.id == attachment.id))
            .map((file) => (file: file, fileReferenceAttribute: null)),
      );
    }

    final attributes = await session.consumptionServices.attributes.getAttributes(
      query: {'participant': QueryValue.string(widget.contactId), 'content.value.@type': QueryValue.string('IdentityFileReference')},
    );

    final fileReferenceAttributes = await session.expander.expandLocalAttributeDTOs(attributes.value);

    for (final fileReferenceAttribute in fileReferenceAttributes) {
      final fileReference = fileReferenceAttribute.value as IdentityFileReferenceAttributeValue;
      final file = await expandFileReference(accountId: widget.accountId, fileReference: fileReference.value);
      sharedFiles.add(createFileRecord(file: file, fileReferenceAttribute: fileReferenceAttribute as RepositoryAttributeDVO));
    }

    if (mounted) {
      setState(() => this.sharedFiles = sharedFiles);
    }
  }
}
