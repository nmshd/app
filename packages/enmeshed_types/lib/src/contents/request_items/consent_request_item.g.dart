// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsentRequestItem _$ConsentRequestItemFromJson(Map<String, dynamic> json) => ConsentRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  consent: json['consent'] as String,
  link: json['link'] as String?,
  linkDisplayText: json['linkDisplayText'] as String?,
  requiresInteraction: json['requiresInteraction'] as bool?,
);

Map<String, dynamic> _$ConsentRequestItemToJson(ConsentRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'consent': instance.consent,
  'link': ?instance.link,
  'linkDisplayText': ?instance.linkDisplayText,
  'requiresInteraction': ?instance.requiresInteraction,
};
