import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'widgets/profiles_in_deletion_container.dart';

class OnboardingAccount extends StatefulWidget {
  final VoidCallback goToOnboardingLoading;
  final String? appLink;

  const OnboardingAccount({required this.goToOnboardingLoading, required this.appLink, super.key});

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
  void didUpdateWidget(covariant OnboardingAccount oldWidget) {
    super.didUpdateWidget(oldWidget);

    _loadAccountsInDeletion();
  }

  @override
  Widget build(BuildContext context) {
    final leftTriangleColor = Theme.of(context).colorScheme.surfaceContainerLow;
    final rightTriangleColor = Theme.of(context).colorScheme.surfaceContainerHigh;
    final bottomColor = Theme.of(context).colorScheme.primaryContainer;

    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_accountsInDeletion.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ProfilesInDeletionContainer(accountsInDeletion: _accountsInDeletion, onDeleted: _loadAccountsInDeletion),
                  ),
                  Gaps.h48,
                ],
                Column(
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
                CustomPaint(
                  painter: _BackgroundPainter(leftTriangleColor: leftTriangleColor, rightTriangleColor: rightTriangleColor, bottomColor: bottomColor),
                  child: const SizedBox(width: double.infinity, height: 120),
                ),
                Container(
                  color: bottomColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ).add(EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(context.l10n.onboarding_createNewAccount, style: Theme.of(context).textTheme.titleLarge),
                      Gaps.h16,
                      Text(context.l10n.onboarding_createNewAccount_description, textAlign: TextAlign.center),
                      Gaps.h16,
                      FilledButton(onPressed: widget.goToOnboardingLoading, child: Text(context.l10n.onboarding_createNewAccount_button)),
                      Gaps.h24,
                      Row(
                        children: [
                          const Expanded(child: Divider(thickness: 1)),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(context.l10n.or)),
                          const Expanded(child: Divider(thickness: 1)),
                        ],
                      ),
                      Gaps.h24,
                      Text(context.l10n.onboarding_existingIdentity, style: Theme.of(context).textTheme.titleLarge),
                      Gaps.h16,
                      Text(context.l10n.onboarding_existingIdentity_description, textAlign: TextAlign.center),
                      Gaps.h16,
                      FilledButton(onPressed: () => _onboardingPressed(context), child: Text(context.l10n.scanner_scanQR)),
                      Gaps.h16,
                      TextButton(
                        onPressed: () => context.push('/restore-from-identity-recovery-kit'),
                        child: Text(context.l10n.onboarding_restoreProfile_button),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

    final result = await runtime.stringProcessor.processDeviceOnboardingReference(url: content);
    if (result.isSuccess) {
      resume();
      return;
    }

    GetIt.I.get<Logger>().e('Error while processing url $content: ${result.error.message}');
    if (!context.mounted) return;

    await context.push('/error-dialog', extra: result.error.code);

    if (!context.mounted) return;
    if (context.canPop()) context.pop();

    resume();
  }

  Future<void> _handleAppLink(LocalAccountDTO account) async {
    if (widget.appLink == null) return;

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    await runtime.stringProcessor.processURL(url: widget.appLink!, account: account);

    // TODO(jkoenig134): when this didn't work, we should show an error dialog that allows the user to retry
  }
}

class _BackgroundPainter extends CustomPainter {
  final Color leftTriangleColor;
  final Color rightTriangleColor;
  final Color bottomColor;

  _BackgroundPainter({required this.leftTriangleColor, required this.rightTriangleColor, required this.bottomColor});

  @override
  void paint(Canvas canvas, Size size) {
    final rightPaint = Paint()
      ..color = rightTriangleColor
      ..style = PaintingStyle.fill;

    final leftPaint = Paint()
      ..color = leftTriangleColor
      ..style = PaintingStyle.fill;

    final bottomPaint = Paint()
      ..color = bottomColor
      ..style = PaintingStyle.fill;

    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(0, size.height)
      ..close();

    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..close();

    final rightPath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..close();

    canvas
      ..drawPath(leftPath, leftPaint)
      ..drawPath(bottomPath, bottomPaint)
      ..drawPath(rightPath, rightPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
