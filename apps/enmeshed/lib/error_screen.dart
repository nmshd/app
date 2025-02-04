import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/utils/extensions.dart';

class ErrorScreen extends StatelessWidget {
  final bool backboneNotAvailable;

  const ErrorScreen({required this.backboneNotAvailable, super.key});

  @override
  Widget build(BuildContext context) {
    final contentColor = Theme.of(context).colorScheme.onSecondaryContainer;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (backboneNotAvailable)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(context.l10n.error_backboneNotAvailable, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
              ),
            Gaps.h16,
            Align(
              alignment: Alignment.topCenter,
              child: VectorGraphic(
                height: 160,
                loader: AssetBytesLoader(backboneNotAvailable ? 'assets/svg/backbone_error.svg' : 'assets/svg/general_error.svg'),
              ),
            ),
            Gaps.h32,
            Text(
              textAlign: TextAlign.center,
              backboneNotAvailable ? context.l10n.error_backboneNotAvailable_description : context.l10n.error_general,
            ),
            Gaps.h32,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: () async {
                      final result = await launchUrl(Uri.parse('mailto:enmeshed.support@js-soft.com'), mode: LaunchMode.externalApplication);
                      if (!result && context.mounted) {
                        await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            insetPadding: const EdgeInsets.all(24),
                            icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.error),
                            title: Text(context.l10n.error_openMailApp),
                            content: Text(context.l10n.error_openMailApp_description, textAlign: TextAlign.center),
                            actions: [FilledButton(onPressed: () => context.pop(true), child: Text(context.l10n.back))],
                            actionsAlignment: MainAxisAlignment.center,
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondaryContainer)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mail_outline, color: contentColor),
                        Gaps.w8,
                        Text(context.l10n.error_supportButton, style: TextStyle(color: contentColor)),
                      ],
                    ),
                  ),
                  Gaps.h16,
                  FilledButton(onPressed: () => context.go('/splash'), child: Text(context.l10n.tryAgain)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
