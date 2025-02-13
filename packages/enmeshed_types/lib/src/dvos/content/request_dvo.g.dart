// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDVO _$RequestDVOFromJson(Map<String, dynamic> json) => RequestDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  expiresAt: json['expiresAt'] as String?,
  items: (json['items'] as List<dynamic>).map((e) => RequestItemDVO.fromJson(e as Map<String, dynamic>)).toList(),
  response: json['response'] == null ? null : ResponseDVO.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RequestDVOToJson(RequestDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  if (instance.expiresAt case final value?) 'expiresAt': value,
  'items': instance.items.map((e) => e.toJson()).toList(),
  if (instance.response?.toJson() case final value?) 'response': value,
};
