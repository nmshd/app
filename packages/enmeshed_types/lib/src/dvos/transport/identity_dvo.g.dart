// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityDVO _$IdentityDVOFromJson(Map<String, dynamic> json) => IdentityDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      publicKey: json['publicKey'] as String?,
      realm: json['realm'] as String,
      initials: json['initials'] as String,
      isSelf: json['isSelf'] as bool,
      hasRelationship: json['hasRelationship'] as bool,
      relationship: json['relationship'] == null ? null : RelationshipDVO.fromJson(json['relationship'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IdentityDVOToJson(IdentityDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'publicKey': instance.publicKey,
      'realm': instance.realm,
      'initials': instance.initials,
      'isSelf': instance.isSelf,
      'hasRelationship': instance.hasRelationship,
      'relationship': instance.relationship,
    };
