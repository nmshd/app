// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_attribute_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareAttributeRequestItem _$ShareAttributeRequestItemFromJson(Map<String, dynamic> json) => ShareAttributeRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  attribute: AbstractAttribute.fromJson(json['attribute'] as Map<String, dynamic>),
  sourceAttributeId: json['sourceAttributeId'] as String,
  thirdPartyAddress: json['thirdPartyAddress'] as String?,
);

Map<String, dynamic> _$ShareAttributeRequestItemToJson(ShareAttributeRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'attribute': instance.attribute.toJson(),
  'sourceAttributeId': instance.sourceAttributeId,
  if (instance.thirdPartyAddress case final value?) 'thirdPartyAddress': value,
};
