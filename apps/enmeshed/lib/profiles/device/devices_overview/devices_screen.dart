import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../modals/add_or_connect_device.dart';
import '../widgets/device_widgets.dart';

class DevicesScreen extends StatefulWidget {
  final String accountId;

  const DevicesScreen({required this.accountId, super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final List<StreamSubscription<void>> _subscriptions = [];

  List<DeviceDTO>? _devices;
  LocalAccountDTO? _account;

  @override
  void initState() {
    super.initState();

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    _subscriptions
      ..add(runtime.eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reloadDevices()))
      ..add(
        runtime.eventBus.on<LocalAccountDeletionDateChangedEvent>().listen((event) {
          if (!mounted || widget.accountId != event.data.id || event.data.deletionDate == null) return;
          context.go('/account/${widget.accountId}/identity-in-deletion');
        }),
      );

    _reloadDevices(syncBefore: true);
    _loadAccount();
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(context.l10n.devices_title));

    if (_devices == null || _account == null) return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));

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
              BoldStyledText(context.l10n.devices_description(_account!.name)),
              Gaps.h24,
              DeviceCard(accountId: widget.accountId, device: currentDevice, reloadDevices: _reloadDevices),
              Gaps.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.devices_otherDevices, style: Theme.of(context).textTheme.titleMedium),
                  TextButton.icon(
                    onPressed: () => addDevice(context: context, accountId: widget.accountId, reload: _reloadDevices),
                    icon: const Icon(Icons.add),
                    label: Text(context.l10n.devices_create),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _reloadDevices,
                  child:
                      otherDevices.isEmpty
                          ? EmptyListIndicator(
                            icon: Icons.send_to_mobile_outlined,
                            text: context.l10n.devices_empty,
                            wrapInListView: true,
                            description: context.l10n.devices_empty_description,
                          )
                          : ListView.separated(
                            itemCount: otherDevices.length,
                            separatorBuilder: (_, __) => Gaps.h16,
                            itemBuilder:
                                (context, index) =>
                                    DeviceCard(accountId: widget.accountId, device: otherDevices[index], reloadDevices: _reloadDevices),
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

  Future<void> _reloadDevices({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncDatawallet();

    final devicesResult = await session.transportServices.devices.getDevices();
    final devices = devicesResult.value.where((device) => device.isOffboarded != true && !device.isBackupDevice).toList();

    if (mounted) setState(() => _devices = devices);
  }
}
