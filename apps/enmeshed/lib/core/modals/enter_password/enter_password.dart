import 'dart:math' as math;

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../utils/extensions.dart';
import 'password_input.dart';
import 'pin_input.dart';

class EnterPasswordModal extends StatelessWidget {
  final UIBridgePasswordType passwordType;
  final int attempt;
  final int? pinLength;

  const EnterPasswordModal({required this.passwordType, required this.attempt, this.pinLength, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: math.max(MediaQuery.viewInsetsOf(context).bottom, 24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 16, top: 8),
            child: Row(
              children: [
                Text(
                  switch (passwordType) {
                    UIBridgePasswordType.password => context.l10n.passwordProtection_enterPassword,
                    UIBridgePasswordType.pin => context.l10n.passwordProtection_enterPin,
                  },
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              switch (passwordType) {
                UIBridgePasswordType.password => context.l10n.passwordProtection_referenceIsPasswordProtected,
                UIBridgePasswordType.pin => context.l10n.passwordProtection_referenceIsPinProtected(
                    switch (pinLength!) { 4 || 5 || 6 => pinLength.toString(), _ => 'other' },
                  ),
              },
            ),
          ),
          if (attempt > 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Card(
                margin: EdgeInsets.zero,
                color: Theme.of(context).colorScheme.error,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
                      Gaps.w8,
                      Expanded(
                        child: Text(
                          switch (passwordType) {
                            UIBridgePasswordType.password => context.l10n.passwordProtection_incorrectPassword,
                            UIBridgePasswordType.pin => context.l10n.passwordProtection_incorrectPin,
                          },
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onError),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: switch (passwordType) {
              UIBridgePasswordType.password => const PasswordInput(),
              UIBridgePasswordType.pin => PinInput(pinLength: pinLength!),
            },
          ),
        ],
      ),
    );
  }
}
