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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24,
            children: [
              Text(
                // TODO: translation
                'Willkommen bei\nEnmeshed',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const Text(
                // TODO: translation
                'Sie haben einen QR-Code der Bildungsraum-Plattform gescannt. Mit der Mein Bildungsraum-App können Sie persönliche Dokumente und Daten verwalten, Ihre Bildungs-Kontakte organisieren und Bildungsnachweise mit Bildungspartnern teilen.',
              ),
              const Text(
                // TODO: translation
                'Um mit dem gerade gescannten QR-Code fortfahren zu können müssen Sie ein persönliches Profil in der Bildungsraum-App anlegen.',
              ),
              InformationCard(
                // TODO: translation
                title:
                    'Sie werden im Folgenden durch die wenigen Schritte zur Erstellung Ihres persönlichen Profils geführt. Im nächsten Schritt müssen Sie den Nutzungsbestimmungen zustimmen.',
                icon: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 4,
                children: [
                  OutlinedButton(onPressed: () => context.pushReplacement('/onboarding'), child: Text(context.l10n.cancel)),
                  FilledButton(
                    onPressed: next,
                    // TODO: translation
                    child: const Text('Profil anlegen und mit Code fortfahren'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
