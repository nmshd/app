// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalRequestDTO _$LocalRequestDTOFromJson(Map<String, dynamic> json) => LocalRequestDTO(
  id: json['id'] as String,
  isOwn: json['isOwn'] as bool,
  peer: json['peer'] as String,
  createdAt: json['createdAt'] as String,
  status: $enumDecode(_$LocalRequestStatusEnumMap, json['status']),
  content: Request.fromJson(json['content'] as Map<String, dynamic>),
  source: json['source'] == null ? null : LocalRequestSourceDTO.fromJson(json['source'] as Map<String, dynamic>),
  response: json['response'] == null ? null : LocalResponseDTO.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LocalRequestDTOToJson(LocalRequestDTO instance) => <String, dynamic>{
  'id': instance.id,
  'isOwn': instance.isOwn,
  'peer': instance.peer,
  'createdAt': instance.createdAt,
  'status': _$LocalRequestStatusEnumMap[instance.status]!,
  'content': instance.content.toJson(),
  if (instance.source?.toJson() case final value?) 'source': value,
  if (instance.response?.toJson() case final value?) 'response': value,
};

const _$LocalRequestStatusEnumMap = {
  LocalRequestStatus.Draft: 'Draft',
  LocalRequestStatus.Open: 'Open',
  LocalRequestStatus.DecisionRequired: 'DecisionRequired',
  LocalRequestStatus.ManualDecisionRequired: 'ManualDecisionRequired',
  LocalRequestStatus.Decided: 'Decided',
  LocalRequestStatus.Completed: 'Completed',
  LocalRequestStatus.Expired: 'Expired',
};
