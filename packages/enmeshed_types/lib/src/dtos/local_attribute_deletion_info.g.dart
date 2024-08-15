// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_attribute_deletion_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalAttributeDeletionInfo _$LocalAttributeDeletionInfoFromJson(Map<String, dynamic> json) => LocalAttributeDeletionInfo(
      deletionStatus: $enumDecode(_$AttributeDeletionStatusEnumMap, json['deletionStatus']),
      deletionDate: json['deletionDate'] as String,
    );

Map<String, dynamic> _$LocalAttributeDeletionInfoToJson(LocalAttributeDeletionInfo instance) => <String, dynamic>{
      'deletionStatus': _$AttributeDeletionStatusEnumMap[instance.deletionStatus]!,
      'deletionDate': instance.deletionDate,
    };

const _$AttributeDeletionStatusEnumMap = {
  AttributeDeletionStatus.DeletionRequestSent: 'DeletionRequestSent',
  AttributeDeletionStatus.DeletionRequestRejected: 'DeletionRequestRejected',
  AttributeDeletionStatus.ToBeDeleted: 'ToBeDeleted',
  AttributeDeletionStatus.ToBeDeletedByPeer: 'ToBeDeletedByPeer',
  AttributeDeletionStatus.DeletedByPeer: 'DeletedByPeer',
  AttributeDeletionStatus.DeletedByOwner: 'DeletedByOwner',
};
