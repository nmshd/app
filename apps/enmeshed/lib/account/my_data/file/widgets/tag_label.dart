import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '/core/core.dart';

class TagLabel extends StatelessWidget {
  final String label;
  final TextStyle? style;

  const TagLabel(this.label, {this.style, super.key});

  @override
  Widget build(BuildContext context) {
    if (label.startsWith('language:')) {
      return TranslatedText(context.i18nTranslate('i18n://attributes.values.languages.${label.substring(9)}'), style: style);
    }

    final i18nTranslatable = 'i18n://tags.${label.replaceAll('.', '%')}';
    final translatedLabel = context.i18nTranslate(i18nTranslatable);

    if (!translatedLabel.startsWith('tags') && translatedLabel != i18nTranslatable) return Text(translatedLabel, style: style);

    return Text(label, style: style);
  }
}
