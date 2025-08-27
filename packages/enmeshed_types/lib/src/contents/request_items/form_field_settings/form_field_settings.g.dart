// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanFormFieldSettings _$BooleanFormFieldSettingsFromJson(
  Map<String, dynamic> json,
) => BooleanFormFieldSettings();

Map<String, dynamic> _$BooleanFormFieldSettingsToJson(
  BooleanFormFieldSettings instance,
) => <String, dynamic>{'@type': instance.atType};

DateFormFieldSettings _$DateFormFieldSettingsFromJson(
  Map<String, dynamic> json,
) => DateFormFieldSettings();

Map<String, dynamic> _$DateFormFieldSettingsToJson(
  DateFormFieldSettings instance,
) => <String, dynamic>{'@type': instance.atType};

DoubleFormFieldSettings _$DoubleFormFieldSettingsFromJson(
  Map<String, dynamic> json,
) => DoubleFormFieldSettings(
  unit: json['unit'] as String?,
  min: (json['min'] as num?)?.toDouble(),
  max: (json['max'] as num?)?.toDouble(),
);

Map<String, dynamic> _$DoubleFormFieldSettingsToJson(
  DoubleFormFieldSettings instance,
) => <String, dynamic>{
  '@type': instance.atType,
  'unit': ?instance.unit,
  'min': ?instance.min,
  'max': ?instance.max,
};

IntegerFormFieldSettings _$IntegerFormFieldSettingsFromJson(
  Map<String, dynamic> json,
) => IntegerFormFieldSettings(
  unit: json['unit'] as String?,
  min: (json['min'] as num?)?.toInt(),
  max: (json['max'] as num?)?.toInt(),
);

Map<String, dynamic> _$IntegerFormFieldSettingsToJson(
  IntegerFormFieldSettings instance,
) => <String, dynamic>{
  '@type': instance.atType,
  'unit': ?instance.unit,
  'min': ?instance.min,
  'max': ?instance.max,
};

RatingFormFieldSettings _$RatingFormFieldSettingsFromJson(
  Map<String, dynamic> json,
) => RatingFormFieldSettings(maxRating: (json['maxRating'] as num).toInt());

Map<String, dynamic> _$RatingFormFieldSettingsToJson(
  RatingFormFieldSettings instance,
) => <String, dynamic>{
  '@type': instance.atType,
  'maxRating': instance.maxRating,
};

SelectionFormFieldSettings _$SelectionFormFieldSettingsFromJson(
  Map<String, dynamic> json,
) => SelectionFormFieldSettings(
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  allowMultipleSelection: json['allowMultipleSelection'] as bool?,
);

Map<String, dynamic> _$SelectionFormFieldSettingsToJson(
  SelectionFormFieldSettings instance,
) => <String, dynamic>{
  '@type': instance.atType,
  'options': instance.options,
  'allowMultipleSelection': ?instance.allowMultipleSelection,
};

StringFormFieldSettings _$StringFormFieldSettingsFromJson(
  Map<String, dynamic> json,
) => StringFormFieldSettings(
  allowNewlines: json['allowNewlines'] as bool?,
  min: (json['min'] as num?)?.toInt(),
  max: (json['max'] as num?)?.toInt(),
);

Map<String, dynamic> _$StringFormFieldSettingsToJson(
  StringFormFieldSettings instance,
) => <String, dynamic>{
  '@type': instance.atType,
  'allowNewlines': ?instance.allowNewlines,
  'min': ?instance.min,
  'max': ?instance.max,
};
