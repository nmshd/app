// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsentRequestItem _$ConsentRequestItemFromJson(Map<String, dynamic> json) => ConsentRequestItem(
  title: json['title'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  consent: json['consent'] as String,
  link: json['link'] as String?,
  linkDisplayText: json['linkDisplayText'] as String?,
);

Map<String, dynamic> _$ConsentRequestItemToJson(ConsentRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'title': ?instance.title,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'requireManualDecision': ?instance.requireManualDecision,
  'consent': instance.consent,
  'link': ?instance.link,
  'linkDisplayText': ?instance.linkDisplayText,
};
