import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../widgets/device_detail_header.dart';
import '/core/core.dart';
import 'widgets/device_detail_widgets.dart';

class DeviceDetailScreen extends StatefulWidget {
  final String accountId;
  final String deviceId;

  const DeviceDetailScreen({
    required this.accountId,
    required this.deviceId,
    super.key,
  });

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  DeviceDTO? _deviceDTO;

  @override
  void initState() {
    super.initState();

    _loadDevice();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(context.l10n.deviceInfo_title));

    if (_deviceDTO == null) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

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
            Gaps.h24,
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.onPrimary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.deviceInfo_firstConnection, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    Text(
                      _deviceDTO!.isOnboarded
                          ? DateFormat.yMd(Localizations.localeOf(context).languageCode).format(DateTime.parse(_deviceDTO!.createdAt).toLocal())
                          : context.l10n.deviceInfo_notConnected,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadDevice() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    await session.transportServices.account.syncDatawallet();

    final deviceResult = await session.transportServices.devices.getDevice(widget.deviceId);
    final device = deviceResult.value;

    if (mounted) setState(() => _deviceDTO = device);
  }

  Future<void> _deleteDevice() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteDeviceDialog(
        device: _deviceDTO!,
        accountId: widget.accountId,
      ),
    );

    if (mounted && confirmed != null && confirmed) context.pop();
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
