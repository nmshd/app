// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifiable_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifiableCredentialDTO _$VerifiableCredentialDTOFromJson(Map<String, dynamic> json) => VerifiableCredentialDTO(
  status: json['status'] as String,
  message: json['message'] as String,
  data: json['data'] as String,
  id: json['id'] as String,
);

Map<String, dynamic> _$VerifiableCredentialDTOToJson(VerifiableCredentialDTO instance) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'id': instance.id,
};
