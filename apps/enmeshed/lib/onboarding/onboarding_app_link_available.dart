import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class OnboardingAppLinkAvailable extends StatelessWidget {
  final VoidCallback next;

  const OnboardingAppLinkAvailable({required this.next, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            spacing: 24,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 24,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          context.l10n.onboarding_appLinkAvailable_welcome,
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      Text(context.l10n.onboarding_appLinkAvailable_information),
                      Text(context.l10n.onboarding_appLinkAvailable_howToProceed),
                      InformationCard(
                        title: context.l10n.onboarding_appLinkAvailable_nextSteps,
                        icon: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 4,
                  children: [
                    OutlinedButton(onPressed: () => context.pushReplacement('/onboarding'), child: Text(context.l10n.cancel)),
                    FilledButton(onPressed: next, child: Text(context.l10n.onboarding_appLinkAvailable_continue)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
