import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';

class AccountFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const AccountFacadeView({super.key, required this.runtime});

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
              final identityInfo = await runtime.currentSession.transportServices.account.getIdentityInfo();
              print(identityInfo);
            },
            child: const Text('getIdentityInfo'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final deviceInfo = await runtime.currentSession.transportServices.account.getDeviceInfo();
              print(deviceInfo);
            },
            child: const Text('getDeviceInfo'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await runtime.currentSession.transportServices.account.syncDatawallet();
            },
            child: const Text('syncDatawallet'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final syncEverythingResponse = await runtime.currentSession.transportServices.account.syncEverything();
              print(syncEverythingResponse);
            },
            child: const Text('syncEverything'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final syncInfo = await runtime.currentSession.transportServices.account.getSyncInfo();
              print(syncInfo);
            },
            child: const Text('getSyncInfo'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await runtime.currentSession.transportServices.account.enableAutoSync();
            },
            child: const Text('enableAutoSync'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await runtime.currentSession.transportServices.account.disableAutoSync();
            },
            child: const Text('disableAutoSync'),
          ),
        ],
      ),
    );
  }
}
