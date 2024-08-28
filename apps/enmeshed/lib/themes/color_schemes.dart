import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

const primarySeedColor = Color(0xFF17428D);
const secondarySeedColor = Color(0xFF1A80D9);
const tertiarySeedColor = Color(0xFFFF7600);
const errorSeedColor = Color(0xFF8C1742);

final lightColorScheme = SeedColorScheme.fromSeeds(
  primaryKey: primarySeedColor,
  primary: primarySeedColor,
  secondaryKey: secondarySeedColor,
  secondary: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tertiary: tertiarySeedColor,
  errorKey: errorSeedColor,
  error: errorSeedColor,
  tones: FlexTones.material(Brightness.light),
);

final darkColorScheme = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  errorKey: errorSeedColor,
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

NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
  indicatorColor: darkColorScheme.secondaryContainer,
  surfaceTintColor: darkColorScheme.onPrimary,
  backgroundColor: darkColorScheme.onPrimary,
  iconTheme: WidgetStateProperty.resolveWith(
    (states) => IconThemeData(color: states.contains(WidgetState.selected) ? darkColorScheme.primary : darkColorScheme.onSurfaceVariant),
  ),
);

const woltThemeData = WoltModalSheetThemeData(topBarShadowColor: Colors.transparent);
