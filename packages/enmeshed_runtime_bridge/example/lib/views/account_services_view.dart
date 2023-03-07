import 'dart:convert';
import 'dart:math';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class AccountServicesView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const AccountServicesView({super.key, required this.runtime});

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
              final account = await runtime.accountServices.createAccount(name: getRandomString(5));
              print(account);
            },
            child: const Text('createAccount'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final onboardingInfo = DeviceOnboardingInfoDTO(
                id: 'id',
                createdAt: 'createdAt',
                createdByDevice: 'createdByDevice',
                secretBaseKey: 'secretBaseKey',
                deviceIndex: 1,
                synchronizationKey: 'synchronizationKey',
                identity: IdentityDTO(address: '', publicKey: '', realm: 'id1'),
                password: 'password',
                username: 'username',
              );
              final account = await runtime.accountServices.onboardAccount(onboardingInfo);
              print(account);
            },
            child: const Text('onboardAccount'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final accounts = await runtime.accountServices.getAccounts();
              print(accounts);
            },
            child: const Text('getAccounts'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await runtime.accountServices.clearAccounts();
            },
            child: const Text('clearAccounts'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final accounts = await runtime.accountServices.getAccounts();
              if (accounts.isEmpty) return;

              await runtime.accountServices.renameAccount(localAccountId: accounts.first.id, newAccountName: getRandomString(5));
            },
            child: const Text('renameAccount'),
          ),
        ],
      ),
    );
  }

  String getRandomString(int len) {
    final random = Random.secure();
    final values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
