import 'dart:math';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'account_screen.dart';

class AccountSelectionScreen extends StatefulWidget {
  const AccountSelectionScreen({super.key});

  @override
  State<AccountSelectionScreen> createState() => _AccountSelectionScreenState();
}

class _AccountSelectionScreenState extends State<AccountSelectionScreen> {
  Future<List<LocalAccountDTO>>? _future;

  @override
  void initState() {
    reloadAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: generateRandomAccount, child: const Icon(Icons.add)),
      body: Center(
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<List<LocalAccountDTO>> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(item.name),
                  onTap: () async {
                    GetIt.I.get<EnmeshedRuntime>().selectAccount(item.id);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) => AccountScreen(item.id)),
                    );
                  },
                );
              },
              itemCount: snapshot.data!.length,
            );
          },
          future: _future,
        ),
      ),
    );
  }

  void generateRandomAccount() async {
    final r = Random();
    final randomAccountName = String.fromCharCodes(List.generate(10, (index) => r.nextInt(33) + 89));

    await GetIt.I.get<EnmeshedRuntime>().accountServices.createAccount(name: randomAccountName);
    setState(() => reloadAccounts());
  }

  void reloadAccounts() {
    _future = GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
  }
}
