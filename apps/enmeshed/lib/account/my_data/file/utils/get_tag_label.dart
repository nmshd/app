import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

String getTagLabel(BuildContext context, AttributeTagCollectionDTO? tagCollection, AttributeTagDTO tagData) {
  final displayNames = tagData.displayNames;
  final currentLocale = Localizations.localeOf(context).languageCode;

  if (tagCollection != null && tagCollection.supportedLanguages.contains(currentLocale) && displayNames.containsKey(currentLocale)) {
    return displayNames[currentLocale]!;
  }

  // Fallback to English
  return displayNames['en']!;
}
