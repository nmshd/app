import 'package:flutter/material.dart';

import 'onboarding_account.dart';
import 'onboarding_create_account.dart';
import 'onboarding_information.dart';
import 'onboarding_legal_texts.dart';
import 'onboarding_welcome.dart';

enum OnboardingMode { welcome, info, legalTexts, createAccount, loading }

class OnboardingScreen extends StatefulWidget {
  final bool skipIntroduction;

  const OnboardingScreen({required this.skipIntroduction, super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnboardingMode _mode;

  @override
  void initState() {
    super.initState();

    _mode = widget.skipIntroduction ? OnboardingMode.createAccount : OnboardingMode.welcome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: switch (_mode) {
        OnboardingMode.welcome => OnboardingWelcome(goToOnboardingInformation: () => setState(() => _mode = OnboardingMode.info)),
        OnboardingMode.info => OnboardingInformation(goToOnboardingLegalTexts: () => setState(() => _mode = OnboardingMode.legalTexts)),
        OnboardingMode.legalTexts => OnboardingLegalTexts(goToOnboardingCreateAccount: () => setState(() => _mode = OnboardingMode.createAccount)),
        OnboardingMode.createAccount => OnboardingAccount(goToOnboardingLoading: () => setState(() => _mode = OnboardingMode.loading)),
        OnboardingMode.loading => OnboardingCreateAccount(goToOnboardingAccount: () => setState(() => _mode = OnboardingMode.createAccount)),
      },
    );
  }
}
