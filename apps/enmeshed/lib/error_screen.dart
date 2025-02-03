import 'package:enmeshed/core/utils/extensions.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics.dart';

class ErrorScreen extends StatelessWidget {
  final bool backboneNotAvailable;

  const ErrorScreen({required this.backboneNotAvailable, super.key});

  @override
  Widget build(BuildContext context) {
    final contentColor = Theme.of(context).colorScheme.onSecondaryContainer;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.home_title), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                loader: AssetBytesLoader(backboneNotAvailable ? 'assets/svg/backbone_error.svg' : 'assets/svg/general_error.svg'),
                height: 160,
              ),
            ),
            Gaps.h32,
            Text(textAlign: TextAlign.center, context.l10n.error_general),
            Gaps.h24,
            FilledButton(
              onPressed: () => launchUrl(Uri.parse('mailto:enmeshed.support@js-soft.com'), mode: LaunchMode.externalApplication),
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
    );
  }
}
