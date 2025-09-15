import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'widgets/profiles_in_deletion_container.dart';

class OnboardingSelectOption extends StatefulWidget {
  final VoidCallback createAccount;

  const OnboardingSelectOption({required this.createAccount, super.key});

  @override
  State<OnboardingSelectOption> createState() => _OnboardingSelectOptionState();
}

class _OnboardingSelectOptionState extends State<OnboardingSelectOption> {
  List<LocalAccountDTO> _accountsInDeletion = [];

  @override
  void initState() {
    super.initState();

    _loadAccountsInDeletion();
  }

  @override
  void didUpdateWidget(covariant OnboardingSelectOption oldWidget) {
    super.didUpdateWidget(oldWidget);

    _loadAccountsInDeletion();
  }

  @override
  Widget build(BuildContext context) {
    final leftTriangleColor = Theme.of(context).colorScheme.surfaceContainerLow;
    final rightTriangleColor = Theme.of(context).colorScheme.surfaceContainerHigh;
    final topColor = Theme.of(context).colorScheme.surface;
    final bottomColor = Theme.of(context).colorScheme.primaryContainer;

    return Scaffold(
      backgroundColor: bottomColor,
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
            child: Column(
              children: [
                ColoredBox(
                  color: topColor,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 16 + 64, bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_accountsInDeletion.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: ProfilesInDeletionContainer(accountsInDeletion: _accountsInDeletion, onDeleted: _loadAccountsInDeletion),
                          ),
                          Gaps.h48,
                        ],
                        SizedBox(
                          height: 64,
                          child: Image.asset(switch (Theme.of(context).brightness) {
                            Brightness.light => 'assets/pictures/enmeshed_logo_light_cut.png',
                            Brightness.dark => 'assets/pictures/enmeshed_logo_dark_cut.png',
                          }),
                        ),
                        Gaps.h24,
                        Text(
                          context.l10n.onboarding_createIdentity,
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                          textAlign: TextAlign.center,
                        ),
                        Gaps.h16,
                        Text(context.l10n.onboarding_chooseOption, textAlign: TextAlign.center),
                        Gaps.h16,
                      ],
                    ),
                  ),
                ),
                CustomPaint(
                  painter: _BackgroundPainter(
                    leftTriangleColor: leftTriangleColor,
                    rightTriangleColor: rightTriangleColor,
                    topColor: topColor,
                    bottomColor: bottomColor,
                  ),
                  child: const SizedBox(width: double.infinity, height: 120),
                ),
                Container(
                  color: bottomColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 36,
                  ).add(EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom)),
                  child: Column(
                    spacing: 16,
                    children: [
                      Text(context.l10n.onboarding_optionsDescription, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem<void>(
                            onTap: widget.createAccount,
                            child: Text(context.l10n.onboarding_createNewAccount),
                          ),
                          PopupMenuItem<void>(
                            onTap: () => showTransferProfileModal(context: context),
                            child: Text(context.l10n.onboarding_transferProfile),
                          ),
                          PopupMenuItem<void>(
                            onTap: () => context.push('/restore-from-identity-recovery-kit'),
                            child: Text(context.l10n.onboarding_receryKit),
                          ),
                        ],
                        icon: const Icon(Icons.add),
                        iconColor: Theme.of(context).colorScheme.onPrimary,
                        style: IconButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                        position: PopupMenuPosition.under,
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
}

class _BackgroundPainter extends CustomPainter {
  final Color leftTriangleColor;
  final Color rightTriangleColor;
  final Color topColor;
  final Color bottomColor;

  _BackgroundPainter({required this.leftTriangleColor, required this.rightTriangleColor, required this.bottomColor, required this.topColor});

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

    final bottomPaint = Paint()
      ..color = bottomColor
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
      ..drawPath(topPath, topPaint)
      ..drawPath(bottomPath, bottomPaint)
      ..drawPath(rightPath, rightPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
