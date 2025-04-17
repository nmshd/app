// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldRequestItem _$FormFieldRequestItemFromJson(Map<String, dynamic> json) => FormFieldRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  title: json['title'] as String,
  settings: FormFieldSettings.fromJson(json['settings'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FormFieldRequestItemToJson(FormFieldRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'title': instance.title,
  'settings': instance.settings.toJson(),
};
