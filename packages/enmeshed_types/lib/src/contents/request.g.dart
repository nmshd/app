// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
  id: json['id'] as String?,
  expiresAt: json['expiresAt'] as String?,
  items: (json['items'] as List<dynamic>).map((e) => RequestItem.fromJson(e as Map<String, dynamic>)).toList(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.id case final value?) 'id': value,
  if (instance.expiresAt case final value?) 'expiresAt': value,
  'items': instance.items.map((e) => e.toJson()).toList(),
  if (instance.title case final value?) 'title': value,
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
};
