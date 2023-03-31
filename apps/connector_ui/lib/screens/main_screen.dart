import 'package:connector_sdk/connector_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        actions: [
          IconButton(onPressed: _showInfoDialog, icon: const Icon(Icons.info)),
          const SizedBox(width: 10),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
          const SizedBox(width: 10),
        ],
      ),
      body: const Center(
        child: Text('Main Screen'),
      ),
    );
  }

  Future<void> _showInfoDialog() async {
    final client = GetIt.I.get<ConnectorClient>();
    final identityInfoResponse = await client.account.getIdentityInfo();
    final identityInfo = identityInfoResponse.data;

    if (context.mounted) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Connector Info'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'Connector BaseURL: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(client.baseUrl),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => Clipboard.setData(ClipboardData(text: client.baseUrl)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Connector Address: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(identityInfo.address),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => Clipboard.setData(ClipboardData(text: identityInfo.address)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Connector Public Key: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(identityInfo.publicKey),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => Clipboard.setData(ClipboardData(text: identityInfo.publicKey)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  void _logout() {
    GetIt.I.unregister<ConnectorClient>();
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
