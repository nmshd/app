// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationRequestItem _$AuthenticationRequestItemFromJson(Map<String, dynamic> json) => AuthenticationRequestItem(
  title: json['title'] as String,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
);

Map<String, dynamic> _$AuthenticationRequestItemToJson(AuthenticationRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'requireManualDecision': ?instance.requireManualDecision,
  'title': instance.title,
};
