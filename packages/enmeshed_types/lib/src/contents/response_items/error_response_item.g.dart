// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseItem _$ErrorResponseItemFromJson(Map<String, dynamic> json) =>
    ErrorResponseItem(code: json['code'] as String, message: json['message'] as String);

Map<String, dynamic> _$ErrorResponseItemToJson(ErrorResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'code': instance.code,
  'message': instance.message,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
