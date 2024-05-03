import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../widgets/device_widgets.dart';
import '/core/core.dart';

class DevicesScreen extends StatefulWidget {
  final String accountId;

  const DevicesScreen({required this.accountId, super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  late final StreamSubscription<void> _subscription;

  List<DeviceDTO>? _devices;
  LocalAccountDTO? _account;

  @override
  void initState() {
    super.initState();

    _subscription = GetIt.I.get<EnmeshedRuntime>().eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reloadDevices());

    _reloadDevices();
    _loadAccount();
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(context.l10n.devices_title),
      actions: [
        IconButton(
          onPressed: () => addDevice(context: context, accountId: widget.accountId, reload: _reloadDevices),
          icon: const Icon(EnmeshedIcons.deviceAdd),
        ),
      ],
    );

    if (_devices == null || _account == null) {
      return Scaffold(
        appBar: appBar,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentDevice = _devices!.firstWhere((e) => e.isCurrentDevice);
    final otherDevices = _devices!.where((e) => !e.isCurrentDevice).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.h16,
              Text(context.l10n.devices_description(_account!.name)),
              Gaps.h24,
              DeviceCard(
                accountId: widget.accountId,
                device: currentDevice,
                reloadDevices: _reloadDevices,
              ),
              Gaps.h24,
              Text(context.l10n.devices_otherDevices, style: Theme.of(context).textTheme.titleLarge),
              Gaps.h8,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _reloadDevices,
                  child: ListView.separated(
                    itemCount: otherDevices.length,
                    separatorBuilder: (_, __) => Gaps.h16,
                    itemBuilder: (context, index) {
                      return DeviceCard(
                        accountId: widget.accountId,
                        device: otherDevices[index],
                        reloadDevices: _reloadDevices,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadAccount() async {
    final account = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccount(widget.accountId);
    setState(() => _account = account);
  }

  Future<void> _reloadDevices() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    await session.transportServices.account.syncDatawallet();

    final devicesResult = await session.transportServices.devices.getDevices();
    final devices = devicesResult.value;

    if (mounted) setState(() => _devices = devices);
  }
}
