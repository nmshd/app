// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propose_attribute_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProposeAttributeRequestItem _$ProposeAttributeRequestItemFromJson(Map<String, dynamic> json) => ProposeAttributeRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  query: AttributeQuery.fromJson(json['query'] as Map<String, dynamic>),
  attribute: AbstractAttribute.fromJson(json['attribute'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProposeAttributeRequestItemToJson(ProposeAttributeRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'query': instance.query.toJson(),
  'attribute': instance.attribute.toJson(),
};
