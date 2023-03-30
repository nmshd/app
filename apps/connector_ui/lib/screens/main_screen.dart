import 'package:connector_sdk/connector_sdk.dart';
import 'package:flutter/material.dart';
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
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: const Center(
        child: Text('Main Screen'),
      ),
    );
  }

  void _logout() {
    GetIt.I.unregister<ConnectorClient>();
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
