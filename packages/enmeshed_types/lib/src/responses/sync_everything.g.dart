// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_everything.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncEverythingResponse _$SyncEverythingResponseFromJson(Map<String, dynamic> json) => SyncEverythingResponse(
  relationships: (json['relationships'] as List<dynamic>).map((e) => RelationshipDTO.fromJson(e as Map<String, dynamic>)).toList(),
  messages: (json['messages'] as List<dynamic>).map((e) => MessageDTO.fromJson(e as Map<String, dynamic>)).toList(),
  identityDeletionProcesses: (json['identityDeletionProcesses'] as List<dynamic>)
      .map((e) => IdentityDeletionProcessDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SyncEverythingResponseToJson(SyncEverythingResponse instance) => <String, dynamic>{
  'relationships': instance.relationships.map((e) => e.toJson()).toList(),
  'messages': instance.messages.map((e) => e.toJson()).toList(),
  'identityDeletionProcesses': instance.identityDeletionProcesses.map((e) => e.toJson()).toList(),
};
