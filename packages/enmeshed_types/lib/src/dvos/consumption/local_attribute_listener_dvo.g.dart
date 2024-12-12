// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_attribute_listener_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalAttributeListenerDVO _$LocalAttributeListenerDVOFromJson(Map<String, dynamic> json) => LocalAttributeListenerDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      query: AttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
      peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocalAttributeListenerDVOToJson(LocalAttributeListenerDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      'query': instance.query.toJson(),
      'peer': instance.peer.toJson(),
    };
