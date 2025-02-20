import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> addDevice({required BuildContext context, required String accountId, required Future<void> Function() reload}) async {
  await _AddOrConnectDeviceModal.show(context: context, accountId: accountId, reload: reload, existingDeviceAndToken: null);
}

Future<void> connectDevice({
  required BuildContext context,
  required String accountId,
  required Future<void> Function() reload,
  required DeviceDTO device,
}) async {
  final runtime = GetIt.I.get<EnmeshedRuntime>();
  final session = runtime.getSession(accountId);

  final account = await runtime.accountServices.getAccount(accountId);

  final token = await session.transportServices.devices.createDeviceOnboardingToken(device.id, profileName: account.name);

  if (!context.mounted) return;

  await _AddOrConnectDeviceModal.show(context: context, accountId: accountId, reload: reload, existingDeviceAndToken: (device, token.value));
}

class _AddOrConnectDeviceModal extends StatefulWidget {
  final String accountId;
  final Future<void> Function() reload;
  final (DeviceDTO, TokenDTO)? existingDeviceAndToken;

  const _AddOrConnectDeviceModal({required this.accountId, required this.reload, required this.existingDeviceAndToken});

  static Future<void> show({
    required BuildContext context,
    required String accountId,
    required Future<void> Function() reload,
    required (DeviceDTO, TokenDTO)? existingDeviceAndToken,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      builder:
          (context) => ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
            child: _AddOrConnectDeviceModal(accountId: accountId, reload: reload, existingDeviceAndToken: existingDeviceAndToken),
          ),
    );
  }

  @override
  State<_AddOrConnectDeviceModal> createState() => _AddOrConnectDeviceModalState();
}

class _AddOrConnectDeviceModalState extends State<_AddOrConnectDeviceModal> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
