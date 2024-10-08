import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/core.dart';
import 'delete_profile_and_choose_next.dart';
import 'delete_profile_or_identity.dart';
import 'should_delete_identity.dart';
import 'should_delete_profile.dart';

Future<void> showDeleteProfileOrIdentityModal({
  required LocalAccountDTO localAccount,
  required BuildContext context,
}) async {
  final pageIndexNotifier = ValueNotifier<int>(0);
  final deleteFuture = ValueNotifier<Future<void>?>(null);
  Future<void> Function()? retryFunction;

  final session = GetIt.I.get<EnmeshedRuntime>().getSession(localAccount.address!);

  final devicesResult = await session.transportServices.devices.getDevices();
  final devices = devicesResult.isSuccess ? devicesResult.value : <DeviceDTO>[];

  if (!context.mounted) return;

  await WoltModalSheet.show<void>(
    useSafeArea: false,
    context: context,
    pageIndexNotifier: pageIndexNotifier,
    onModalDismissedWithBarrierTap: () => pageIndexNotifier.value != 3 ? context.pop() : null,
    showDragHandle: false,
    pageListBuilder: (context) {
      final closeButton = Padding(padding: const EdgeInsets.only(right: 8), child: IconButton(icon: const Icon(Icons.close), onPressed: context.pop));
      return [
        WoltModalSheetPage(
          leadingNavBarWidget: Padding(
            padding: const EdgeInsets.only(left: 24, top: 20),
            child: Text(context.l10n.profile_delete, style: Theme.of(context).textTheme.titleLarge),
          ),
          trailingNavBarWidget: closeButton,
          isTopBarLayerAlwaysVisible: true,
          child: DeleteProfileOrIdentity(
            cancel: () => context.pop,
            profileName: localAccount.name,
            accountId: localAccount.address!,
            devices: devices,
            deleteProfile: () => pageIndexNotifier.value = 1,
            deleteIdentity: () => pageIndexNotifier.value = 2,
          ),
        ),
        WoltModalSheetPage(
          isTopBarLayerAlwaysVisible: true,
          leadingNavBarWidget: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(icon: const Icon(Icons.arrow_back, size: 24), onPressed: () => pageIndexNotifier.value = 0),
          ),
          trailingNavBarWidget: closeButton,
          topBarTitle: Text(context.l10n.profile_delete_device, style: Theme.of(context).textTheme.titleMedium),
          child: ShouldDeleteProfile(
            cancel: () => pageIndexNotifier.value = 0,
            delete: () {
              deleteFuture.value = GetIt.I.get<EnmeshedRuntime>().accountServices.deleteAccount(localAccount.id);
              retryFunction = () => GetIt.I.get<EnmeshedRuntime>().accountServices.deleteAccount(localAccount.id);
              pageIndexNotifier.value = 3;
            },
            profileName: localAccount.name,
            devices: devices,
          ),
        ),
        WoltModalSheetPage(
          isTopBarLayerAlwaysVisible: true,
          leadingNavBarWidget: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(icon: const Icon(Icons.arrow_back, size: 24), onPressed: () => pageIndexNotifier.value = 0),
          ),
          trailingNavBarWidget: closeButton,
          topBarTitle: Text(context.l10n.profile_delete, style: Theme.of(context).textTheme.titleMedium),
          child: ShouldDeleteIdentity(
            cancel: () => pageIndexNotifier.value = 0,
            delete: () {
              deleteFuture.value = session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
              retryFunction = () => session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
              pageIndexNotifier.value = 3;
            },
            profileName: localAccount.name,
            devices: devices,
          ),
        ),
        NonScrollingWoltModalSheetPage(
          enableDrag: false,
          child: DeleteProfileAndChooseNext(
            localAccount: localAccount,
            deleteFuture: deleteFuture,
            retryFunction: retryFunction,
            inProgressText: context.l10n.profile_delete_inProgress,
            successDescription: context.l10n.profile_delete_success,
          ),
        ),
      ];
    },
  );

  pageIndexNotifier.dispose();
  deleteFuture.dispose();
}
