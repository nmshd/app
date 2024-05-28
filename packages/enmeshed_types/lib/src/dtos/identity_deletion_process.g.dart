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
      rejectedAt: json['rejectedAt'] as String?,
      rejectedByDevice: json['rejectedByDevice'] as String?,
      approvedAt: json['approvedAt'] as String?,
      approvedByDevice: json['approvedByDevice'] as String?,
      gracePeriodEndsAt: json['gracePeriodEndsAt'] as String?,
      cancelledAt: json['cancelledAt'] as String?,
      cancelledByDevice: json['cancelledByDevice'] as String?,
    );

Map<String, dynamic> _$IdentityDeletionProcessDTOToJson(IdentityDeletionProcessDTO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'status': _$IdentityDeletionProcessStatusEnumMap[instance.status]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('createdByDevice', instance.createdByDevice);
  writeNotNull('rejectedAt', instance.rejectedAt);
  writeNotNull('rejectedByDevice', instance.rejectedByDevice);
  writeNotNull('approvedAt', instance.approvedAt);
  writeNotNull('approvedByDevice', instance.approvedByDevice);
  writeNotNull('gracePeriodEndsAt', instance.gracePeriodEndsAt);
  writeNotNull('cancelledAt', instance.cancelledAt);
  writeNotNull('cancelledByDevice', instance.cancelledByDevice);
  return val;
}

const _$IdentityDeletionProcessStatusEnumMap = {
  IdentityDeletionProcessStatus.WaitingForApproval: 'WaitingForApproval',
  IdentityDeletionProcessStatus.Rejected: 'Rejected',
  IdentityDeletionProcessStatus.Approved: 'Approved',
  IdentityDeletionProcessStatus.Deleting: 'Deleting',
  IdentityDeletionProcessStatus.Cancelled: 'Cancelled',
};
