import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/core/core.dart';
import '../widgets/device_detail_header.dart';
import 'widgets/device_detail_widgets.dart';

class DeviceDetailScreen extends StatefulWidget {
  final String accountId;
  final String deviceId;

  const DeviceDetailScreen({required this.accountId, required this.deviceId, super.key});

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  DeviceDTO? _deviceDTO;
  List<DeviceDTO>? _devices;

  @override
  void initState() {
    super.initState();

    _loadDevice();
    _getDevices();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(context.l10n.deviceInfo_title));

    if (_deviceDTO == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.deviceInfo_title)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeviceDetailHeader(
              device: _deviceDTO!,
              accountId: widget.accountId,
              reloadDevice: _loadDevice,
              deleteDevice: _deleteDevice,
              editDevice: _editDevice,
            ),
            Gaps.h8,
            if (_devices != null && _devices!.length == 1)
              _RemoveRemainingDevice(device: _deviceDTO!)
            else if (!_deviceDTO!.isOnboarded)
              _ConnectDevice(device: _deviceDTO!)
            else if (!_deviceDTO!.isCurrentDevice)
              _RemoveOtherDevice(device: _deviceDTO!),
            _DeviceFirstConnected(device: _deviceDTO!),
          ],
        ),
      ),
    );
  }

  Future<void> _getDevices() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    await session.transportServices.account.syncDatawallet();

    final devicesResult = await session.transportServices.devices.getDevices();
    final devices = devicesResult.value.where((device) => device.isOffboarded == null || !device.isOffboarded!).toList();

    if (mounted) setState(() => _devices = devices);
  }

  Future<void> _loadDevice() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    await session.transportServices.account.syncDatawallet();

    final deviceResult = await session.transportServices.devices.getDevice(widget.deviceId);
    final device = deviceResult.value;

    if (mounted) setState(() => _deviceDTO = device);
  }

  Future<void> _deleteDevice() async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DeleteDeviceSheet(device: _deviceDTO!, accountId: widget.accountId),
    );

    if (mounted && confirmed != null && confirmed) {
      context.pop();
      showSuccessSnackbar(context: context, text: context.l10n.deviceInfo_removeDevice_successful(_deviceDTO!.name));
    }
  }

  Future<void> _editDevice() async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditDevice(
        accountId: widget.accountId,
        device: _deviceDTO!,
        onDevicesChanged: _loadDevice,
      ),
    );
  }
}

class _DeviceFirstConnected extends StatelessWidget {
  final DeviceDTO device;

  const _DeviceFirstConnected({required this.device});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.deviceInfo_history, style: Theme.of(context).textTheme.titleMedium),
          Gaps.h16,
          Text(
            context.l10n.deviceInfo_firstConnection,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          Text(
            device.isOnboarded
                ? DateFormat.yMd(Localizations.localeOf(context).languageCode).format(DateTime.parse(device.createdAt).toLocal())
                : context.l10n.deviceInfo_notConnected,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: device.isOnboarded ? textColor : textColor.withOpacity(0.25)),
          ),
        ],
      ),
    );
  }
}

class _ConnectDevice extends StatelessWidget {
  final DeviceDTO device;

  const _ConnectDevice({required this.device});

  @override
  Widget build(BuildContext context) {
    return _DeviceInstructions(
      title: context.l10n.deviceInfo_connectDevice_title,
      instructions: [
        context.l10n.deviceInfo_openApp(device.name),
        context.l10n.deviceInfo_connectDevice_startConnecting,
        context.l10n.deviceInfo_connectDevice_scan,
      ],
    );
  }
}

class _RemoveRemainingDevice extends StatelessWidget {
  final DeviceDTO device;

  const _RemoveRemainingDevice({required this.device});

  @override
  Widget build(BuildContext context) {
    return _DeviceInstructions(
      title: context.l10n.deviceInfo_removeRemainingDevice_title,
      icon: Icon(Icons.warning, color: context.customColors.warningIcon, semanticLabel: context.l10n.deviceInfo_warningSemanticsLabel),
      instructions: [
        context.l10n.deviceInfo_removeDevice_goBack,
        context.l10n.deviceInfo_removeDevice_chooseDelete,
        context.l10n.deviceInfo_removeDevice_deleteProfile,
        context.l10n.deviceInfo_removeDevice_allDataDeleted,
      ],
    );
  }
}

class _RemoveOtherDevice extends StatelessWidget {
  final DeviceDTO device;

  const _RemoveOtherDevice({required this.device});

  @override
  Widget build(BuildContext context) {
    return _DeviceInstructions(
      title: context.l10n.deviceInfo_removeConnectedDevice_title,
      instructions: [
        context.l10n.deviceInfo_openApp(device.name),
        context.l10n.deviceInfo_removeDevice_profileManagment,
        context.l10n.deviceInfo_removeDevice_chooseDelete,
        context.l10n.deviceInfo_removeDevice_deleteProfile,
      ],
    );
  }
}

class _DeviceInstructions extends StatelessWidget {
  final String title;
  final List<String> instructions;
  final Icon? icon;

  const _DeviceInstructions({required this.title, required this.instructions, this.icon});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              icon ??
                  Icon(
                    Icons.info,
                    size: 24,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    semanticLabel: context.l10n.deviceInfo_hintSemanticsLabel,
                  ),
              Gaps.w4,
              Expanded(child: Text(title, style: textStyle)),
            ],
          ),
          Gaps.h4,
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final itemNumber = index + 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$itemNumber. ', style: textStyle),
                  Expanded(child: Text(instructions.elementAt(index), style: textStyle)),
                ],
              );
            },
            itemCount: instructions.length,
          ),
        ],
      ),
    );
  }
}
