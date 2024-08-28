// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_audit_log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipAuditLogEntryDTO _$RelationshipAuditLogEntryDTOFromJson(Map<String, dynamic> json) => RelationshipAuditLogEntryDTO(
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as String,
      createdByDevice: json['createdByDevice'] as String,
      reason: $enumDecode(_$RelationshipAuditLogEntryReasonEnumMap, json['reason']),
      oldStatus: $enumDecodeNullable(_$RelationshipStatusEnumMap, json['oldStatus']),
      newStatus: $enumDecode(_$RelationshipStatusEnumMap, json['newStatus']),
    );

Map<String, dynamic> _$RelationshipAuditLogEntryDTOToJson(RelationshipAuditLogEntryDTO instance) {
  final val = <String, dynamic>{
    'createdAt': instance.createdAt,
    'createdBy': instance.createdBy,
    'createdByDevice': instance.createdByDevice,
    'reason': _$RelationshipAuditLogEntryReasonEnumMap[instance.reason]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('oldStatus', _$RelationshipStatusEnumMap[instance.oldStatus]);
  val['newStatus'] = _$RelationshipStatusEnumMap[instance.newStatus]!;
  return val;
}

const _$RelationshipAuditLogEntryReasonEnumMap = {
  RelationshipAuditLogEntryReason.Creation: 'Creation',
  RelationshipAuditLogEntryReason.AcceptanceOfCreation: 'AcceptanceOfCreation',
  RelationshipAuditLogEntryReason.RejectionOfCreation: 'RejectionOfCreation',
  RelationshipAuditLogEntryReason.RevocationOfCreation: 'RevocationOfCreation',
  RelationshipAuditLogEntryReason.Termination: 'Termination',
  RelationshipAuditLogEntryReason.ReactivationRequested: 'ReactivationRequested',
  RelationshipAuditLogEntryReason.AcceptanceOfReactivation: 'AcceptanceOfReactivation',
  RelationshipAuditLogEntryReason.RejectionOfReactivation: 'RejectionOfReactivation',
  RelationshipAuditLogEntryReason.RevocationOfReactivation: 'RevocationOfReactivation',
  RelationshipAuditLogEntryReason.Decomposition: 'Decomposition',
};

const _$RelationshipStatusEnumMap = {
  RelationshipStatus.Pending: 'Pending',
  RelationshipStatus.Active: 'Active',
  RelationshipStatus.Rejected: 'Rejected',
  RelationshipStatus.Revoked: 'Revoked',
  RelationshipStatus.Terminated: 'Terminated',
  RelationshipStatus.DeletionProposed: 'DeletionProposed',
};
