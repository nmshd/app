import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/core.dart';
import '../device.dart';

void addDevice({
  required BuildContext context,
  required String accountId,
  required Future<void> Function() reload,
}) {
  _showModalSheet(context: context, accountId: accountId, reload: reload);
}

Future<void> connectDevice({
  required BuildContext context,
  required String accountId,
  required Future<void> Function() reload,
  required DeviceDTO device,
}) async {
  final runtime = GetIt.I.get<EnmeshedRuntime>();
  final session = runtime.getSession(accountId);

  final account = await runtime.accountServices.getAccount(accountId);

  final token = await session.transportServices.devices.createDeviceOnboardingToken(device.id, profileName: account.name);

  if (context.mounted) {
    _showModalSheet(context: context, accountId: accountId, reload: reload, pageIndex: 2, existingDeviceAndToken: (device, token.value));
  }
}

void _showModalSheet({
  required BuildContext context,
  required String accountId,
  required Future<void> Function() reload,
  int pageIndex = 0,
  (DeviceDTO, TokenDTO)? existingDeviceAndToken,
}) {
  final pageIndexNotifier = ValueNotifier<int>(pageIndex);
  final deviceAndTokenNotifier = ValueNotifier<(DeviceDTO, TokenDTO)?>(existingDeviceAndToken);

  final closeButton = Padding(
    padding: const EdgeInsets.only(right: 8),
    child: IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => context.pop(),
    ),
  );

  void goToNextPage() => pageIndexNotifier.value++;

  unawaited(
    WoltModalSheet.show(
      useSafeArea: false,
      showDragHandle: false,
      pageIndexNotifier: pageIndexNotifier,
      onModalDismissedWithBarrierTap: () => pageIndexNotifier.value != 1 ? context.pop() : null,
      context: context,
      pageListBuilder: (modalSheetContext) {
        return [
          WoltModalSheetPage(
            hasTopBarLayer: false,
            leadingNavBarWidget: Padding(
              padding: const EdgeInsets.only(left: 24, top: 20),
              child: Text(context.l10n.devices_create, style: Theme.of(context).textTheme.titleLarge),
            ),
            trailingNavBarWidget: closeButton,
            child: CreateDevice(
              accountId: accountId,
              setLoading: goToNextPage,
              setDeviceAndToken: (device, token) async {
                await reload();
                goToNextPage();

                deviceAndTokenNotifier.value = (device, token);
              },
            ),
          ),
          WoltModalSheetPage(
            enableDrag: false,
            hasTopBarLayer: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 68, left: 24, right: 24, bottom: 100),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(context.l10n.devices_create_inProgress, style: Theme.of(context).textTheme.headlineSmall),
                    Gaps.h24,
                    const SizedBox(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
          WoltModalSheetPage(
            hasTopBarLayer: true,
            isTopBarLayerAlwaysVisible: true,
            trailingNavBarWidget: closeButton,
            topBarTitle: Text(context.l10n.safetyInformation, style: Theme.of(context).textTheme.titleMedium),
            child: DeviceOnboardingSafetyNote(goToNextPage: goToNextPage),
          ),
          WoltModalSheetPage(
            hasTopBarLayer: true,
            isTopBarLayerAlwaysVisible: true,
            topBarTitle: Text(context.l10n.devices_add, style: Theme.of(context).textTheme.titleMedium),
            trailingNavBarWidget: closeButton,
            child: ValueListenableBuilder<(DeviceDTO, TokenDTO)?>(
              valueListenable: deviceAndTokenNotifier,
              builder: (context, deviceAndToken, child) {
                if (deviceAndToken == null) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 23, left: 24, right: 24, bottom: 100),
                    child: Column(
                      children: [
                        Icon(Icons.security, color: Theme.of(context).colorScheme.primary),
                        Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
                        Gaps.h16,
                        Text(context.l10n.error_createDevice, textAlign: TextAlign.center),
                      ],
                    ),
                  );
                }

                return DeviceOnboarding(
                  token: deviceAndToken.$2,
                  deviceId: deviceAndToken.$1.id,
                  accountReference: accountId,
                  onDeviceOnboarded: () async {
                    await reload();
                    pageIndexNotifier.value = 4;
                  },
                );
              },
            ),
          ),
          WoltModalSheetPage(
            hasTopBarLayer: true,
            isTopBarLayerAlwaysVisible: true,
            topBarTitle: Text(context.l10n.devices_connected, style: Theme.of(context).textTheme.titleMedium),
            trailingNavBarWidget: closeButton,
            child: const DeviceOnboardingSuccess(),
          ),
        ];
      },
    ),
  );
}
