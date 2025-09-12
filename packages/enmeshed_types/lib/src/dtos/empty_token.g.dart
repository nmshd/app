// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyTokenDTO _$EmptyTokenDTOFromJson(Map<String, dynamic> json) => EmptyTokenDTO(
  id: json['id'] as String,
  expiresAt: json['expiresAt'] as String,
  passwordProtection: PasswordProtection.fromJson(json['passwordProtection'] as Map<String, dynamic>),
  reference: ObjectReferenceDTO.fromJson(json['reference'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EmptyTokenDTOToJson(EmptyTokenDTO instance) => <String, dynamic>{
  'id': instance.id,
  'expiresAt': instance.expiresAt,
  'passwordProtection': instance.passwordProtection.toJson(),
  'reference': instance.reference.toJson(),
};
