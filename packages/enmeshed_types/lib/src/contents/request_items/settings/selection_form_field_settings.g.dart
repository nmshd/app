// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection_form_field_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectionFormFieldSettings _$SelectionFormFieldSettingsFromJson(Map<String, dynamic> json) => SelectionFormFieldSettings(
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  allowMultipleSelection: json['allowMultipleSelection'] as bool?,
);

Map<String, dynamic> _$SelectionFormFieldSettingsToJson(SelectionFormFieldSettings instance) => <String, dynamic>{
  '@type': instance.atType,
  'options': instance.options,
  if (instance.allowMultipleSelection case final value?) 'allowMultipleSelection': value,
};
