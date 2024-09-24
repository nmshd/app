import 'package:croppy/croppy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CroppyLocalizationsDelegate extends LocalizationsDelegate<CroppyLocalizations> {
  @override
  bool isSupported(Locale locale) => [...CroppyLocalizations.supportedLocales, const Locale('de')].contains(locale);

  @override
  Future<CroppyLocalizations> load(Locale locale) {
    if (locale.languageCode == 'de') {
      return SynchronousFuture(CroppyLocalizationsDe());
    }

    return SynchronousFuture(lookupCroppyLocalizations(locale));
  }

  @override
  bool shouldReload(CroppyLocalizationsDelegate old) => false;
}

class CroppyLocalizationsDe extends CroppyLocalizations {
  CroppyLocalizationsDe() : super('de');

  @override
  String get cancelLabel => 'Abbrechen';

  @override
  String get cupertinoFreeformAspectRatioLabel => 'FREIFORM';

  @override
  String get cupertinoOriginalAspectRatioLabel => 'ORIGINAL';

  @override
  String get cupertinoResetLabel => 'ZURÜCKSETZEN';

  @override
  String get cupertinoSquareAspectRatioLabel => 'QUADRAT';

  @override
  String get doneLabel => 'Fertig';

  @override
  String get materialFreeformAspectRatioLabel => 'Freiform';

  @override
  String materialGetFlipLabel(LocalizationDirection direction) => '${direction == LocalizationDirection.vertical ? 'Vertikal' : 'Horizontal'} drehen';

  @override
  String get materialOriginalAspectRatioLabel => 'Original';

  @override
  String get materialResetLabel => 'Zurücksetzen';

  @override
  String get materialSquareAspectRatioLabel => 'Quadrat';

  @override
  String get saveLabel => 'Speichern';
}
