import 'package:flutter/material.dart';

import 'onboarding_app_link_available.dart';
import 'onboarding_information.dart';
import 'onboarding_legal_texts.dart';
import 'onboarding_select_option.dart';
import 'onboarding_welcome.dart';

enum _OnboardingMode { welcome, info, legalTexts, selectOption, appLinkAvailable }

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

    if (widget.appLink != null) {
      _mode = _OnboardingMode.appLinkAvailable;
    } else {
      _mode = widget.skipIntroduction ? _OnboardingMode.selectOption : _OnboardingMode.welcome;
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.appLink != widget.appLink && widget.appLink != null) {
      setState(() => _mode = _OnboardingMode.appLinkAvailable);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: switch (_mode) {
        _OnboardingMode.appLinkAvailable => OnboardingAppLinkAvailable(next: () => setState(() => _mode = _OnboardingMode.legalTexts)),
        _OnboardingMode.welcome => OnboardingWelcome(next: () => setState(() => _mode = _OnboardingMode.info)),
        _OnboardingMode.info => OnboardingInformation(next: () => setState(() => _mode = _OnboardingMode.legalTexts)),
        _OnboardingMode.legalTexts => OnboardingLegalTexts(next: () => setState(() => _mode = _OnboardingMode.selectOption), appLink: widget.appLink),
        _OnboardingMode.selectOption => const OnboardingSelectOption(),
      },
    );
  }
}
