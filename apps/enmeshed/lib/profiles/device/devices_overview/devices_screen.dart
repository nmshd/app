import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import '../widgets/device_widgets.dart';

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

    _reloadDevices(syncBefore: true);
    _loadAccount();
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(context.l10n.devices_title));

    if (_devices == null || _account == null) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentDevice = _devices!.firstWhere((e) => e.isCurrentDevice);
    final otherDevices = _devices!.where((e) => !e.isCurrentDevice).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      floatingActionButton: otherDevices.isEmpty
          ? null
          : FloatingActionButton(onPressed: _transferProfileToDevice, child: const Icon(Icons.send_to_mobile_outlined)),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(context.l10n.devices_otherDevices, style: Theme.of(context).textTheme.titleMedium),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _reloadDevices,
                  child: otherDevices.isEmpty
                      ? EmptyListIndicator(
                          icon: Icons.send_to_mobile_outlined,
                          text: context.l10n.devices_empty,
                          wrapInListView: true,
                          description: context.l10n.devices_empty_description,
                          action: FilledButton(
                            onPressed: _transferProfileToDevice,
                            child: Text(context.l10n.devices_transferProfile),
                          ),
                        )
                      : ListView.separated(
                          itemCount: otherDevices.length,
                          separatorBuilder: (_, _) => Gaps.h16,
                          itemBuilder: (context, index) =>
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

  Future<void> _transferProfileToDevice() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ScannerView(
          onSubmit: _onSubmitTransferProfile,
          lineUpQrCodeText: context.l10n.scanner_lineUpQrCode,
          scanQrOrEnterUrlText: context.l10n.scanner_scanQrOrEnterUrl,
          enterUrlText: context.l10n.scanner_enterUrl,
          urlTitle: context.l10n.transferProfile_scan_url_title,
          urlDescription: context.l10n.transferProfile_scan_url_description,
          urlLabelText: context.l10n.scanner_enterUrl,
          urlValidationErrorText: context.l10n.scanner_urlValidationError,
          urlButtonText: context.l10n.transferProfile_scan_url_button,
        ),
      ),
    );
  }

  Future<void> _onSubmitTransferProfile({
    required String content,
    required VoidCallback pause,
    required VoidCallback resume,
    required BuildContext context,
  }) async {
    pause();
    unawaited(showLoadingDialog(context, context.l10n.transferProfile_scan_transferInProgress));

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final result = await session.transportServices.devices.fillDeviceOnboardingTokenWithNewDevice(
      reference: content,
      profileName: _account!.name,
      isAdmin: true,
    );
    if (!context.mounted) return;

    context.pop();

    if (result.isSuccess) {
      context.pop();
      return;
    }

    GetIt.I.get<Logger>().e('Error while processing url $content: ${result.error.message}');
    await context.push('/error-dialog', extra: 'error.transferProfile.invalidQRCode');
    resume();
  }

  Future<void> _reloadDevices({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncDatawallet();

    final devicesResult = await session.transportServices.devices.getDevices();
    final devices = devicesResult.value.where((device) => device.isOnboarded && device.isOffboarded != true).toList();

    if (mounted) setState(() => _devices = devices);
  }
}
