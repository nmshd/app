import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class MessagesFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const MessagesFacadeView({super.key, required this.runtime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              final rel = await runtime.currentSession.transportServices.relationships.getRelationships();
              if (rel.value.isEmpty) return;

              final recipientAddress = rel.value[0].peer;
              final message = await runtime.currentSession.transportServices.messages.sendMessage(
                recipients: [recipientAddress],
                content: Mail(
                  subject: 'Hello from Enmeshed!',
                  body: 'This is a test message from Enmeshed.',
                  to: [recipientAddress],
                ).toJson(),
              );
              print(message);
            },
            child: const Text('sendMessage'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final messages = await runtime.currentSession.transportServices.messages.getMessages();
              print(messages);
            },
            child: const Text('getMessages'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final messages = await runtime.currentSession.transportServices.messages.getMessages();
              if (messages.isEmpty) return;

              final message = await runtime.currentSession.transportServices.messages.getMessage(messages[0].id);
              print(message);
            },
            child: const Text('getMessage'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final messages = await runtime.currentSession.transportServices.messages.getMessages();
              if (messages.isEmpty) return;

              final messagesWithAttachments = messages.where((element) => element.attachments.isNotEmpty);
              if (messagesWithAttachments.isEmpty) return;

              final messageWithAttachments = messagesWithAttachments.first;
              final response = await runtime.currentSession.transportServices.messages.downloadAttachment(
                messageId: messageWithAttachments.id,
                attachmentId: messageWithAttachments.attachments.first,
              );
              print(response);
            },
            child: const Text('downloadAttachment'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final messages = await runtime.currentSession.transportServices.messages.getMessages();
              if (messages.isEmpty) return;

              final messagesWithAttachments = messages.where((element) => element.attachments.isNotEmpty);
              if (messagesWithAttachments.isEmpty) return;

              final messageWithAttachments = messagesWithAttachments.first;
              final file = await runtime.currentSession.transportServices.messages.getAttachmentMetadata(
                messageId: messageWithAttachments.id,
                attachmentId: messageWithAttachments.attachments.first,
              );
              print(file);
            },
            child: const Text('getAttachmentMetadata'),
          ),
        ],
      ),
    );
  }
}
