import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/core.dart';
import 'delete_profile_and_choose_next.dart';
import 'edit_profile.dart';
import 'saving_profile.dart';
import 'should_delete_profile.dart';

Future<void> showEditProfileModal({
  required void Function() onEditAccount,
  required LocalAccountDTO localAccount,
  required File? initialProfilePicture,
  required BuildContext context,
}) async {
  final pageIndexNotifier = ValueNotifier<int>(0);
  final deleteFuture = ValueNotifier<Future<void>?>(null);

  final closeButton = Padding(padding: const EdgeInsets.only(right: 8), child: IconButton(icon: const Icon(Icons.close), onPressed: context.pop));

  final devicesResult = await GetIt.I.get<EnmeshedRuntime>().getSession(localAccount.address!).transportServices.devices.getDevices();
  final devices = devicesResult.isSuccess ? devicesResult.value : <DeviceDTO>[];

  if (!context.mounted) return;

  await WoltModalSheet.show<void>(
    useSafeArea: false,
    context: context,
    pageIndexNotifier: pageIndexNotifier,
    onModalDismissedWithBarrierTap: () => [1, 3].contains(pageIndexNotifier.value) ? null : context.pop(),
    showDragHandle: false,
    pageListBuilder: (context) => [
      WoltModalSheetPage(
        leadingNavBarWidget: Padding(
          padding: const EdgeInsets.only(left: 24, top: 20),
          child: Text(context.l10n.profile_edit, style: Theme.of(context).textTheme.titleLarge),
        ),
        trailingNavBarWidget: closeButton,
        child: EditProfile(
          setLoading: () => pageIndexNotifier.value = 1,
          onAccountEditDone: () {
            onEditAccount();
            context.pop();
          },
          onDeletePressed: () => pageIndexNotifier.value = 2,
          localAccount: localAccount,
          initialProfilePicture: initialProfilePicture,
        ),
      ),
      WoltModalSheetPage(enableDrag: false, hasTopBarLayer: false, child: const SavingProfile()),
      WoltModalSheetPage(
        leadingNavBarWidget: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(icon: const Icon(Icons.arrow_back, size: 24), onPressed: () => pageIndexNotifier.value = 0),
        ),
        trailingNavBarWidget: closeButton,
        topBarTitle: Text(context.l10n.profile_delete, style: Theme.of(context).textTheme.titleMedium),
        isTopBarLayerAlwaysVisible: true,
        child: ShouldDeleteProfile(
          cancel: () => pageIndexNotifier.value = 0,
          delete: () {
            deleteFuture.value = GetIt.I.get<EnmeshedRuntime>().accountServices.deleteAccount(localAccount.id);
            pageIndexNotifier.value = 3;
          },
          profileName: localAccount.name,
          devices: devices,
        ),
      ),
      NonScrollingWoltModalSheetPage(
        enableDrag: false,
        topBarTitle: Text(context.l10n.profile_delete, style: Theme.of(context).textTheme.titleMedium),
        hasTopBarLayer: true,
        child: DeleteProfileAndChooseNext(localAccount: localAccount, deleteFuture: deleteFuture),
      ),
    ],
  );

  pageIndexNotifier.dispose();
  deleteFuture.dispose();
}
