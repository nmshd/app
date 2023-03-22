import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  GetIt.I.registerSingletonAsync<EnmeshedRuntime>(() async => EnmeshedRuntime().run());

  runApp(const EnmeshedApp());
}

class EnmeshedApp extends StatelessWidget {
  const EnmeshedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: GetIt.I.allReady(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            return const Scaffold(
              body: Center(
                child: Text('The first real Page of your App'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AccountSelectionScreen extends StatelessWidget {
  const AccountSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
      future: GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts(),
    );
  }
}

class AccountScreen extends StatelessWidget {
  final String accountId;

  const AccountScreen(this.accountId, {super.key});

  @override
  Widget build(BuildContext context) {
    final services = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

    return const Placeholder();
  }
}
