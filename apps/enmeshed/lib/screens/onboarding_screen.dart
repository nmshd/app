import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'account_creation_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallerSide = math.min(size.height, size.width);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: smallerSide,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: smallerSide / 8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: size.height / 14,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      MediaQuery.of(context).platformBrightness == Brightness.light
                          ? 'assets/enmeshed_logo_light.png'
                          : 'assets/enmeshed_logo_dark.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.onboarding_welcome,
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.onboarding_description,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 30),
                          Text(AppLocalizations.of(context)!.onboarding_identityNeeded),
                          Text(AppLocalizations.of(context)!.onboarding_existingIdentity),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: OutlinedButton(
                      child: Text(AppLocalizations.of(context)!.next),
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => const AccountCreationScreen()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
