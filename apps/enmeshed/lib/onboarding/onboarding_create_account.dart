import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class OnboardingCreateAccount extends StatefulWidget {
  final VoidCallback goToOnboardingAccount;

  const OnboardingCreateAccount({required this.goToOnboardingAccount, super.key});

  @override
  State<OnboardingCreateAccount> createState() => _OnboardingCreateAccountState();
}

class _OnboardingCreateAccountState extends State<OnboardingCreateAccount> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _showEnterProfileName());
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 150, width: 150, child: CircularProgressIndicator(strokeWidth: 16)),
          Gaps.h32,
          Text(
            context.l10n.onboarding_creatingAccount,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Future<void> _showEnterProfileName() async {
    final newProfileName = await showEnterProfileNameModal(context);

    if (newProfileName == null || !mounted) return widget.goToOnboardingAccount();

    await createNewAccount(context: context, accountName: newProfileName, goToOnboardingAccount: widget.goToOnboardingAccount);
  }
}
