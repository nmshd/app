// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_deletion_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerDeletionInfo _$PeerDeletionInfoFromJson(Map<String, dynamic> json) => PeerDeletionInfo(
      deletionStatus: $enumDecode(_$PeerDeletionStatusEnumMap, json['deletionStatus']),
      deletionDate: json['deletionDate'] as String,
    );

Map<String, dynamic> _$PeerDeletionInfoToJson(PeerDeletionInfo instance) => <String, dynamic>{
      'deletionStatus': _$PeerDeletionStatusEnumMap[instance.deletionStatus]!,
      'deletionDate': instance.deletionDate,
    };

const _$PeerDeletionStatusEnumMap = {
  PeerDeletionStatus.ToBeDeleted: 'ToBeDeleted',
  PeerDeletionStatus.Deleted: 'Deleted',
};
