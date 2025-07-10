// ignore_for_file: avoid_redundant_argument_values will switch to another

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

import 'themes.dart';

final feedbackLightTheme = FeedbackThemeData(
  colorScheme: lightTheme.colorScheme,
  background: Colors.white,
  dragHandleColor: Colors.black38,
  feedbackSheetColor: const Color(0xFFF5F5F5),
  bottomSheetDescriptionStyle: const TextStyle(color: Colors.black87),
  bottomSheetTextInputStyle: const TextStyle(color: Colors.black87),
  activeFeedbackModeColor: const Color(0xFF2196F3),
  drawColors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
);

final feedbackDarkTheme = FeedbackThemeData(
  colorScheme: darkTheme.colorScheme,
  background: Colors.grey.shade700,
  dragHandleColor: Colors.white38,
  feedbackSheetColor: const Color(0xFF303030),
  bottomSheetDescriptionStyle: const TextStyle(color: Colors.white),
  bottomSheetTextInputStyle: const TextStyle(color: Colors.white),
  activeFeedbackModeColor: const Color(0xFF2196F3),
  drawColors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
);
