// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_relationship_template_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerRelationshipTemplateDVO _$PeerRelationshipTemplateDVOFromJson(Map<String, dynamic> json) => PeerRelationshipTemplateDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      isOwn: json['isOwn'] as bool,
      createdBy: IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      expiresAt: json['expiresAt'] as String?,
      maxNumberOfAllocations: const OptionalIntegerConverter().fromJson(json['maxNumberOfAllocations']),
      onNewRelationship: json['onNewRelationship'] == null ? null : RequestDVO.fromJson(json['onNewRelationship'] as Map<String, dynamic>),
      onExistingRelationship:
          json['onExistingRelationship'] == null ? null : RequestDVO.fromJson(json['onExistingRelationship'] as Map<String, dynamic>),
      request: json['request'] == null ? null : LocalRequestDVO.fromJson(json['request'] as Map<String, dynamic>),
      content: RelationshipTemplateContentDerivation.fromJson(json['content'] as Map<String, dynamic>),
      forIdentity: json['forIdentity'] as String?,
      passwordProtection: json['passwordProtection'] == null ? null : PasswordProtection.fromJson(json['passwordProtection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PeerRelationshipTemplateDVOToJson(PeerRelationshipTemplateDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      'isOwn': instance.isOwn,
      'createdBy': instance.createdBy.toJson(),
      'createdByDevice': instance.createdByDevice,
      'createdAt': instance.createdAt,
      if (instance.expiresAt case final value?) 'expiresAt': value,
      if (const OptionalIntegerConverter().toJson(instance.maxNumberOfAllocations) case final value?) 'maxNumberOfAllocations': value,
      if (instance.onNewRelationship?.toJson() case final value?) 'onNewRelationship': value,
      if (instance.onExistingRelationship?.toJson() case final value?) 'onExistingRelationship': value,
      if (instance.request?.toJson() case final value?) 'request': value,
      'content': instance.content.toJson(),
      if (instance.forIdentity case final value?) 'forIdentity': value,
      if (instance.passwordProtection?.toJson() case final value?) 'passwordProtection': value,
    };
