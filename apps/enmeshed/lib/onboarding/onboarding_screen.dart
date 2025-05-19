import 'package:flutter/material.dart';

import 'onboarding_account.dart';
import 'onboarding_create_account.dart';
import 'onboarding_information.dart';
import 'onboarding_legal_texts.dart';
import 'onboarding_welcome.dart';

enum _OnboardingMode { welcome, info, legalTexts, selectOption, createAccount }

class OnboardingScreen extends StatefulWidget {
  final bool skipIntroduction;
  final String? appLink;

  const OnboardingScreen({required this.skipIntroduction, required this.appLink, super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late _OnboardingMode _mode;

  @override
  void initState() {
    super.initState();

    _mode = widget.skipIntroduction ? _OnboardingMode.selectOption : _OnboardingMode.welcome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: switch (_mode) {
        _OnboardingMode.welcome => OnboardingWelcome(goToOnboardingInformation: () => setState(() => _mode = _OnboardingMode.info)),
        _OnboardingMode.info => OnboardingInformation(goToOnboardingLegalTexts: () => setState(() => _mode = _OnboardingMode.legalTexts)),
        _OnboardingMode.legalTexts => OnboardingLegalTexts(goToOnboardingCreateAccount: () => setState(() => _mode = _OnboardingMode.selectOption)),
        _OnboardingMode.selectOption => OnboardingAccount(
          goToOnboardingLoading: () => setState(() => _mode = _OnboardingMode.createAccount),
          appLink: widget.appLink,
        ),
        _OnboardingMode.createAccount => OnboardingCreateAccount(
          goToOnboardingAccount: () => setState(() => _mode = _OnboardingMode.selectOption),
          appLink: widget.appLink,
        ),
      },
    );
  }
}
