// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'succession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyPeerAboutRepositoryAttributeSuccessionResponse _$NotifyPeerAboutRepositoryAttributeSuccessionResponseFromJson(Map<String, dynamic> json) =>
    NotifyPeerAboutRepositoryAttributeSuccessionResponse(
      predecessor: LocalAttributeDTO.fromJson(json['predecessor'] as Map<String, dynamic>),
      successor: LocalAttributeDTO.fromJson(json['successor'] as Map<String, dynamic>),
      notificationId: json['notificationId'] as String,
    );

Map<String, dynamic> _$NotifyPeerAboutRepositoryAttributeSuccessionResponseToJson(NotifyPeerAboutRepositoryAttributeSuccessionResponse instance) =>
    <String, dynamic>{
      'predecessor': instance.predecessor.toJson(),
      'successor': instance.successor.toJson(),
      'notificationId': instance.notificationId,
    };

SucceedRepositoryAttributeResponse _$SucceedRepositoryAttributeResponseFromJson(Map<String, dynamic> json) => SucceedRepositoryAttributeResponse(
      predecessor: LocalAttributeDTO.fromJson(json['predecessor'] as Map<String, dynamic>),
      successor: LocalAttributeDTO.fromJson(json['successor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SucceedRepositoryAttributeResponseToJson(SucceedRepositoryAttributeResponse instance) => <String, dynamic>{
      'predecessor': instance.predecessor.toJson(),
      'successor': instance.successor.toJson(),
    };

SucceedRelationshipAttributeAndNotifyPeerResponse _$SucceedRelationshipAttributeAndNotifyPeerResponseFromJson(Map<String, dynamic> json) =>
    SucceedRelationshipAttributeAndNotifyPeerResponse(
      predecessor: LocalAttributeDTO.fromJson(json['predecessor'] as Map<String, dynamic>),
      successor: LocalAttributeDTO.fromJson(json['successor'] as Map<String, dynamic>),
      notificationId: json['notificationId'] as String,
    );

Map<String, dynamic> _$SucceedRelationshipAttributeAndNotifyPeerResponseToJson(SucceedRelationshipAttributeAndNotifyPeerResponse instance) =>
    <String, dynamic>{
      'predecessor': instance.predecessor.toJson(),
      'successor': instance.successor.toJson(),
      'notificationId': instance.notificationId,
    };
