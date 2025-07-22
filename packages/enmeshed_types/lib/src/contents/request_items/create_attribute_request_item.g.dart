// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_attribute_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAttributeRequestItem _$CreateAttributeRequestItemFromJson(Map<String, dynamic> json) => CreateAttributeRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  attribute: AbstractAttribute.fromJson(json['attribute'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateAttributeRequestItemToJson(CreateAttributeRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'requireManualDecision': ?instance.requireManualDecision,
  'attribute': instance.attribute.toJson(),
};
