import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'custom_colors.dart';
import 'text_styles.dart';

const _primarySeedColor = Color(0xFF17428D);
const _secondarySeedColor = Color(0xFF1A80D9);
const _tertiarySeedColor = Color(0xFFFF7600);
const _errorSeedColor = Color(0xFF8C1742);

final ThemeData lightTheme = _generateColorScheme(
  tonesConstructor: FlexTones.material,
  brightness: Brightness.light,
  customColors: lightCustomColors,
);
final ThemeData darkTheme = _generateColorScheme(tonesConstructor: FlexTones.material, brightness: Brightness.dark, customColors: darkCustomColors);
final ThemeData amoledTheme = _generateColorScheme(
  tonesConstructor: FlexTones.material,
  brightness: Brightness.dark,
  customColors: darkCustomColors,
  lightsOut: true,
);

final ThemeData highContrastTheme = _generateColorScheme(
  tonesConstructor: FlexTones.ultraContrast,
  brightness: Brightness.light,
  customColors: lightHighContrastCustomColors,
);
final ThemeData highContrastDarkTheme = _generateColorScheme(
  tonesConstructor: FlexTones.ultraContrast,
  brightness: Brightness.dark,
  customColors: darkHighContrastCustomColors,
);

ThemeData _generateColorScheme({
  required FlexTones Function(Brightness brightness) tonesConstructor,
  required Brightness brightness,
  required ThemeExtension<dynamic> customColors,
  bool lightsOut = false,
}) {
  assert(!lightsOut || brightness == Brightness.dark, 'lightsOut can only be used with dark theme');

  final colorScheme = SeedColorScheme.fromSeeds(
    brightness: brightness,
    primaryKey: _primarySeedColor,
    secondaryKey: _secondarySeedColor,
    tertiaryKey: _tertiarySeedColor,
    errorKey: _errorSeedColor,
    surface: lightsOut ? Colors.black : null,
    tones: tonesConstructor(brightness),
  );

  final appBarTheme = AppBarTheme(titleTextStyle: textTheme.titleLarge!.copyWith(color: colorScheme.primary), titleSpacing: 6, centerTitle: false);

  return ThemeData(
    colorScheme: colorScheme,
    extensions: [customColors],
    navigationBarTheme: NavigationBarThemeData(backgroundColor: colorScheme.surface),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: colorScheme.primary, foregroundColor: colorScheme.onPrimary),
    appBarTheme: appBarTheme,
    cardTheme: const CardThemeData(elevation: 0),
    textTheme: textTheme,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    // ignore: deprecated_member_use seems like this is deprecated despite it will be the default in the future
    progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
  );
}
