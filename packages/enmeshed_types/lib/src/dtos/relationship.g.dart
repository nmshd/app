// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipDTO _$RelationshipDTOFromJson(Map<String, dynamic> json) => RelationshipDTO(
  id: json['id'] as String,
  templateId: json['templateId'] as String,
  status: $enumDecode(_$RelationshipStatusEnumMap, json['status']),
  peer: json['peer'] as String,
  peerIdentity: IdentityDTO.fromJson(json['peerIdentity'] as Map<String, dynamic>),
  peerDeletionInfo: json['peerDeletionInfo'] == null ? null : PeerDeletionInfo.fromJson(json['peerDeletionInfo'] as Map<String, dynamic>),
  creationContent: RelationshipCreationContentDerivation.fromJson(json['creationContent'] as Map<String, dynamic>),
  auditLog: (json['auditLog'] as List<dynamic>).map((e) => RelationshipAuditLogEntryDTO.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$RelationshipDTOToJson(RelationshipDTO instance) => <String, dynamic>{
  'id': instance.id,
  'templateId': instance.templateId,
  'status': _$RelationshipStatusEnumMap[instance.status]!,
  'peer': instance.peer,
  'peerIdentity': instance.peerIdentity.toJson(),
  if (instance.peerDeletionInfo?.toJson() case final value?) 'peerDeletionInfo': value,
  'creationContent': instance.creationContent.toJson(),
  'auditLog': instance.auditLog.map((e) => e.toJson()).toList(),
};

const _$RelationshipStatusEnumMap = {
  RelationshipStatus.Pending: 'Pending',
  RelationshipStatus.Active: 'Active',
  RelationshipStatus.Rejected: 'Rejected',
  RelationshipStatus.Revoked: 'Revoked',
  RelationshipStatus.Terminated: 'Terminated',
  RelationshipStatus.DeletionProposed: 'DeletionProposed',
};
