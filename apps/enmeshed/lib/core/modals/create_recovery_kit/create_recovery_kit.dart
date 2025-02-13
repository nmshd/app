import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:identity_recovery_kit/identity_recovery_kit.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../core.dart';
import 'enter_password.dart';
import 'save_or_print_recovery_kit.dart';

Future<void> showCreateRecoveryKitModal({required BuildContext context, required String accountId}) async {
  final runtime = GetIt.I.get<EnmeshedRuntime>();
  final session = runtime.getSession(accountId);
  final account = await runtime.accountServices.getAccount(accountId);

  if (!context.mounted) return;

  final pdfTexts = (
    headerTitle: context.l10n.identityRecovery_pdfHeaderTitle,
    keepSafeText: context.l10n.identityRecovery_pdfKeepSafeText,
    infoText1: context.l10n.identityRecovery_pdfInfoText1,
    infoText2: context.l10n.identityRecovery_pdfInfoText2,
    addressLabel: context.l10n.identityRecovery_pdfAddressLabel,
    address: account.address!,
    passwordLabel: context.l10n.identityRecovery_pdfPasswordLabel,
    qrDescription: context.l10n.identityRecovery_pdfQRDescription,
    needHelpTitle: context.l10n.identityRecovery_pdfNeedHelpTitle,
    needHelpText: context.l10n.identityRecovery_pdfNeedHelpText,
  );

  final pageIndexNotifier = ValueNotifier<int>(0);
  final recoveryKitNotifier = ValueNotifier<Uint8List?>(null);

  await WoltModalSheet.show<void>(
    useSafeArea: false,
    context: context,
    pageIndexNotifier: pageIndexNotifier,
    onModalDismissedWithDrag: () => context.pop(),
    onModalDismissedWithBarrierTap: () => context.pop(),
    showDragHandle: false,
    pageListBuilder:
        (context) => [
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
              onPasswordEntered: (String enteredPassword) async {
                pageIndexNotifier.value++;

                final recoveryKit = await _generatePDF(session: session, pdfTexts: pdfTexts, account: account, password: enteredPassword);

                recoveryKitNotifier.value = recoveryKit;
                pageIndexNotifier.value++;
              },
            ),
          ),
          WoltModalSheetPage(hasTopBarLayer: false, child: const _LoadingPage()),
          WoltModalSheetPage(
            hasTopBarLayer: false,
            child: ValueListenableBuilder<Uint8List?>(
              valueListenable: recoveryKitNotifier,
              builder:
                  (context, recoveryKit, _) =>
                      recoveryKit == null
                          ? const Placeholder()
                          : SaveOrPrintRecoveryKit(recoveryKit: recoveryKit, onBackPressed: () => pageIndexNotifier.value = 0),
            ),
          ),
        ],
  );
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 140),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.l10n.identityRecovery_generatingInProgress, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
            Gaps.h24,
            const SizedBox(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

Future<Uint8List> _generatePDF({
  required Session session,
  required PdfTexts pdfTexts,
  required LocalAccountDTO account,
  required String password,
}) async {
  final token = await session.transportServices.identityRecoveryKits.createIdentityRecoveryKit(
    profileName: account.name,
    passwordProtection: PasswordProtection(password: password),
  );

  final spacerSvgImage = await rootBundle.loadString('assets/svg_without_transforming/triangle.svg');
  final logoImageData = await rootBundle.load('assets/pictures/enmeshed_logo_light_cut.png');
  final logoBytes = logoImageData.buffer.asUint8List();

  final generatedPdf = await PdfGenerator(
    headerTitleHexColor: '#1A80D9',
    backgroundHexColor: '#D7E3F8',
    defaultTextHexColor: '#17428D',
    borderHexColor: '#17428D',
    labelHexColor: '#17428D',
    addressHexColor: '#1A80D9',
    pdfTexts: pdfTexts,
    qrSettings: (errorCorrectionLevel: QRErrorCorrectionLevel.L, qrPixelSize: null),
  ).generate(logoBytes: logoBytes, spacerSvgImage: spacerSvgImage, backupURL: 'nmshd://tr#${token.value.truncatedReference}');

  return generatedPdf;
}
