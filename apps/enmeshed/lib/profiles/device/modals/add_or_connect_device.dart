import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'create_device.dart';
import 'device_onboarding.dart';
import 'device_onboarding_safety_note.dart';

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
      isScrollControlled: true,
      builder: (context) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
        child: _AddOrConnectDeviceModal(accountId: accountId, reload: reload, existingDeviceAndToken: existingDeviceAndToken),
      ),
    );
  }

  @override
  State<_AddOrConnectDeviceModal> createState() => _AddOrConnectDeviceModalState();
}

class _AddOrConnectDeviceModalState extends State<_AddOrConnectDeviceModal> {
  (DeviceDTO, TokenDTO)? _deviceAndToken;
  bool _safetyShown = false;

  @override
  void initState() {
    super.initState();

    _deviceAndToken = widget.existingDeviceAndToken;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Stack(alignment: Alignment.center, children: [...previousChildren, ?currentChild]),
        );
      },
      duration: const Duration(milliseconds: 300),
      reverseDuration: Duration.zero,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut))),
          child: child,
        );
      },
      child: switch ((_deviceAndToken, _safetyShown)) {
        (null, _) => CreateDevice(
          accountId: widget.accountId,
          setDeviceAndToken: (device, token) async {
            await widget.reload();
            setState(() => _deviceAndToken = (device, token));
          },
        ),
        (_, false) => DeviceOnboardingSafetyNote(goToNextPage: () => setState(() => _safetyShown = true)),
        ((final DeviceDTO device, final TokenDTO token), true) => DeviceOnboarding(
          token: token,
          deviceId: device.id,
          accountReference: widget.accountId,
          onDeviceOnboarded: () async {
            await widget.reload();

            if (!context.mounted) return;

            showSuccessSnackbar(context: context, text: context.l10n.devices_otherDeviceOnboardedSuccess);
            context.pop();
          },
        ),
      },
    );
  }
}
