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
  gracePeriodEndsAt: json['gracePeriodEndsAt'] as String?,
  cancelledAt: json['cancelledAt'] as String?,
  cancelledByDevice: json['cancelledByDevice'] as String?,
);

Map<String, dynamic> _$IdentityDeletionProcessDTOToJson(IdentityDeletionProcessDTO instance) => <String, dynamic>{
  'id': instance.id,
  'status': _$IdentityDeletionProcessStatusEnumMap[instance.status]!,
  'createdAt': ?instance.createdAt,
  'createdByDevice': ?instance.createdByDevice,
  'gracePeriodEndsAt': ?instance.gracePeriodEndsAt,
  'cancelledAt': ?instance.cancelledAt,
  'cancelledByDevice': ?instance.cancelledByDevice,
};

const _$IdentityDeletionProcessStatusEnumMap = {IdentityDeletionProcessStatus.Active: 'Active', IdentityDeletionProcessStatus.Cancelled: 'Cancelled'};
