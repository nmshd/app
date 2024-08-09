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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(device.name, style: Theme.of(context).textTheme.titleLarge),
          if (device.description != null && device.description!.isNotEmpty) ...[
            Gaps.h8,
            Text(device.description!, style: Theme.of(context).textTheme.bodyMedium),
          ],
          if (!device.isOnboarded) ...[
            Gaps.h8,
            DeviceStatusBar(isWarning: true, statusText: context.l10n.deviceInfo_deviceNotConnected),
          ] else if (device.isOffboarded ?? false) ...[
            Gaps.h8,
            DeviceStatusBar(isWarning: true, statusText: context.l10n.deviceInfo_offboarded),
          ] else if (device.isCurrentDevice) ...[
            Gaps.h8,
            DeviceStatusBar(statusText: context.l10n.deviceInfo_thisDevice),
          ],
          if (!(device.isOffboarded ?? false)) ...[
            Gaps.h8,
            _DeviceButtonBar(
              editDevice: editDevice,
              deleteDevice: deleteDevice,
              reloadDevice: reloadDevice,
              device: device,
              accountId: accountId,
            ),
          ],
        ],
      ),
    );
  }
}

class _DeviceButtonBar extends StatelessWidget {
  final VoidCallback editDevice;
  final VoidCallback deleteDevice;
  final Future<void> Function() reloadDevice;
  final DeviceDTO device;
  final String accountId;

  const _DeviceButtonBar({
    required this.editDevice,
    required this.deleteDevice,
    required this.accountId,
    required this.reloadDevice,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    const buttonPadding = EdgeInsets.only(left: 16, right: 24, top: 14, bottom: 14);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: [
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(padding: buttonPadding),
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: Text(context.l10n.edit),
            onPressed: editDevice,
          ),
          // TODO(nicole-eb): will be enabled for current device when functionality is mapped to button
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(padding: buttonPadding),
            icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error, size: 18),
            label: Text(device.isCurrentDevice ? context.l10n.deviceInfo_removeCurrentDevice : context.l10n.deviceInfo_removeDevice),
            onPressed: device.isOnboarded ? null : deleteDevice,
          ),
          if (!device.isOnboarded)
            FilledButton.icon(
              icon: const Icon(Icons.qr_code, size: 18),
              onPressed: () => connectDevice(context: context, accountId: accountId, reload: reloadDevice, device: device),
              label: Text(context.l10n.deviceInfo_showQrCode),
            ),
        ],
      ),
    );
  }
}
