// ignore_for_file: avoid_redundant_argument_values will switch to another

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

import 'themes.dart';

final feedbackLightTheme = FeedbackThemeData(
  colorScheme: lightTheme.colorScheme,
  background: lightTheme.colorScheme.onSurface,
  feedbackSheetColor: lightTheme.colorScheme.surface,
  bottomSheetDescriptionStyle: TextStyle(color: lightTheme.colorScheme.onSurface),
  bottomSheetTextInputStyle: TextStyle(color: lightTheme.colorScheme.onSurface),
  dragHandleColor: lightTheme.colorScheme.onSurfaceVariant,
  activeFeedbackModeColor: lightTheme.colorScheme.primary,
  drawColors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
);

final feedbackDarkTheme = FeedbackThemeData(
  colorScheme: darkTheme.colorScheme,
  background: darkTheme.colorScheme.onSurface,
  feedbackSheetColor: darkTheme.colorScheme.surface,
  bottomSheetDescriptionStyle: TextStyle(color: darkTheme.colorScheme.onSurface),
  bottomSheetTextInputStyle: TextStyle(color: darkTheme.colorScheme.onSurface),
  dragHandleColor: darkTheme.colorScheme.onSurfaceVariant,
  activeFeedbackModeColor: darkTheme.colorScheme.primary,
  drawColors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
);
