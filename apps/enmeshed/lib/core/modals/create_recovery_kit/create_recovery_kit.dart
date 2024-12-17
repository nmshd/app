import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/utils/extensions.dart';
import 'create_password.dart';
import 'save_or_print_recovery_kit.dart';

Future<void> showCreateRecoveryKitModal({required BuildContext context, required String accountId}) async {
  final pageIndexNotifier = ValueNotifier<int>(0);
  final passwordNotifier = ValueNotifier<String?>(null);

  await WoltModalSheet.show<void>(
    useSafeArea: false,
    context: context,
    pageIndexNotifier: pageIndexNotifier,
    onModalDismissedWithDrag: () => context.pop(),
    onModalDismissedWithBarrierTap: () => context.pop(),
    showDragHandle: false,
    pageListBuilder: (context) => [
      WoltModalSheetPage(
        trailingNavBarWidget: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        ),
        leadingNavBarWidget: Padding(
          padding: const EdgeInsets.only(left: 24, top: 20),
          child: Text(context.l10n.identityRecovery_passwordTitle, style: Theme.of(context).textTheme.titleLarge),
        ),
        child: EnterPassword(
          onContinue: (String enteredPassword) {
            passwordNotifier.value = enteredPassword;
            pageIndexNotifier.value++;
          },
        ),
      ),
      WoltModalSheetPage(
        hasTopBarLayer: false,
        child: ValueListenableBuilder<String?>(
          valueListenable: passwordNotifier,
          builder: (context, password, _) {
            return SaveOrPrintRecoveryKit(
              accountId: accountId,
              password: password,
              onBackPressed: () => pageIndexNotifier.value = 0,
            );
          },
        ),
      ),
    ],
  );
}
