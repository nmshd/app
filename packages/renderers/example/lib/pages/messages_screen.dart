import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'message_detail_screen.dart';

class MessagesScreen extends StatefulWidget {
  final String accountId;

  const MessagesScreen({super.key, required this.accountId});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<MessageDVO>? _incomingMessages;

  @override
  void initState() {
    super.initState();

    _reloadMessages(syncBefore: true);
  }

  _reloadMessages({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final messageResult = await session.transportServices.messages.getMessages();
    final messages = await session.expander.expandMessageDTOs(messageResult.value);
    messages.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));

    if (mounted) {
      setState(() {
        _incomingMessages = messages.where((element) => !element.isOwn).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_incomingMessages == null) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(title: const Text('Messages Screen')),
      body: RefreshIndicator(
        onRefresh: () => _reloadMessages(syncBefore: true),
        child: (_incomingMessages!.isEmpty)
            ? ListView(children: const [Text('No messages')])
            : ListView.separated(
                itemCount: _incomingMessages!.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 241, 243, 241),
                        alignment: Alignment.centerLeft,
                        height: 40,
                        padding: const EdgeInsets.only(left: 16),
                        child: switch (_incomingMessages![index]) {
                          final MailDVO mail => TextButton(
                              child: Text(mail.subject),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MessageDetailScreen(
                                    accountId: widget.accountId,
                                    messageDVO: _incomingMessages![index],
                                  ),
                                ),
                              ),
                            ),
                          final RequestMessageDVO requestMessage => TextButton(
                              child: Text('Message Nr. ${index + 1} : ${requestMessage.createdAt}'),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MessageDetailScreen(
                                    accountId: widget.accountId,
                                    messageDVO: _incomingMessages![index],
                                  ),
                                ),
                              ),
                            ),
                          _ => Text(_incomingMessages![index].type)
                        },
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
