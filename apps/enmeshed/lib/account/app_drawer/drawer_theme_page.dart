import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_it/watch_it.dart';

import '/core/core.dart';

class DrawerThemePage extends StatefulWidget with WatchItStatefulWidgetMixin {
  final VoidCallback goBack;

  const DrawerThemePage({required this.goBack, super.key});

  @override
  State<DrawerThemePage> createState() => _DrawerThemePageState();
}

class _DrawerThemePageState extends State<DrawerThemePage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(32));
    final themeSetting = watchValue((ThemeModeModel x) => x.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.goBack),
            Text(
              context.l10n.drawer_theme,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            const Spacer(),
            IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
          ],
        ),
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(16), child: Text(context.l10n.drawer_theme_description)),
                  RadioListTile(
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                    title: Text(context.l10n.drawer_theme_modes_system),
                    groupValue: themeSetting.themeMode,
                    value: ThemeMode.system,
                    onChanged: (v) => GetIt.I.get<ThemeModeModel>().setThemeMode(ThemeMode.system),
                  ),
                  RadioListTile(
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                    title: Text(context.l10n.drawer_theme_modes_light),
                    groupValue: themeSetting.themeMode,
                    value: ThemeMode.light,
                    onChanged: (v) => GetIt.I.get<ThemeModeModel>().setThemeMode(ThemeMode.light),
                  ),
                  RadioListTile(
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                    title: Text(context.l10n.drawer_theme_modes_dark),
                    groupValue: themeSetting.themeMode,
                    value: ThemeMode.dark,
                    onChanged: (v) => GetIt.I.get<ThemeModeModel>().setThemeMode(ThemeMode.dark),
                  ),
                  Gaps.h8,
                  SwitchListTile(
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                    title: const Text('AMOLED'),
                    value: themeSetting.amoled,
                    onChanged: (v) => GetIt.I.get<ThemeModeModel>().setAmoled(amoled: v),
                  ),
                  Padding(padding: const EdgeInsets.all(16), child: Text(context.l10n.drawer_theme_amoled)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
