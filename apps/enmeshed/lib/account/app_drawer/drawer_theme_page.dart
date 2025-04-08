import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_it/watch_it.dart';

import '/core/core.dart';

class DrawerThemePage extends StatelessWidget with WatchItMixin {
  final VoidCallback goBack;

  const DrawerThemePage({required this.goBack, super.key});

  @override
  Widget build(BuildContext context) {
    final themeSetting = watchValue((ThemeModeModel x) => x.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: goBack),
            Text(
              context.l10n.drawer_notifications,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            const Spacer(),
            IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
          ],
        ),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      // TODO(jkoenig134): translate
                      'Hier können Sie das Erscheinungsbild der App einstellen. Wenn Sie die Einstellung System wählen wird die aktuelle Standardeinstellung Ihres Geräts übernommen.',
                    ),
                  ),
                  RadioListTile(
                    title: const Text('System'),
                    groupValue: themeSetting.themeMode,
                    value: ThemeMode.system,
                    onChanged: (v) => GetIt.I.get<ThemeModeModel>().setThemeMode(ThemeMode.system),
                  ),
                  RadioListTile(
                    title: const Text('Light'),
                    groupValue: themeSetting.themeMode,
                    value: ThemeMode.light,
                    onChanged: (v) => GetIt.I.get<ThemeModeModel>().setThemeMode(ThemeMode.light),
                  ),
                  RadioListTile(
                    title: const Text('Dark'),
                    groupValue: themeSetting.themeMode,
                    value: ThemeMode.dark,
                    onChanged: (v) => GetIt.I.get<ThemeModeModel>().setThemeMode(ThemeMode.dark),
                  ),
                  Gaps.h8,
                  SwitchListTile(
                    title: const Text('AMOLED'),
                    secondary: const Icon(Icons.nightlight_round),
                    value: themeSetting.amoled,
                    onChanged: (v) => GetIt.I.get<ThemeModeModel>().setAmoled(amoled: v),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      // TODO(jkoenig134): translate
                      'Der AMOLED-Modus hilft Energie zu sparen indem Pixel, die auf schwarz gesetzt sind, vollständig abgeschaltet werden. Diese Einstellung hat nur Einfluss auf das dunkle Erscheinungsbild.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
