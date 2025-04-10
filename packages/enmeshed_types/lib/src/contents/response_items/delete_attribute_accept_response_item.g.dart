// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_attribute_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAttributeAcceptResponseItem _$DeleteAttributeAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    DeleteAttributeAcceptResponseItem(deletionDate: json['deletionDate'] as String);

Map<String, dynamic> _$DeleteAttributeAcceptResponseItemToJson(DeleteAttributeAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'deletionDate': instance.deletionDate,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
