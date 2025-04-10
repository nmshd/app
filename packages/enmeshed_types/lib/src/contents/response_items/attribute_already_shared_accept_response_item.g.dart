// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_already_shared_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeAlreadySharedAcceptResponseItem _$AttributeAlreadySharedAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    AttributeAlreadySharedAcceptResponseItem(attributeId: json['attributeId'] as String);

Map<String, dynamic> _$AttributeAlreadySharedAcceptResponseItemToJson(AttributeAlreadySharedAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'attributeId': instance.attributeId,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
