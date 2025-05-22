// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenDTO _$TokenDTOFromJson(Map<String, dynamic> json) => TokenDTO(
  id: json['id'] as String,
  createdBy: json['createdBy'] as String,
  createdByDevice: json['createdByDevice'] as String,
  content: TokenContent.fromJson(json['content'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String,
  expiresAt: json['expiresAt'] as String,
  isEphemeral: json['isEphemeral'] as bool,
  forIdentity: json['forIdentity'] as String?,
  passwordProtection: json['passwordProtection'] == null ? null : PasswordProtection.fromJson(json['passwordProtection'] as Map<String, dynamic>),
  reference: ObjectReferenceDTO.fromJson(json['reference'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TokenDTOToJson(TokenDTO instance) => <String, dynamic>{
  'id': instance.id,
  'createdBy': instance.createdBy,
  'createdByDevice': instance.createdByDevice,
  'content': instance.content.toJson(),
  'createdAt': instance.createdAt,
  'expiresAt': instance.expiresAt,
  if (instance.forIdentity case final value?) 'forIdentity': value,
  'isEphemeral': instance.isEphemeral,
  if (instance.passwordProtection?.toJson() case final value?) 'passwordProtection': value,
  'reference': instance.reference.toJson(),
};
