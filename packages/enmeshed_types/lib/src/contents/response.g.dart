// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
  result: $enumDecode(_$ResponseResultEnumMap, json['result']),
  requestId: json['requestId'] as String,
  items: (json['items'] as List<dynamic>).map((e) => ResponseItem.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseResultEnumMap[instance.result]!,
  'requestId': instance.requestId,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

const _$ResponseResultEnumMap = {ResponseResult.Accepted: 'Accepted', ResponseResult.Rejected: 'Rejected'};
