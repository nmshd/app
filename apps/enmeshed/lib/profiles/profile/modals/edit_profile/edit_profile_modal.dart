import 'dart:io';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/core.dart';
import 'edit_profile.dart';
import 'saving_profile.dart';

Future<void> showEditProfileModal({
  required void Function() onEditAccount,
  required LocalAccountDTO localAccount,
  required File? initialProfilePicture,
  required BuildContext context,
}) async {
  final pageIndexNotifier = ValueNotifier<int>(0);
  final deleteFuture = ValueNotifier<Future<void>?>(null);

  final closeButton = Padding(padding: const EdgeInsets.only(right: 8), child: IconButton(icon: const Icon(Icons.close), onPressed: context.pop));

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
          localAccount: localAccount,
          initialProfilePicture: initialProfilePicture,
        ),
      ),
      WoltModalSheetPage(enableDrag: false, hasTopBarLayer: false, child: const SavingProfile()),
    ],
  );

  pageIndexNotifier.dispose();
  deleteFuture.dispose();
}
