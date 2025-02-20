import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'text_styles.dart';

const _primarySeedColor = Color(0xFF17428D);
const _secondarySeedColor = Color(0xFF1A80D9);
const _tertiarySeedColor = Color(0xFFFF7600);
const _errorSeedColor = Color(0xFF8C1742);

final lightColorScheme = SeedColorScheme.fromSeeds(
  primaryKey: _primarySeedColor,
  primary: _primarySeedColor,
  secondaryKey: _secondarySeedColor,
  secondary: _secondarySeedColor,
  tertiaryKey: _tertiarySeedColor,
  tertiary: _tertiarySeedColor,
  errorKey: _errorSeedColor,
  error: _errorSeedColor,
  tones: FlexTones.material(Brightness.light),
);

final darkColorScheme = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: _primarySeedColor,
  primaryContainer: _primarySeedColor,
  secondaryKey: _secondarySeedColor,
  secondaryContainer: _secondarySeedColor,
  tertiaryKey: _tertiarySeedColor,
  tertiaryContainer: _tertiarySeedColor,
  errorKey: _errorSeedColor,
  errorContainer: _errorSeedColor,
  tones: FlexTones.material(Brightness.dark),
);

NavigationBarThemeData lightNavigationBarTheme = NavigationBarThemeData(
  indicatorColor: lightColorScheme.secondaryContainer,
  surfaceTintColor: lightColorScheme.onPrimary,
  backgroundColor: lightColorScheme.onPrimary,
  iconTheme: WidgetStateProperty.resolveWith(
    (states) => IconThemeData(color: states.contains(WidgetState.selected) ? lightColorScheme.primary : lightColorScheme.onSurfaceVariant),
  ),
);

AppBarTheme lightAppBarTheme = AppBarTheme(
  titleTextStyle: textTheme.titleLarge!.copyWith(color: lightColorScheme.primary),
  titleSpacing: 6,
  centerTitle: false,
);

NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
  indicatorColor: darkColorScheme.secondaryContainer,
  surfaceTintColor: darkColorScheme.onPrimary,
  backgroundColor: darkColorScheme.onPrimary,
  iconTheme: WidgetStateProperty.resolveWith(
    (states) => IconThemeData(color: states.contains(WidgetState.selected) ? darkColorScheme.primary : darkColorScheme.onSurfaceVariant),
  ),
);

AppBarTheme darkAppBarTheme = AppBarTheme(
  titleTextStyle: textTheme.titleLarge!.copyWith(color: darkColorScheme.primary),
  titleSpacing: 6,
  centerTitle: false,
);
