// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integer_form_field_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntegerFormFieldSettings _$IntegerFormFieldSettingsFromJson(Map<String, dynamic> json) =>
    IntegerFormFieldSettings(unit: json['unit'] as String?, min: (json['min'] as num?)?.toInt(), max: (json['max'] as num?)?.toInt());

Map<String, dynamic> _$IntegerFormFieldSettingsToJson(IntegerFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.unit case final value?) 'unit': value,
  if (instance.min case final value?) 'min': value,
  if (instance.max case final value?) 'max': value,
};
