import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'requests_detail_screen.dart';

class RequestsScreen extends StatefulWidget {
  final String accountId;

  const RequestsScreen({super.key, required this.accountId});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<LocalRequestDVO>? _localRequests;

  @override
  void initState() {
    super.initState();

    _reloadRequests(syncBefore: true);
  }

  _reloadRequests({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final incomingRequests = await session.consumptionServices.incomingRequests.getRequests();
    final outgoingRequests = await session.consumptionServices.outgoingRequests.getRequests();

    final expandedIncomingRequests = await session.expander.expandLocalRequestDTOs(incomingRequests.value);
    final expandedOutgoingRequests = await session.expander.expandLocalRequestDTOs(outgoingRequests.value);

    if (mounted) {
      setState(() {
        _localRequests = [...expandedIncomingRequests, ...expandedOutgoingRequests];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_localRequests == null) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _reloadRequests(syncBefore: true),
        child: (_localRequests!.isEmpty)
            ? ListView(children: const [Text('No messages')])
            : ListView.separated(
                itemCount: _localRequests!.length,
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
                        child: TextButton(
                          child: Text('Message Nr. ${index + 1} : ${_localRequests![index].createdAt}'),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RequestsDetailScreen(
                                accountId: widget.accountId,
                                localRequestDVO: _localRequests![index],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
