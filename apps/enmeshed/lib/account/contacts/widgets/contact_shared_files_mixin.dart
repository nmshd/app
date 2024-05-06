import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class ContactSharedFilesWidget extends StatefulWidget {
  final String accountId;
  final String contactId;

  const ContactSharedFilesWidget({required this.accountId, required this.contactId, super.key});
}

mixin ContactSharedFilesMixin<T extends ContactSharedFilesWidget> on State<T> {
  final List<StreamSubscription<void>> _subscriptions = [];
  @protected
  Set<FileDVO>? sharedFiles;

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

    final messageResult = await session.transportServices.messages.getMessages(
      query: {
        'participant': QueryValue.string(widget.contactId),
      },
    );

    final messages = await session.expander.expandMessageDTOs(messageResult.value);
    messages.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));

    if (mounted) {
      setState(() {
        sharedFiles = <FileDVO>{};
        for (final message in messages) {
          sharedFiles!.addAll(
            message.attachments.where(
              (attachment) => !sharedFiles!.any((file) => file.id == attachment.id),
            ),
          );
        }
      });
    }
  }
}
