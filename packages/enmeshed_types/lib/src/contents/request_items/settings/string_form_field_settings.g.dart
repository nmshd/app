// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_form_field_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringFormFieldSettings _$StringFormFieldSettingsFromJson(Map<String, dynamic> json) =>
    StringFormFieldSettings(allowNewlines: json['allowNewlines'] as bool?, min: (json['min'] as num?)?.toInt(), max: (json['max'] as num?)?.toInt());

Map<String, dynamic> _$StringFormFieldSettingsToJson(StringFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.allowNewlines case final value?) 'allowNewlines': value,
  if (instance.min case final value?) 'min': value,
  if (instance.max case final value?) 'max': value,
};
