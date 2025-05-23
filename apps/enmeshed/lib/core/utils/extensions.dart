import 'dart:io';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:feature_flags/feature_flags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../generated/l10n/app_localizations.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension I18nTranslationExtension on BuildContext {
  String i18nTranslate(String string) => string.startsWith('i18n://') ? FlutterI18n.translate(this, string.substring(7)) : string;
}

extension AdaptiveBackIconExtension on BuildContext {
  IconData get adaptiveBackIcon => switch (Theme.of(this).platform) {
    TargetPlatform.android || TargetPlatform.fuchsia || TargetPlatform.linux || TargetPlatform.windows => Icons.arrow_back,
    TargetPlatform.iOS || TargetPlatform.macOS => Icons.arrow_back_ios_new,
  };
}

extension CacheFile on FileDVO {
  File getCacheFile(Directory cacheDir) => File('${cacheDir.path}/files/$id/$filename');
}

extension FeatureFlagging on BuildContext {
  bool isFeatureEnabled(String feature) => kDebugMode && Features.isFeatureEnabled(this, feature);

  bool get showTechnicalMessages => isFeatureEnabled('SHOW_TECHNICAL_MESSAGES');
}

extension Separated<T extends Widget> on Iterable<T> {
  List<Widget> separated(Widget Function() separator) {
    final widgets = <Widget>[];

    for (final widget in indexed) {
      widgets.add(widget.$2);
      if (widget.$1 != length - 1) widgets.add(separator());
    }

    return widgets;
  }
}

extension IsUnknown on IdentityDVO {
  bool get isUnknown => name == unknownContactName;
}

extension Toggle<T> on Set<T> {
  void toggle(T value) {
    contains(value) ? remove(value) : add(value);
  }
}

extension IsDefaultRepositoryAttribute on LocalAttributeDVO {
  bool get isDefaultRepositoryAttribute => this is RepositoryAttributeDVO && ((this as RepositoryAttributeDVO).isDefault ?? false);
}

extension DateType on DateTime {
  String get dateType {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (year == today.year && month == today.month && day == today.day) {
      return 'today';
    } else if (year == yesterday.year && month == yesterday.month && day == yesterday.day) {
      return 'yesterday';
    } else {
      return 'other';
    }
  }
}
