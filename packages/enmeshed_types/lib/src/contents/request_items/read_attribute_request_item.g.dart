// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_attribute_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadAttributeRequestItem _$ReadAttributeRequestItemFromJson(Map<String, dynamic> json) => ReadAttributeRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  query: AttributeQuery.fromJson(json['query'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ReadAttributeRequestItemToJson(ReadAttributeRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'query': instance.query.toJson(),
};
