import 'dart:math';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:identity_recovery_kit/identity_recovery_kit.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '/core/utils/utils.dart';
import '../../constants.dart';
import '../../widgets/widgets.dart';

class SaveOrPrintRecoveryKit extends StatefulWidget {
  final String accountId;
  final String? password;
  final VoidCallback onBackPressed;

  const SaveOrPrintRecoveryKit({required this.accountId, required this.password, required this.onBackPressed, super.key});

  @override
  State<SaveOrPrintRecoveryKit> createState() => _SaveOrPrintRecoveryKitState();
}

class _SaveOrPrintRecoveryKitState extends State<SaveOrPrintRecoveryKit> {
  Uint8List? _pdf;

  @override
  void initState() {
    super.initState();

    _generatePDF();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(onPressed: widget.onBackPressed),
                  Text(context.l10n.identityRecovery_saveKit, style: Theme.of(context).textTheme.titleMedium),
                  IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: max(MediaQuery.paddingOf(context).bottom, 16) + 16),
              child: Column(
                children: [
                  Text(context.l10n.identityRecovery_saveKitDescription),
                  Gaps.h32,
                  _RecoveryCard(
                    title: context.l10n.identityRecovery_download,
                    description: context.l10n.identityRecovery_downloadDescription,
                    icon: Icons.file_download_outlined,
                    onTap: _downloadFile,
                  ),
                  Gaps.h24,
                  _RecoveryCard(
                    title: context.l10n.identityRecovery_print,
                    description: context.l10n.identityRecovery_printDescription,
                    icon: Icons.print_outlined,
                    onTap: _printFile,
                  ),
                  Gaps.h32,
                  Text(context.l10n.identityRecovery_information),
                ],
              ),
            ),
          ],
        ),
        if (widget.password == null || _pdf == null) ModalLoadingOverlay(text: context.l10n.identityRecovery_generatingInProgress, isDialog: false),
      ],
    );
  }

  Future<void> _downloadFile() async {
    final result = await FilePicker.platform.saveFile(
      fileName: 'identity_recovery_kit.pdf',
      allowedExtensions: ['pdf'],
      bytes: _pdf!,
    );

    if (result == null) return;

    if (mounted) {
      context
        ..pop()
        ..pop();

      showSuccessSnackbar(context: context, text: context.l10n.identityRecovery_saveKitSuccess);
    }
  }

  Future<void> _printFile() async {
    final success = await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => _pdf!.buffer.asUint8List(),
    );

    if (!success) return;

    if (mounted) {
      context
        ..pop()
        ..pop();

      showSuccessSnackbar(context: context, text: context.l10n.identityRecovery_printKitSuccess);
    }
  }

  Future<void> _generatePDF() async {
    final runtime = GetIt.I.get<EnmeshedRuntime>();
    final session = runtime.getSession(widget.accountId);
    final account = await runtime.accountServices.getAccount(widget.accountId);

    final token = await session.transportServices.identityRecoveryKits.createIdentityRecoveryKit(
      profileName: account.name,
      passwordProtection: PasswordProtection(password: widget.password!),
    );

    final spacerSvgImage = await rootBundle.loadString('assets/svg_without_transforming/triangle.svg');
    final logoImageData = await rootBundle.load('assets/pictures/enmeshed_logo_light_cut.png');
    final logoBytes = logoImageData.buffer.asUint8List();

    if (!mounted) return;

    final generatedPdf = await PdfGenerator(
      headerTitleHexColor: '#1A80D9',
      backgroundHexColor: '#D7E3F8',
      defaultTextHexColor: '#17428D',
      borderHexColor: '#17428D',
      labelHexColor: '#17428D',
      addressHexColor: '#1A80D9',
      pdfTexts: (
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
      ),
      qrSettings: (errorCorrectionLevel: QRErrorCorrectionLevel.L, qrPixelSize: null),
    ).generate(
      logoBytes: logoBytes,
      spacerSvgImage: spacerSvgImage,
      truncatedReference: 'nmshd://tr#${token.value.truncatedReference}',
    );

    if (mounted) setState(() => _pdf = generatedPdf);
  }
}

class _RecoveryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _RecoveryCard({required this.title, required this.description, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Center(child: Icon(icon, color: Theme.of(context).colorScheme.primary)),
              ),
              Gaps.w16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(description, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
