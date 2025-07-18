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
  'id': ?instance.id,
  'expiresAt': ?instance.expiresAt,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'title': ?instance.title,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
};
