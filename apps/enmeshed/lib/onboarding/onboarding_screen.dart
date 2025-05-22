import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
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

    if (oldWidget.appLink == widget.appLink) return;

    if (widget.appLink != null) {
      setState(() => _mode = _OnboardingMode.appLinkAvailable);
      return;
    }

    setState(() => _mode = widget.skipIntroduction ? _OnboardingMode.selectOption : _OnboardingMode.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: switch (_mode) {
        _OnboardingMode.appLinkAvailable => OnboardingAppLinkAvailable(next: () => setState(() => _mode = _OnboardingMode.legalTexts)),
        _OnboardingMode.welcome => OnboardingWelcome(next: () => setState(() => _mode = _OnboardingMode.info)),
        _OnboardingMode.info => OnboardingInformation(next: () => setState(() => _mode = _OnboardingMode.legalTexts)),
        _OnboardingMode.legalTexts => OnboardingLegalTexts(
          cancel: () => setState(() => _mode = _OnboardingMode.welcome),
          next: widget.appLink != null ? _createAccount : () => setState(() => _mode = _OnboardingMode.selectOption),
          appLinkAvailable: widget.appLink != null,
        ),
        _OnboardingMode.selectOption => OnboardingSelectOption(createAccount: _createAccount),
      },
    );
  }

  Future<void> _createAccount() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => CreateProfile(
        // TODO: translation
        loadingDescription: widget.appLink == null ? null : 'Sie werden im Anschluss zur Kontaktanfrage aus dem QR-Code weitergeleitet.',
        onProfileCreated: (account) async {
          context.go('/account/${account.id}');
          if (widget.appLink != null) {
            final url = widget.appLink!;
            final result = await GetIt.I<EnmeshedRuntime>().stringProcessor.processURL(url: url, account: account);
            GetIt.I.get<Logger>().e('Error while processing url $url: ${result.error.message}');

            if (!mounted) return;

            await context.push('/error-dialog', extra: result.error.code);
          }
        },
      ),
    );
  }
}
