import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';

class OnboardingAccount extends StatefulWidget {
  final VoidCallback goToOnboardingLoading;

  const OnboardingAccount({required this.goToOnboardingLoading, super.key});

  @override
  State<OnboardingAccount> createState() => _OnboardingAccountState();
}

class _OnboardingAccountState extends State<OnboardingAccount> {
  List<LocalAccountDTO> _accountsInDeletion = [];

  @override
  void initState() {
    super.initState();

    _loadAccountsInDeletion();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        CustomPaint(
          painter: _BackgroundPainter(
            leftTriangleColor: Theme.of(context).colorScheme.secondary.withOpacity(0.04),
            rightTriangleColor: Theme.of(context).colorScheme.primary.withOpacity(0.04),
            topColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
          ),
          size: Size.infinite,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_accountsInDeletion.isEmpty) ...[
                    SizedBox(height: screenHeight * 0.14),
                    Text(
                      context.l10n.onboarding_createIdentity,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    Gaps.h16,
                    Text(context.l10n.onboarding_chooseOption, textAlign: TextAlign.center),
                    const SizedBox(height: 72),
                  ],
                  if (_accountsInDeletion.isNotEmpty) ...[
                    RestoreProfileContainer(accountsInDeletion: _accountsInDeletion),
                    Gaps.h16,
                  ],
                  Text(context.l10n.onboarding_createNewAccount, style: Theme.of(context).textTheme.titleLarge),
                  Gaps.h16,
                  Text(context.l10n.onboarding_createNewAccount_description, textAlign: TextAlign.center),
                  Gaps.h24,
                  FilledButton(onPressed: widget.goToOnboardingLoading, child: Text(context.l10n.onboarding_createNewAccount_button)),
                  Gaps.h24,
                  Row(
                    children: [
                      const Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(context.l10n.or),
                      ),
                      const Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  Gaps.h24,
                  Text(context.l10n.onboarding_existingIdentity, style: Theme.of(context).textTheme.titleLarge),
                  Gaps.h16,
                  Text(context.l10n.onboarding_existingIdentity_description, textAlign: TextAlign.center),
                  Gaps.h24,
                  FilledButton(onPressed: () => _onboardingPressed(context), child: Text(context.l10n.scanner_scanQR)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _loadAccountsInDeletion() async {
    final accountsInDeletion = await getAccountsInDeletion();

    if (mounted) setState(() => _accountsInDeletion = accountsInDeletion);
  }

  void _onboardingPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ScannerView(
          onSubmit: _onSubmit,
          lineUpQrCodeText: context.l10n.scanner_lineUpQrCode,
          scanQrOrEnterUrlText: context.l10n.scanner_scanQrOrEnterUrl,
          enterUrlText: context.l10n.scanner_enterUrl,
          urlTitle: context.l10n.onboarding_connectWithUrl_title,
          urlDescription: context.l10n.onboarding_connectWithUrl_description,
          urlLabelText: context.l10n.scanner_enterUrl,
          urlValidationErrorText: context.l10n.scanner_urlValidationError,
          urlButtonText: context.l10n.onboarding_linkAccount,
        ),
      ),
    );
  }

  Future<void> _onSubmit({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) async {
    pause();

    GetIt.I.get<Logger>().t('Scanned code: $content');

    if (!content.startsWith('nmshd://')) {
      await showWrongTokenErrorDialog(context);
      resume();
      return;
    }

    unawaited(showLoadingDialog(context, context.l10n.onboarding_receiveInformation));

    final truncatedReference = content.replaceAll('nmshd://qr#', '').replaceAll('nmshd://tr#', '');

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final result = await runtime.stringProcessor.processTruncatedReference(truncatedReference: truncatedReference);
    if (!context.mounted) return;

    resume();
    if (context.canPop()) context.pop();

    if (result.isError) await showWrongTokenErrorDialog(context);
  }
}

class _BackgroundPainter extends CustomPainter {
  final Color leftTriangleColor;
  final Color rightTriangleColor;
  final Color topColor;

  _BackgroundPainter({
    required this.leftTriangleColor,
    required this.rightTriangleColor,
    required this.topColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = rightTriangleColor
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = leftTriangleColor
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = topColor
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(size.width, size.height * 0.3)
      ..lineTo(size.width / 2, size.height * 0.365)
      ..lineTo(size.width, size.height * 0.43)
      ..close();

    final path2 = Path()
      ..moveTo(0, size.height * 0.3)
      ..lineTo(size.width / 2, size.height * 0.365)
      ..lineTo(0, size.height * 0.43)
      ..close();

    final path3 = Path()
      ..moveTo(0, size.height * 0.3)
      ..lineTo(size.width / 2, size.height * 0.365)
      ..lineTo(size.width, size.height * 0.3)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas
      ..drawPath(path1, paint1)
      ..drawPath(path2, paint2)
      ..drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
