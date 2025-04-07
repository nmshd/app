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
          child: ListView(
            children: [
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
              SwitchListTile(
                title: const Text('AMOLED'),
                value: themeSetting.amoled,
                onChanged: (v) => GetIt.I.get<ThemeModeModel>().setAmoled(amoled: v),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
