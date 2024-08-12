import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '/core/core.dart';

class AppDrawer extends StatelessWidget {
  final String accountName;
  final String accountId;
  final VoidCallback activateHints;

  const AppDrawer({
    required this.accountName,
    required this.accountId,
    required this.activateHints,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      context.l10n.drawer_informationAndHelp,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                  ListTile(
                    onTap: activateHints,
                    title: Text(context.l10n.drawer_hints, style: Theme.of(context).textTheme.labelLarge),
                  ),
                  if (context.isFeatureEnabled('NEWS'))
                    ListTile(
                      onTap: () => showNotImplementedDialog(context),
                      title: Text(context.l10n.drawer_news, style: Theme.of(context).textTheme.labelLarge),
                    ),
                  if (context.isFeatureEnabled('HELP_AND_FAQ'))
                    ListTile(
                      onTap: () => showNotImplementedDialog(context),
                      title: Text(context.l10n.drawer_helpAndFaq, style: Theme.of(context).textTheme.labelLarge),
                    ),
                  const Divider(indent: 16, endIndent: 16),
                  ListTile(
                    onTap: () => context
                      ..pop()
                      ..push('/legal-notice'),
                    title: Text(context.l10n.legalNotice, style: Theme.of(context).textTheme.labelLarge),
                  ),
                  ListTile(
                    onTap: () => context
                      ..pop()
                      ..push('/data-protection'),
                    title: Text(context.l10n.dataProtection, style: Theme.of(context).textTheme.labelLarge),
                  ),
                  ListTile(
                    onTap: () => context
                      ..pop()
                      ..push('/imprint'),
                    title: Text(context.l10n.imprint, style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: FutureBuilder(
                            builder: (ctx, snap) => Text(
                              'App Version\n${snap.hasData ? snap.data : '...'}',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
                              textAlign: TextAlign.center,
                            ),
                            future: PackageInfo.fromPlatform().then((info) => info.version),
                          ),
                          onTap: () => _AppDrawerEasterEgg.tap(context),
                        ),
                        Text(
                          'Runtime Version\n${GetIt.I.get<EnmeshedRuntime>().runtimeVersion}',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppDrawerEasterEgg {
  static int taps = 0;
  static DateTime? lastTap;

  static void tap(BuildContext context) {
    if (lastTap == null || DateTime.now().difference(lastTap!) <= const Duration(seconds: 1)) {
      taps++;
    } else {
      taps = 0;
    }

    if (taps >= 10) {
      context
        ..pop()
        ..push('/debug');

      taps = 0;
      lastTap = null;

      return;
    }

    lastTap = DateTime.now();
  }
}
