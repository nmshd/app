// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalResponseDTO _$LocalResponseDTOFromJson(Map<String, dynamic> json) => LocalResponseDTO(
  createdAt: json['createdAt'] as String,
  content: Response.fromJson(json['content'] as Map<String, dynamic>),
  source: json['source'] == null ? null : LocalResponseSourceDTO.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LocalResponseDTOToJson(LocalResponseDTO instance) => <String, dynamic>{
  'createdAt': instance.createdAt,
  'content': instance.content.toJson(),
  if (instance.source?.toJson() case final value?) 'source': value,
};
