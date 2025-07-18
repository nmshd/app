// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_template_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipTemplateDVO _$RelationshipTemplateDVOFromJson(Map<String, dynamic> json) => RelationshipTemplateDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  isOwn: json['isOwn'] as bool,
  createdBy: IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
  createdByDevice: json['createdByDevice'] as String,
  createdAt: json['createdAt'] as String,
  expiresAt: json['expiresAt'] as String?,
  maxNumberOfAllocations: const OptionalIntegerConverter().fromJson((json['maxNumberOfAllocations'] as num?)?.toInt()),
  onNewRelationship: json['onNewRelationship'] == null ? null : RequestDVO.fromJson(json['onNewRelationship'] as Map<String, dynamic>),
  onExistingRelationship: json['onExistingRelationship'] == null ? null : RequestDVO.fromJson(json['onExistingRelationship'] as Map<String, dynamic>),
  request: json['request'] == null ? null : LocalRequestDVO.fromJson(json['request'] as Map<String, dynamic>),
  content: RelationshipTemplateContentDerivation.fromJson(json['content'] as Map<String, dynamic>),
  forIdentity: json['forIdentity'] as String?,
  passwordProtection: json['passwordProtection'] == null ? null : PasswordProtection.fromJson(json['passwordProtection'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RelationshipTemplateDVOToJson(RelationshipTemplateDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'isOwn': instance.isOwn,
  'createdBy': instance.createdBy.toJson(),
  'createdByDevice': instance.createdByDevice,
  'createdAt': instance.createdAt,
  'expiresAt': ?instance.expiresAt,
  'maxNumberOfAllocations': ?const OptionalIntegerConverter().toJson(instance.maxNumberOfAllocations),
  'onNewRelationship': ?instance.onNewRelationship?.toJson(),
  'onExistingRelationship': ?instance.onExistingRelationship?.toJson(),
  'request': ?instance.request?.toJson(),
  'content': instance.content.toJson(),
  'forIdentity': ?instance.forIdentity,
  'passwordProtection': ?instance.passwordProtection?.toJson(),
};
