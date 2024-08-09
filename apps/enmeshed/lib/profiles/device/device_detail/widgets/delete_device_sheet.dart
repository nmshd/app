import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

class DeleteDeviceSheet extends StatefulWidget {
  final DeviceDTO device;
  final String accountId;

  const DeleteDeviceSheet({required this.device, required this.accountId, super.key});

  @override
  State<DeleteDeviceSheet> createState() => _DeleteDeviceSheetState();
}

class _DeleteDeviceSheetState extends State<DeleteDeviceSheet> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8, left: 24, right: 8, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.deviceInfo_removeDevice, style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                    onPressed: _isLoading ? null : () => context.pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Gaps.h16,
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    const VectorGraphic(loader: AssetBytesLoader('assets/svg/remove_device.svg'), height: 161),
                    Gaps.h40,
                    _DeleteDevice(
                      device: widget.device,
                      accountId: widget.accountId,
                      isLoading: _isLoading,
                      onDelete: () async {
                        setState(() => _isLoading = true);

                        final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
                        await session.transportServices.devices.deleteDevice(widget.device.id);

                        if (context.mounted) context.pop(true);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_isLoading) ModalLoadingOverlay(text: context.l10n.deviceInfo_delete_inProgress, isDialog: false),
      ],
    );
  }
}

class _DeleteDevice extends StatelessWidget {
  final DeviceDTO device;
  final String accountId;
  final bool isLoading;
  final VoidCallback onDelete;

  const _DeleteDevice({required this.device, required this.accountId, required this.isLoading, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(context.l10n.devices_delete_fromApp(device.name)),
        Gaps.h48,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(onPressed: isLoading ? null : () => context.pop(), child: Text(context.l10n.devices_delete_cancel)),
            Gaps.w8,
            FilledButton(onPressed: onDelete, child: Text(context.l10n.devices_delete)),
          ],
        ),
      ],
    );
  }
}
