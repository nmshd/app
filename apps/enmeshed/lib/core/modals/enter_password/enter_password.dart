import 'dart:math';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/extensions.dart';
import 'password_input.dart';
import 'pin_input.dart';

class EnterPasswordModal extends StatelessWidget {
  final UIBridgePasswordType passwordType;
  final int attempt;
  final int? pinLength;
  final int? passwordLocationIndicator;

  const EnterPasswordModal({
    required this.passwordType,
    required this.attempt,
    required this.pinLength,
    required this.passwordLocationIndicator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: max(MediaQuery.viewInsetsOf(context).bottom, MediaQuery.viewPaddingOf(context).bottom)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 16, top: 8),
            child: Row(
              children: [
                Text(switch (passwordType) {
                  UIBridgePasswordType.password => context.l10n.passwordProtection_enterPassword,
                  UIBridgePasswordType.pin => context.l10n.passwordProtection_enterPin,
                }, style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), child: Text(_buildProtectionExplanation(context))),
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
                        child: Text(switch (passwordType) {
                          UIBridgePasswordType.password => context.l10n.passwordProtection_incorrectPassword,
                          UIBridgePasswordType.pin => context.l10n.passwordProtection_incorrectPin,
                        }, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onError)),
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

  String _buildProtectionExplanation(BuildContext context) {
    // 0 = RecoveryKit - will only occur with password type and get a separate message
    if (passwordType == UIBridgePasswordType.password && passwordLocationIndicator == 0) {
      return context.l10n.passwordProtection_referenceIsPasswordProtected_recoveryKit;
    }

    final baseText = switch (passwordType) {
      UIBridgePasswordType.password => context.l10n.passwordProtection_referenceIsPasswordProtected,
      UIBridgePasswordType.pin => context.l10n.passwordProtection_referenceIsPinProtected(switch (pinLength!) {
        4 || 5 || 6 => pinLength.toString(),
        _ => 'other',
      }),
    };

    final locationText = switch ((passwordType, passwordLocationIndicator)) {
      // 1 = Self
      (UIBridgePasswordType.password, 1) => context.l10n.passwordProtection_referenceIsPasswordProtected_self,
      (UIBridgePasswordType.pin, 1) => context.l10n.passwordProtection_referenceIsPinProtected_self,

      // 2 = Letter
      (UIBridgePasswordType.password, 2) => context.l10n.passwordProtection_referenceIsPasswordProtected_letter,
      (UIBridgePasswordType.pin, 2) => context.l10n.passwordProtection_referenceIsPinProtected_letter,

      // 3 = RegistrationLetter
      (UIBridgePasswordType.password, 3) => context.l10n.passwordProtection_referenceIsPasswordProtected_registrationLetter,
      (UIBridgePasswordType.pin, 3) => context.l10n.passwordProtection_referenceIsPinProtected_registrationLetter,

      // 4 = Email
      (UIBridgePasswordType.password, 4) => context.l10n.passwordProtection_referenceIsPasswordProtected_email,
      (UIBridgePasswordType.pin, 4) => context.l10n.passwordProtection_referenceIsPinProtected_email,

      // 5 = SMS
      (UIBridgePasswordType.password, 5) => context.l10n.passwordProtection_referenceIsPasswordProtected_sms,
      (UIBridgePasswordType.pin, 5) => context.l10n.passwordProtection_referenceIsPinProtected_sms,

      // 7 = Website
      (UIBridgePasswordType.password, 6) => context.l10n.passwordProtection_referenceIsPasswordProtected_website,
      (UIBridgePasswordType.pin, 6) => context.l10n.passwordProtection_referenceIsPinProtected_website,

      // everything else
      (UIBridgePasswordType.password, _) => context.l10n.passwordProtection_referenceIsPasswordProtected_default,
      (UIBridgePasswordType.pin, _) => context.l10n.passwordProtection_referenceIsPinProtected_default,
    };

    return '$baseText $locationText';
  }
}
