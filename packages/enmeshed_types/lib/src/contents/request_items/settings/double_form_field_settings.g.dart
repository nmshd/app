// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_form_field_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleFormFieldSettings _$DoubleFormFieldSettingsFromJson(Map<String, dynamic> json) =>
    DoubleFormFieldSettings(unit: json['unit'] as String?, min: (json['min'] as num?)?.toDouble(), max: (json['max'] as num?)?.toDouble());

Map<String, dynamic> _$DoubleFormFieldSettingsToJson(DoubleFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.unit case final value?) 'unit': value,
  if (instance.min case final value?) 'min': value,
  if (instance.max case final value?) 'max': value,
};
