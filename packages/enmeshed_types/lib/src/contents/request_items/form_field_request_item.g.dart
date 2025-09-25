// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldRequestItem _$FormFieldRequestItemFromJson(Map<String, dynamic> json) => FormFieldRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  title: json['title'] as String,
  settings: FormFieldSettings.fromJson(json['settings'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FormFieldRequestItemToJson(FormFieldRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'title': instance.title,
  'settings': instance.settings.toJson(),
};
