import 'dart:io';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:feature_flags/feature_flags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../themes/custom_color.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension GetCustomColors on BuildContext {
  CustomColors get customColors => Theme.of(this).extension<CustomColors>()!;
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
