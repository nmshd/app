import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'widgets/profiles_in_deletion_container.dart';

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
    final leftTriangleColor = Theme.of(context).colorScheme.secondary.withValues(alpha: 0.04);
    final rightTriangleColor = Theme.of(context).colorScheme.primary.withValues(alpha: 0.04);
    final topColor = Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.6);

    return SafeArea(
      top: false,
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(color: topColor, width: double.infinity, height: 64 * 2),
              if (_accountsInDeletion.isNotEmpty) ...[
                Container(
                  color: topColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ProfilesInDeletionContainer(accountsInDeletion: _accountsInDeletion, onDeleted: _loadAccountsInDeletion),
                ),
                Container(color: topColor, width: double.infinity, height: 48),
              ],
              Container(
                color: topColor,
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      context.l10n.onboarding_createIdentity,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    Gaps.h16,
                    Text(context.l10n.onboarding_chooseOption, textAlign: TextAlign.center),
                    Gaps.h16,
                  ],
                ),
              ),
              CustomPaint(
                painter: _BackgroundPainter(leftTriangleColor: leftTriangleColor, rightTriangleColor: rightTriangleColor, topColor: topColor),
                child: const SizedBox(width: double.infinity, height: 120),
              ),
              Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadAccountsInDeletion() async {
    final runtime = GetIt.I.get<EnmeshedRuntime>();
    final accountsInDeletion = await runtime.accountServices.getAccountsInDeletion();

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

    unawaited(showLoadingDialog(context, context.l10n.onboarding_receiveInformation));

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    if (!context.mounted) return;

    await _processString(content: content, context: context, runtime: runtime);

    if (!context.mounted) return;
    if (context.canPop()) context.pop();

    resume();
  }

  Future<void> _processString({
    required String content,
    required BuildContext context,
    required EnmeshedRuntime runtime,
  }) async {
    final result = await runtime.stringProcessor.processURL(url: content);
    if (result.isSuccess) return;

    GetIt.I.get<Logger>().e('Error while processing url $content: ${result.error.message}');
    if (!context.mounted) return;

    switch (result.error.code) {
      case 'error.appStringProcessor.passwordNotProvided':
        break;
      case 'error.runtime.recordNotFound':
        // this could mean that the password is wrong, retry
        await _processString(content: content, context: context, runtime: runtime);
      default:
        await showWrongTokenErrorDialog(context);
    }
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
    final rightPaint = Paint()
      ..color = rightTriangleColor
      ..style = PaintingStyle.fill;

    final leftPaint = Paint()
      ..color = leftTriangleColor
      ..style = PaintingStyle.fill;

    final topPaint = Paint()
      ..color = topColor
      ..style = PaintingStyle.fill;

    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(0, size.height)
      ..close();

    final topPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, 0)
      ..close();

    final rightPath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..close();

    canvas
      ..drawPath(leftPath, leftPaint)
      ..drawPath(topPath, topPaint)
      ..drawPath(rightPath, rightPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
