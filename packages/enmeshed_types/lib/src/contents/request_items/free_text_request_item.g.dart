// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_text_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeTextRequestItem _$FreeTextRequestItemFromJson(Map<String, dynamic> json) => FreeTextRequestItem(
  title: json['title'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  freeText: json['freeText'] as String,
);

Map<String, dynamic> _$FreeTextRequestItemToJson(FreeTextRequestItem instance) => <String, dynamic>{
  if (instance.title case final value?) 'title': value,
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'freeText': instance.freeText,
};
