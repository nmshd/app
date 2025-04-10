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
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'title': instance.title,
};
