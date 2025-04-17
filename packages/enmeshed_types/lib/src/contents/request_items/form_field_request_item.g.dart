// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldRequestItem _$FormFieldRequestItemFromJson(Map<String, dynamic> json) => FormFieldRequestItem(
  title: json['title'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  settings: FormFieldSettingsDerivation.fromJson(json['settings'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FormFieldRequestItemToJson(FormFieldRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.title case final value?) 'title': value,
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'settings': instance.settings.toJson(),
};
