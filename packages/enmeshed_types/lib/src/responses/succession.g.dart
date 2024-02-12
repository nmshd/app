// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'succession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyPeerAboutIdentityAttributeSuccessionResponse _$NotifyPeerAboutIdentityAttributeSuccessionResponseFromJson(Map<String, dynamic> json) =>
    NotifyPeerAboutIdentityAttributeSuccessionResponse(
      predecessor: LocalAttributeDTO.fromJson(json['predecessor'] as Map<String, dynamic>),
      successor: LocalAttributeDTO.fromJson(json['successor'] as Map<String, dynamic>),
      notificationId: json['notificationId'] as String,
    );

Map<String, dynamic> _$NotifyPeerAboutIdentityAttributeSuccessionResponseToJson(NotifyPeerAboutIdentityAttributeSuccessionResponse instance) =>
    <String, dynamic>{
      'predecessor': instance.predecessor.toJson(),
      'successor': instance.successor.toJson(),
      'notificationId': instance.notificationId,
    };

SucceedIdentityAttributeResponse _$SucceedIdentityAttributeResponseFromJson(Map<String, dynamic> json) => SucceedIdentityAttributeResponse(
      predecessor: LocalAttributeDTO.fromJson(json['predecessor'] as Map<String, dynamic>),
      successor: LocalAttributeDTO.fromJson(json['successor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SucceedIdentityAttributeResponseToJson(SucceedIdentityAttributeResponse instance) => <String, dynamic>{
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
