// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldSettings _$FormFieldSettingsFromJson(Map<String, dynamic> json) => FormFieldSettings(atType: json['@type'] as String);

Map<String, dynamic> _$FormFieldSettingsToJson(FormFieldSettings instance) => <String, dynamic>{'@type': instance.atType};

StringFormFieldSettings _$StringFormFieldSettingsFromJson(Map<String, dynamic> json) =>
    StringFormFieldSettings(allowNewlines: json['allowNewlines'] as bool?, min: (json['min'] as num?)?.toInt(), max: (json['max'] as num?)?.toInt());

Map<String, dynamic> _$StringFormFieldSettingsToJson(StringFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.allowNewlines case final value?) 'allowNewlines': value,
  if (instance.min case final value?) 'min': value,
  if (instance.max case final value?) 'max': value,
};

IntegerFormFieldSettings _$IntegerFormFieldSettingsFromJson(Map<String, dynamic> json) =>
    IntegerFormFieldSettings(unit: json['unit'] as String?, min: (json['min'] as num?)?.toInt(), max: (json['max'] as num?)?.toInt());

Map<String, dynamic> _$IntegerFormFieldSettingsToJson(IntegerFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.unit case final value?) 'unit': value,
  if (instance.min case final value?) 'min': value,
  if (instance.max case final value?) 'max': value,
};

DoubleFormFieldSettings _$DoubleFormFieldSettingsFromJson(Map<String, dynamic> json) =>
    DoubleFormFieldSettings(unit: json['unit'] as String?, min: (json['min'] as num?)?.toDouble(), max: (json['max'] as num?)?.toDouble());

Map<String, dynamic> _$DoubleFormFieldSettingsToJson(DoubleFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.unit case final value?) 'unit': value,
  if (instance.min case final value?) 'min': value,
  if (instance.max case final value?) 'max': value,
};

BooleanFormFieldSettings _$BooleanFormFieldSettingsFromJson(Map<String, dynamic> json) => BooleanFormFieldSettings();

Map<String, dynamic> _$BooleanFormFieldSettingsToJson(BooleanFormFieldSettings instance) => <String, dynamic>{'@type': instance.atType};

DateFormFieldSettings _$DateFormFieldSettingsFromJson(Map<String, dynamic> json) => DateFormFieldSettings();

Map<String, dynamic> _$DateFormFieldSettingsToJson(DateFormFieldSettings instance) => <String, dynamic>{'@type': instance.atType};

RatingFormFieldSettings _$RatingFormFieldSettingsFromJson(Map<String, dynamic> json) =>
    RatingFormFieldSettings(maxRating: (json['maxRating'] as num).toInt());

Map<String, dynamic> _$RatingFormFieldSettingsToJson(RatingFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  'maxRating': instance.maxRating,
};

SelectionFormFieldSettings _$SelectionFormFieldSettingsFromJson(Map<String, dynamic> json) => SelectionFormFieldSettings(
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  allowMultipleSelection: json['allowMultipleSelection'] as bool?,
);

Map<String, dynamic> _$SelectionFormFieldSettingsToJson(SelectionFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  'options': instance.options,
  if (instance.allowMultipleSelection case final value?) 'allowMultipleSelection': value,
};
