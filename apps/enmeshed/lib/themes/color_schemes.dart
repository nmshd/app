import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006399),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFCDE5FF),
  onPrimaryContainer: Color(0xFF001D32),
  secondary: Color(0xFF006685),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFBFE9FF),
  onSecondaryContainer: Color(0xFF001F2A),
  tertiary: Color(0xFFA93621),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDAD3),
  onTertiaryContainer: Color(0xFF3E0400),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFF8FDFF),
  onSurface: Color(0xFF001F25),
  surfaceContainer: Color(0xFFEBEEF4),
  surfaceContainerHighest: Color(0xFFDEE3EB),
  surfaceContainerLow: Color(0xFFF1F4F9),
  onSurfaceVariant: Color(0xFF4D5359),
  outline: Color(0xFF72787E),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFF94CCFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006399),
  outlineVariant: Color(0xFFC2C7CF),
  scrim: Color(0xFF000000),
);

NavigationBarThemeData lightNavigationBarTheme = NavigationBarThemeData(
  indicatorColor: lightColorScheme.secondaryContainer,
  surfaceTintColor: lightColorScheme.onPrimary,
  backgroundColor: lightColorScheme.onPrimary,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF94CCFF),
  onPrimary: Color(0xFF003352),
  primaryContainer: Color(0xFF004B74),
  onPrimaryContainer: Color(0xFFCDE5FF),
  secondary: Color(0xFF6DD2FF),
  onSecondary: Color(0xFF003547),
  secondaryContainer: Color(0xFF004D65),
  onSecondaryContainer: Color(0xFFBFE9FF),
  tertiary: Color(0xFFFFB4A5),
  onTertiary: Color(0xFF650B00),
  tertiaryContainer: Color(0xFF881F0B),
  onTertiaryContainer: Color(0xFFFFDAD3),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF001F25),
  onSurface: Color(0xFFA6EEFF),
  surfaceContainer: Color(0xFF1C2024),
  surfaceContainerHighest: Color(0xFF42474E),
  surfaceContainerLow: Color(0xFF181C20),
  onSurfaceVariant: Color(0xFFC2C7CF),
  outline: Color(0xFF8C9198),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF006399),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF94CCFF),
  outlineVariant: Color(0xFF42474E),
  scrim: Color(0xFF000000),
);

NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
  indicatorColor: darkColorScheme.secondaryContainer,
  surfaceTintColor: darkColorScheme.onPrimary,
  backgroundColor: darkColorScheme.onPrimary,
);

const woltThemeData = WoltModalSheetThemeData(topBarShadowColor: Colors.transparent);
