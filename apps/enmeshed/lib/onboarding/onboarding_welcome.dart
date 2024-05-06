import 'package:flutter/material.dart';

import '/core/core.dart';
import 'widgets/red_shrinked_divider.dart';

class OnboardingWelcome extends StatelessWidget {
  final VoidCallback goToOnboardingInformation;

  const OnboardingWelcome({required this.goToOnboardingInformation, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.viewInsetsOf(context).bottom + 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight / 3,
                      child: Center(
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset(switch (MediaQuery.of(context).platformBrightness) {
                            Brightness.light => 'assets/enmeshed_logo_light_cut.png',
                            Brightness.dark => 'assets/enmeshed_logo_dark_cut.png',
                          }),
                        ),
                      ),
                    ),
                    Text(
                      context.l10n.onboarding_welcome,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                    Gaps.h32,
                    const RedShrinkedDivider(width: 108),
                    Gaps.h32,
                    Text(
                      context.l10n.onboarding_description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            FilledButton(
              onPressed: goToOnboardingInformation,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
              child: Text(context.l10n.onboarding_letsStart),
            ),
          ],
        ),
      ),
    );
  }
}
