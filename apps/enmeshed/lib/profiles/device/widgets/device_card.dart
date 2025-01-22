import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'device_widgets.dart';

class DeviceCard extends StatelessWidget {
  final String accountId;
  final DeviceDTO device;
  final Future<void> Function() reloadDevices;

  const DeviceCard({required this.accountId, required this.device, required this.reloadDevices, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.push('/account/$accountId/devices/${device.id}');
        await reloadDevices();
      },
      child: Card(
        elevation: 2,
        color: device.isCurrentDevice ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (device.description != null && device.description!.isNotEmpty)
                      Text(
                        device.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
                  ],
                ),
              ),
              SizedBox(width: 48, child: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}
