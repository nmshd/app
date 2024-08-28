// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_deletion_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerDeletionInfo _$PeerDeletionInfoFromJson(Map<String, dynamic> json) => PeerDeletionInfo(
      deletionStatus: $enumDecode(_$PeerDeletionStatusEnumMap, json['deletionStatus']),
    );

Map<String, dynamic> _$PeerDeletionInfoToJson(PeerDeletionInfo instance) => <String, dynamic>{
      'deletionStatus': _$PeerDeletionStatusEnumMap[instance.deletionStatus]!,
    };

const _$PeerDeletionStatusEnumMap = {
  PeerDeletionStatus.ToBeDeleted: 'ToBeDeleted',
  PeerDeletionStatus.Deleted: 'Deleted',
};
