import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class MessageDetailScreen extends StatefulWidget {
  final String accountId;
  final MessageDVO messageDVO;

  const MessageDetailScreen({super.key, required this.accountId, required this.messageDVO});

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message Detail Screen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: switch (widget.messageDVO) {
          final MailDVO mail => Text(mail.subject),
          final RequestMessageDVO requestMessage => Column(
              children: [
                RequestRenderer(request: requestMessage.request),
                if (requestMessage.request.isDecidable)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('cancel'),
                      ),
                      FilledButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(minimumSize: const Size(100.0, 36.0)),
                        child: const Text('save'),
                      ),
                    ],
                  ),
              ],
            ),
          _ => Text(widget.messageDVO.type)
        },
      ),
    );
  }
}
