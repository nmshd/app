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
  '@type': instance.atType,
  'title': ?instance.title,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'requireManualDecision': ?instance.requireManualDecision,
  'freeText': instance.freeText,
};
