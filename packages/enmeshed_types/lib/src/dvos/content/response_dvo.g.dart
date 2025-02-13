// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDVO _$ResponseDVOFromJson(Map<String, dynamic> json) => ResponseDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  items: (json['items'] as List<dynamic>).map((e) => ResponseItemDVO.fromJson(e as Map<String, dynamic>)).toList(),
  result: $enumDecode(_$ResponseResultEnumMap, json['result']),
);

Map<String, dynamic> _$ResponseDVOToJson(ResponseDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'result': _$ResponseResultEnumMap[instance.result]!,
};

const _$ResponseResultEnumMap = {ResponseResult.Accepted: 'Accepted', ResponseResult.Rejected: 'Rejected'};
