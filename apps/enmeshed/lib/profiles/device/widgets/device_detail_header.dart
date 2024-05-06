import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import 'device_widgets.dart';

class DeviceDetailHeader extends StatelessWidget {
  final DeviceDTO device;
  final String accountId;
  final Future<void> Function() reloadDevice;
  final VoidCallback deleteDevice;
  final VoidCallback editDevice;

  const DeviceDetailHeader({
    required this.device,
    required this.accountId,
    required this.reloadDevice,
    required this.deleteDevice,
    required this.editDevice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(device.name, style: Theme.of(context).textTheme.titleLarge),
            if (device.description != null && device.description!.isNotEmpty)
              Text(device.description!, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            if (!device.isOnboarded) ...[
              Gaps.h4,
              DeviceStatusBar(isWarning: true, statusText: context.l10n.deviceInfo_deviceNotConnected),
            ] else if (device.isOffboarded ?? false) ...[
              Gaps.h4,
              DeviceStatusBar(isWarning: true, statusText: context.l10n.deviceInfo_offboarded),
            ] else if (device.isCurrentDevice) ...[
              Gaps.h4,
              DeviceStatusBar(statusText: context.l10n.deviceInfo_thisDevice),
            ],
            if (!(device.isOffboarded ?? false)) ...[
              Gaps.h16,
              _DeviceButtonBar(isOnboarded: device.isOnboarded, editDevice: editDevice, deleteDevice: deleteDevice),
            ],
            if (!device.isOnboarded) ...[
              Gaps.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.deviceInfo_connectDeviceViaQr),
                  OutlinedButton(
                    onPressed: () => connectDevice(context: context, accountId: accountId, reload: reloadDevice, device: device),
                    style: OutlinedButton.styleFrom(shape: const CircleBorder()),
                    child: Icon(Icons.qr_code, color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DeviceButtonBar extends StatelessWidget {
  final bool isOnboarded;
  final VoidCallback editDevice;
  final VoidCallback deleteDevice;

  const _DeviceButtonBar({required this.isOnboarded, required this.editDevice, required this.deleteDevice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.edit),
            label: Text(context.l10n.edit),
            onPressed: editDevice,
          ),
        ),
        Gaps.w8,
        if (!isOnboarded)
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text(context.l10n.deviceInfo_removeDevice, textAlign: TextAlign.center),
              onPressed: deleteDevice,
            ),
          )
        else
          const Expanded(child: SizedBox()),
      ],
    );
  }
}
