import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:identity_recovery_kit/identity_recovery_kit.dart';

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

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder:
        (context) => ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
          child: _CreateRecoveryKitModal(account: account, session: session, pdfTexts: pdfTexts),
        ),
  );
}

class _CreateRecoveryKitModal extends StatefulWidget {
  final Session session;
  final LocalAccountDTO account;
  final PdfTexts pdfTexts;

  const _CreateRecoveryKitModal({required this.session, required this.account, required this.pdfTexts});

  @override
  State<_CreateRecoveryKitModal> createState() => _CreateRecoveryKitModalState();
}

class _CreateRecoveryKitModalState extends State<_CreateRecoveryKitModal> {
  Uint8List? _recoveryKit;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Stack(alignment: Alignment.center, children: [...previousChildren, if (currentChild != null) currentChild]),
        );
      },
      duration: const Duration(milliseconds: 300),
      reverseDuration: _recoveryKit == null ? Duration.zero : null,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: child is EnterPassword ? const Offset(-1, 0) : const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        );
      },
      child:
          _recoveryKit == null
              ? EnterPassword(
                onPasswordEntered: (String enteredPassword) async {
                  final recoveryKit = await _generatePDF(
                    session: widget.session,
                    pdfTexts: widget.pdfTexts,
                    account: widget.account,
                    password: enteredPassword,
                  );

                  await upsertRestoreFromIdentityRecoveryKitSetting(accountId: widget.account.id, value: false);

                  setState(() => _recoveryKit = recoveryKit);
                },
              )
              : SaveOrPrintRecoveryKit(recoveryKit: _recoveryKit!, onBackPressed: () => setState(() => _recoveryKit = null)),
    );
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
    ).generate(logoBytes: logoBytes, spacerSvgImage: spacerSvgImage, backupURL: token.value.reference.url);

    return generatedPdf;
  }
}
