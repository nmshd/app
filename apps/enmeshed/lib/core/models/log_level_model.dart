import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogLevelModel {
  static const String _logLevelKey = 'log_level';

  final SharedPreferences _sharedPreferences;

  final ValueNotifier<Level> notifier;
  final LogFilter logFilter;

  LogLevelModel._(this._sharedPreferences, {required Level initialValue, required this.logFilter}) : notifier = ValueNotifier(initialValue);

  static Future<LogLevelModel> create(LogFilter logFilter) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final logLevelName = sharedPreferences.getString(_logLevelKey);
    if (logLevelName == null) return LogLevelModel._(sharedPreferences, logFilter: logFilter, initialValue: logFilter.level ?? Level.info);

    final loadedLogLevel = Level.values.byName(logLevelName);
    return LogLevelModel._(sharedPreferences, logFilter: logFilter, initialValue: loadedLogLevel);
  }

  void setLogLevel(Level newLogLevel) {
    notifier.value = newLogLevel;
    unawaited(_sharedPreferences.setString(_logLevelKey, newLogLevel.name));
    logFilter.level = newLogLevel;
  }
}
