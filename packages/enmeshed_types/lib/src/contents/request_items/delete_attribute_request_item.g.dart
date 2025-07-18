// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_attribute_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAttributeRequestItem _$DeleteAttributeRequestItemFromJson(Map<String, dynamic> json) => DeleteAttributeRequestItem(
  title: json['title'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  attributeId: json['attributeId'] as String,
);

Map<String, dynamic> _$DeleteAttributeRequestItemToJson(DeleteAttributeRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'title': ?instance.title,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'requireManualDecision': ?instance.requireManualDecision,
  'attributeId': instance.attributeId,
};
