// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_attribute_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

<<<<<<< HEAD
ShareAttributeRequestItem _$ShareAttributeRequestItemFromJson(Map<String, dynamic> json) => ShareAttributeRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  attribute: AbstractAttribute.fromJson(json['attribute'] as Map<String, dynamic>),
=======
ShareAttributeRequestItem _$ShareAttributeRequestItemFromJson(
  Map<String, dynamic> json,
) => ShareAttributeRequestItem(
  title: json['title'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  attribute: AbstractAttribute.fromJson(
    json['attribute'] as Map<String, dynamic>,
  ),
>>>>>>> d645a5c7 (chore: regenerate files)
  sourceAttributeId: json['sourceAttributeId'] as String,
  thirdPartyAddress: json['thirdPartyAddress'] as String?,
);

Map<String, dynamic> _$ShareAttributeRequestItemToJson(
  ShareAttributeRequestItem instance,
) => <String, dynamic>{
  '@type': instance.atType,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'attribute': instance.attribute.toJson(),
  'sourceAttributeId': instance.sourceAttributeId,
  'thirdPartyAddress': ?instance.thirdPartyAddress,
};
