import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ThemeModeSetting = ({ThemeMode themeMode, bool amoled});

class ThemeModeModel {
  static const String _themeModeKey = 'theme_mode';
  static const String _amoledKey = 'amoled';

  final SharedPreferences _sharedPreferences;

  final ValueNotifier<ThemeModeSetting> notifier;

  ThemeModeModel._(this._sharedPreferences, {required ThemeModeSetting initialValue}) : notifier = ValueNotifier(initialValue);

  static Future<ThemeModeModel> create() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final themeModeName = sharedPreferences.getString(_themeModeKey) ?? 'system';
    final loadedThemeMode = ThemeMode.values.byName(themeModeName);

    final setting = (themeMode: loadedThemeMode, amoled: false);

    return ThemeModeModel._(sharedPreferences, initialValue: setting);
  }

  void setThemeMode(ThemeMode newThemeMode) {
    notifier.value = (themeMode: newThemeMode, amoled: notifier.value.amoled);
    unawaited(_sharedPreferences.setString(_themeModeKey, newThemeMode.name));
  }

  void setAmoled({required bool amoled}) {
    notifier.value = (themeMode: notifier.value.themeMode, amoled: amoled);
    unawaited(_sharedPreferences.setBool(_amoledKey, amoled));
  }
}
