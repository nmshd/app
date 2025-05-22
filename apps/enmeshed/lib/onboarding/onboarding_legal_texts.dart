import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class OnboardingLegalTexts extends StatefulWidget {
  final VoidCallback next;
  final String? appLink;

  const OnboardingLegalTexts({required this.next, required this.appLink, super.key});

  @override
  State<OnboardingLegalTexts> createState() => _OnboardingLegalTextsState();
}

class _OnboardingLegalTextsState extends State<OnboardingLegalTexts> {
  bool _isPrivacyPolicyAccepted = false;

  @override
  Widget build(BuildContext context) {
    // TODO: repect app link amd remder other buttons (also create account on finished)

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              context.l10n.onboarding_yourConsent,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Gaps.h24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(context.l10n.onboarding_consentParagraph1, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Gaps.h24,
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.l10n.onboarding_consentParagraph2),
                          Gaps.h16,
                          Text(context.l10n.onboarding_consentParagraph3),
                          Gaps.h16,
                          Text(context.l10n.onboarding_consentParagraph4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Gaps.h16,
          _LegalTextNote(
            legalTextStart: context.l10n.onboarding_dataPrivacy_start,
            legalTextLink: context.l10n.onboarding_dataPrivacy_link,
            legalTextEnd: context.l10n.onboarding_dataPrivacy_end,
            path: '/data-protection',
            isLegalTextAccepted: _isPrivacyPolicyAccepted,
            toggleIsLegalTextAccepted: () => setState(() => _isPrivacyPolicyAccepted = !_isPrivacyPolicyAccepted),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Align(
              child: FilledButton(
                onPressed: isLegalAgreementCompleted ? widget.next : null,
                child: Text(context.l10n.onboarding_yourConsent_acceptAndContinue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get isLegalAgreementCompleted => _isPrivacyPolicyAccepted;
}

class _LegalTextNote extends StatelessWidget {
  final String legalTextStart;
  final String legalTextLink;
  final String legalTextEnd;
  final String path;
  final bool isLegalTextAccepted;
  final VoidCallback toggleIsLegalTextAccepted;

  const _LegalTextNote({
    required this.legalTextStart,
    required this.legalTextLink,
    required this.legalTextEnd,
    required this.path,
    required this.isLegalTextAccepted,
    required this.toggleIsLegalTextAccepted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 24),
      child: InkWell(
        onTap: toggleIsLegalTextAccepted,
        child: Row(
          children: [
            Checkbox(value: isLegalTextAccepted, onChanged: (_) => toggleIsLegalTextAccepted()),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: legalTextStart),
                    TextSpan(
                      text: legalTextLink,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => context.push(path),
                    ),
                    TextSpan(text: legalTextEnd),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
