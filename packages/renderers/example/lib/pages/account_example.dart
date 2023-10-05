import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'home_screen.dart';
import 'messages_screen.dart';

class AccountExample extends StatefulWidget {
  final ReloadController reloadController;
  final String accountId;
  const AccountExample({super.key, required this.reloadController, required this.accountId});

  @override
  State<AccountExample> createState() => _AccountExampleState();
}

class _AccountExampleState extends State<AccountExample> {
  List<IdentityDVO>? _relationships;

  @override
  void initState() {
    widget.reloadController.onReload = _reload;
    _reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_relationships == null) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: () async => await _reload(syncBefore: true),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: (_relationships == null)
            ? ListView(
                children: const [Text('No contacts')],
              )
            : ListView.separated(
                itemCount: _relationships!.length,
                itemBuilder: (context, index) {
                  return TextButton(
                      child: Text(_relationships![index].name.toUpperCase()),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MessagesScreen(accountId: widget.accountId))));
                },
                separatorBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> _reload({bool syncBefore = false, bool isFirstTime = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) {
      await session.transportServices.account.syncEverything();
    }

    final relationships = await getContacts(session: session);

    if (mounted) {
      setState(() {
        _relationships = relationships;
      });
    }
  }

  Future<List<IdentityDVO>> getContacts({required Session session}) async {
    final relationshipsResult = await session.transportServices.relationships.getRelationships();
    final dvos = await session.expander.expandRelationshipDTOs(relationshipsResult.value);
    dvos.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return dvos;
  }
}
