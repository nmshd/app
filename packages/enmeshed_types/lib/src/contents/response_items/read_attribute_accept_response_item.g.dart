// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_attribute_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadAttributeAcceptResponseItem _$ReadAttributeAcceptResponseItemFromJson(Map<String, dynamic> json) => ReadAttributeAcceptResponseItem(
  attributeId: json['attributeId'] as String,
  attribute: AbstractAttribute.fromJson(json['attribute'] as Map<String, dynamic>),
  thirdPartyAddress: json['thirdPartyAddress'] as String?,
);

Map<String, dynamic> _$ReadAttributeAcceptResponseItemToJson(ReadAttributeAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
  if (instance.thirdPartyAddress case final value?) 'thirdPartyAddress': value,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
