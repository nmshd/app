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
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/utils/extensions.dart';
import '../constants.dart';
import '../utils/snackbars.dart';
import '../widgets/widgets.dart';

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
        child: _CreatePassword(
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
            return _SaveRecoveryKit(
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

class _CreatePassword extends StatefulWidget {
  final void Function(String password) onContinue;

  const _CreatePassword({required this.onContinue});

  @override
  State<_CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<_CreatePassword> {
  final form = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: max(MediaQuery.paddingOf(context).bottom, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.identityRecovery_passwordDescription),
          Gaps.h24,
          InformationContainer(title: context.l10n.identityRecovery_passwordAttention),
          Gaps.h36,
          Form(
            key: form,
            child: Column(
              children: [
                _PasswordTextField(
                  inputControl: _passwordController,
                  label: context.l10n.identityRecovery_password,
                  obscureText: _passwordVisible,
                  onIconTap: () => setState(() => _passwordVisible = !_passwordVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty) return context.l10n.identityRecovery_passwordEmptyError;
                    return null;
                  },
                ),
                Gaps.h24,
                _PasswordTextField(
                  inputControl: _confirmPasswordController,
                  label: context.l10n.identityRecovery_passwordConfirm,
                  obscureText: _confirmPasswordVisible,
                  onIconTap: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty) return context.l10n.identityRecovery_passwordEmptyError;
                    if (value != _passwordController.text) return context.l10n.identityRecovery_passwordError;
                    return null;
                  },
                ),
                Gaps.h48,
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: () {
                      if (form.currentState!.validate()) widget.onContinue(_passwordController.text);
                    },
                    child: Text(context.l10n.identityRecovery_startNow),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  final TextEditingController inputControl;
  final String label;
  final bool obscureText;
  final VoidCallback onIconTap;
  final String? Function(String?) validator;

  const _PasswordTextField({
    required this.inputControl,
    required this.label,
    required this.obscureText,
    required this.onIconTap,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputControl,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: onIconTap,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      validator: validator,
    );
  }
}

class _SaveRecoveryKit extends StatefulWidget {
  final String accountId;
  final String? password;
  final VoidCallback onBackPressed;

  const _SaveRecoveryKit({required this.accountId, required this.password, required this.onBackPressed});

  @override
  State<_SaveRecoveryKit> createState() => _SaveRecoveryKitState();
}

class _SaveRecoveryKitState extends State<_SaveRecoveryKit> {
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

  // Download is not working on iOS simulator (but works on real device)
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
    const selectedErrorCorrectionLevel = QRErrorCorrectionLevel.L;

    if (!mounted) return;

    final generatedPdf = await PdfGenerator(
      headerTitleHexColor: '#CD5038',
      backgroundHexColor: '#D0E6F3',
      defaultTextHexColor: '#004F79',
      borderHexColor: '#006685',
      labelHexColor: '#006685',
      addressHexColor: '#0077B6',
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
      qrSettings: (errorCorrectionLevel: selectedErrorCorrectionLevel, qrPixelSize: null),
    ).generate(
      logoBytes: logoBytes,
      spacerSvgImage: spacerSvgImage,
      truncatedReference: token.value.truncatedReference,
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
