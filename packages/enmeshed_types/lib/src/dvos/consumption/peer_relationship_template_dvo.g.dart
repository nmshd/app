// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_relationship_template_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerRelationshipTemplateDVO _$PeerRelationshipTemplateDVOFromJson(
        Map<String, dynamic> json) =>
    PeerRelationshipTemplateDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null
          ? null
          : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null
          ? null
          : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      isOwn: json['isOwn'] as bool,
      createdBy:
          IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      expiresAt: json['expiresAt'] as String?,
      maxNumberOfAllocations: json['maxNumberOfAllocations'] as int?,
      onNewRelationship: json['onNewRelationship'] == null
          ? null
          : RequestDVO.fromJson(
              json['onNewRelationship'] as Map<String, dynamic>),
      onExistingRelationship: json['onExistingRelationship'] == null
          ? null
          : RequestDVO.fromJson(
              json['onExistingRelationship'] as Map<String, dynamic>),
      request: json['request'] == null
          ? null
          : LocalRequestDVO.fromJson(json['request'] as Map<String, dynamic>),
      content: json['content'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PeerRelationshipTemplateDVOToJson(
        PeerRelationshipTemplateDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'isOwn': instance.isOwn,
      'createdBy': instance.createdBy,
      'createdByDevice': instance.createdByDevice,
      'createdAt': instance.createdAt,
      'expiresAt': instance.expiresAt,
      'maxNumberOfAllocations': instance.maxNumberOfAllocations,
      'onNewRelationship': instance.onNewRelationship,
      'onExistingRelationship': instance.onExistingRelationship,
      'request': instance.request,
      'content': instance.content,
    };
