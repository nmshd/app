// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityDVO _$IdentityDVOFromJson(Map<String, dynamic> json) => IdentityDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      publicKey: json['publicKey'] as String?,
      initials: json['initials'] as String,
      isSelf: json['isSelf'] as bool,
      hasRelationship: json['hasRelationship'] as bool,
      relationship: json['relationship'] == null ? null : RelationshipDVO.fromJson(json['relationship'] as Map<String, dynamic>),
      originalName: json['originalName'] as String?,
    );

Map<String, dynamic> _$IdentityDVOToJson(IdentityDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      if (instance.publicKey case final value?) 'publicKey': value,
      'initials': instance.initials,
      'isSelf': instance.isSelf,
      'hasRelationship': instance.hasRelationship,
      if (instance.relationship?.toJson() case final value?) 'relationship': value,
      if (instance.originalName case final value?) 'originalName': value,
    };
