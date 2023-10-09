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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('Onboarding needed'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),
                  OutlinedButton(
                    child: const Text('next'),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const AccountCreationScreen()),
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
