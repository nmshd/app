// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propose_attribute_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProposeAttributeAcceptResponseItem _$ProposeAttributeAcceptResponseItemFromJson(Map<String, dynamic> json) => ProposeAttributeAcceptResponseItem(
  attributeId: json['attributeId'] as String,
  attribute: AbstractAttribute.fromJson(json['attribute'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProposeAttributeAcceptResponseItemToJson(ProposeAttributeAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
