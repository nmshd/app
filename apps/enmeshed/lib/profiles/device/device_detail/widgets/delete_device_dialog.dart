import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class DeleteDeviceDialog extends StatefulWidget {
  final DeviceDTO device;
  final String accountId;

  const DeleteDeviceDialog({required this.device, required this.accountId, super.key});

  @override
  State<DeleteDeviceDialog> createState() => _DeleteDeviceDialogState();
}

class _DeleteDeviceDialogState extends State<DeleteDeviceDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error, color: Theme.of(context).colorScheme.error),
                Gaps.h16,
                Text(context.l10n.deviceInfo_removeDevice, style: Theme.of(context).textTheme.headlineSmall),
                Gaps.h16,
                Text(context.l10n.devices_delete_description(widget.device.name)),
                Gaps.h24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(onPressed: () => context.pop(false), child: Text(context.l10n.cancel)),
                    Gaps.w8,
                    FilledButton(
                      child: Text(context.l10n.delete),
                      onPressed: () async {
                        setState(() => _isLoading = true);

                        final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
                        await session.transportServices.devices.deleteDevice(widget.device.id);

                        if (context.mounted) context.pop(true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_isLoading) ModalLoadingOverlay(text: context.l10n.deviceInfo_delete_inProgress, isDialog: true),
        ],
      ),
    );
  }
}
