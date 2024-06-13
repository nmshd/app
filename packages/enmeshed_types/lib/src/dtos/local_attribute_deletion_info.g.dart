// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_attribute_deletion_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalAttributeDeletionInfo _$LocalAttributeDeletionInfoFromJson(Map<String, dynamic> json) => LocalAttributeDeletionInfo(
      deletionStatus: $enumDecode(_$DeletionStatusEnumMap, json['deletionStatus']),
      deletionDate: json['deletionDate'] as String,
    );

Map<String, dynamic> _$LocalAttributeDeletionInfoToJson(LocalAttributeDeletionInfo instance) => <String, dynamic>{
      'deletionStatus': _$DeletionStatusEnumMap[instance.deletionStatus]!,
      'deletionDate': instance.deletionDate,
    };

const _$DeletionStatusEnumMap = {
  DeletionStatus.DeletionRequestSent: 'DeletionRequestSent',
  DeletionStatus.DeletionRequestRejected: 'DeletionRequestRejected',
  DeletionStatus.ToBeDeleted: 'ToBeDeleted',
  DeletionStatus.ToBeDeletedByPeer: 'ToBeDeletedByPeer',
  DeletionStatus.DeletedByPeer: 'DeletedByPeer',
  DeletionStatus.DeletedByOwner: 'DeletedByOwner',
};
