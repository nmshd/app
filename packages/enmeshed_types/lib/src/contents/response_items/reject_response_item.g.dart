// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectResponseItem _$RejectResponseItemFromJson(Map<String, dynamic> json) =>
    RejectResponseItem(code: json['code'] as String?, message: json['message'] as String?);

Map<String, dynamic> _$RejectResponseItemToJson(RejectResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'code': ?instance.code,
  'message': ?instance.message,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
