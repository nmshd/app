// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsentRequestItem _$ConsentRequestItemFromJson(Map<String, dynamic> json) => ConsentRequestItem(
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
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'consent': instance.consent,
  if (instance.link case final value?) 'link': value,
  if (instance.linkDisplayText case final value?) 'linkDisplayText': value,
};
