// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_item_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestItemGroup _$RequestItemGroupFromJson(Map<String, dynamic> json) =>
    RequestItemGroup(
      title: json['title'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      items: (json['items'] as List<dynamic>)
          .map((e) => RequestItemDerivation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestItemGroupToJson(RequestItemGroup instance) => <String, dynamic>{
  '@type': instance.atType,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'title': ?instance.title,
  'items': instance.items.map((e) => e.toJson()).toList(),
};
