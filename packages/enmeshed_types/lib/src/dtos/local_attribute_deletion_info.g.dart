// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_attribute_deletion_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalAttributeDeletionInfo _$LocalAttributeDeletionInfoFromJson(Map<String, dynamic> json) => LocalAttributeDeletionInfo(
      deletionStatus: $enumDecode(_$LocalAttributeDeletionStatusEnumMap, json['deletionStatus']),
      deletionDate: json['deletionDate'] as String,
    );

Map<String, dynamic> _$LocalAttributeDeletionInfoToJson(LocalAttributeDeletionInfo instance) => <String, dynamic>{
      'deletionStatus': _$LocalAttributeDeletionStatusEnumMap[instance.deletionStatus]!,
      'deletionDate': instance.deletionDate,
    };

const _$LocalAttributeDeletionStatusEnumMap = {
  LocalAttributeDeletionStatus.DeletionRequestSent: 'DeletionRequestSent',
  LocalAttributeDeletionStatus.DeletionRequestRejected: 'DeletionRequestRejected',
  LocalAttributeDeletionStatus.ToBeDeleted: 'ToBeDeleted',
  LocalAttributeDeletionStatus.ToBeDeletedByPeer: 'ToBeDeletedByPeer',
  LocalAttributeDeletionStatus.DeletedByPeer: 'DeletedByPeer',
  LocalAttributeDeletionStatus.DeletedByOwner: 'DeletedByOwner',
};
