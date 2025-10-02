// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_attribute_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareAttributeAcceptResponseItem _$ShareAttributeAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    ShareAttributeAcceptResponseItem(attributeId: json['attributeId'] as String);

Map<String, dynamic> _$ShareAttributeAcceptResponseItemToJson(ShareAttributeAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'attributeId': instance.attributeId,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
