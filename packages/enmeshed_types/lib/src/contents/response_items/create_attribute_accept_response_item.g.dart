// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_attribute_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAttributeAcceptResponseItem _$CreateAttributeAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    CreateAttributeAcceptResponseItem(attributeId: json['attributeId'] as String);

Map<String, dynamic> _$CreateAttributeAcceptResponseItemToJson(CreateAttributeAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'attributeId': instance.attributeId,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
