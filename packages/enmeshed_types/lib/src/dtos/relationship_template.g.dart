// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipTemplateDTO _$RelationshipTemplateDTOFromJson(Map<String, dynamic> json) => RelationshipTemplateDTO(
  id: json['id'] as String,
  isOwn: json['isOwn'] as bool,
  createdBy: json['createdBy'] as String,
  createdByDevice: json['createdByDevice'] as String,
  createdAt: json['createdAt'] as String,
  content: RelationshipTemplateContentDerivation.fromJson(json['content'] as Map<String, dynamic>),
  expiresAt: json['expiresAt'] as String?,
  maxNumberOfAllocations: (json['maxNumberOfAllocations'] as num?)?.toInt(),
  forIdentity: json['forIdentity'] as String?,
  passwordProtection: json['passwordProtection'] == null ? null : PasswordProtection.fromJson(json['passwordProtection'] as Map<String, dynamic>),
  reference: ObjectReferenceDTO.fromJson(json['reference'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RelationshipTemplateDTOToJson(RelationshipTemplateDTO instance) => <String, dynamic>{
  'id': instance.id,
  'isOwn': instance.isOwn,
  'createdBy': instance.createdBy,
  'createdByDevice': instance.createdByDevice,
  'createdAt': instance.createdAt,
  'content': instance.content.toJson(),
  'expiresAt': ?instance.expiresAt,
  'maxNumberOfAllocations': ?instance.maxNumberOfAllocations,
  'forIdentity': ?instance.forIdentity,
  'passwordProtection': ?instance.passwordProtection?.toJson(),
  'reference': instance.reference.toJson(),
};
