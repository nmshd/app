// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_deletion_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityDeletionProcessDTO _$IdentityDeletionProcessDTOFromJson(Map<String, dynamic> json) => IdentityDeletionProcessDTO(
      id: json['id'] as String,
      status: $enumDecode(_$IdentityDeletionProcessStatusEnumMap, json['status']),
      createdAt: json['createdAt'] as String?,
      createdByDevice: json['createdByDevice'] as String?,
      approvalPeriodEndsAt: json['approvalPeriodEndsAt'] as String?,
      rejectedAt: json['rejectedAt'] as String?,
      rejectedByDevice: json['rejectedByDevice'] as String?,
      approvedAt: json['approvedAt'] as String?,
      approvedByDevice: json['approvedByDevice'] as String?,
      gracePeriodEndsAt: json['gracePeriodEndsAt'] as String?,
      cancelledAt: json['cancelledAt'] as String?,
      cancelledByDevice: json['cancelledByDevice'] as String?,
    );

Map<String, dynamic> _$IdentityDeletionProcessDTOToJson(IdentityDeletionProcessDTO instance) => <String, dynamic>{
      'id': instance.id,
      'status': _$IdentityDeletionProcessStatusEnumMap[instance.status]!,
      if (instance.createdAt case final value?) 'createdAt': value,
      if (instance.createdByDevice case final value?) 'createdByDevice': value,
      if (instance.approvalPeriodEndsAt case final value?) 'approvalPeriodEndsAt': value,
      if (instance.rejectedAt case final value?) 'rejectedAt': value,
      if (instance.rejectedByDevice case final value?) 'rejectedByDevice': value,
      if (instance.approvedAt case final value?) 'approvedAt': value,
      if (instance.approvedByDevice case final value?) 'approvedByDevice': value,
      if (instance.gracePeriodEndsAt case final value?) 'gracePeriodEndsAt': value,
      if (instance.cancelledAt case final value?) 'cancelledAt': value,
      if (instance.cancelledByDevice case final value?) 'cancelledByDevice': value,
    };

const _$IdentityDeletionProcessStatusEnumMap = {
  IdentityDeletionProcessStatus.WaitingForApproval: 'WaitingForApproval',
  IdentityDeletionProcessStatus.Rejected: 'Rejected',
  IdentityDeletionProcessStatus.Approved: 'Approved',
  IdentityDeletionProcessStatus.Cancelled: 'Cancelled',
};
