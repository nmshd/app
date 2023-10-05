import 'dart:math' as math;

import 'package:flutter/material.dart';

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
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'onboarding_welcome',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'onboarding_description',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 30),
                          Text('onboarding_identityNeeded'),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: OutlinedButton(
                      child: const Text('next'),
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
