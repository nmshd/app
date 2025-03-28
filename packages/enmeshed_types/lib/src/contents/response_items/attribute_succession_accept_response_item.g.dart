// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_succession_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeSuccessionAcceptResponseItem _$AttributeSuccessionAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    AttributeSuccessionAcceptResponseItem(
      predecessorId: json['predecessorId'] as String,
      successorId: json['successorId'] as String,
      successorContent: AbstractAttribute.fromJson(json['successorContent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttributeSuccessionAcceptResponseItemToJson(AttributeSuccessionAcceptResponseItem instance) => <String, dynamic>{
  'predecessorId': instance.predecessorId,
  'successorId': instance.successorId,
  'successorContent': instance.successorContent.toJson(),
};
