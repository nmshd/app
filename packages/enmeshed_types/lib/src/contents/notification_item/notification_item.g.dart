// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerSharedAttributeSucceededNotificationItem _$PeerSharedAttributeSucceededNotificationItemFromJson(Map<String, dynamic> json) =>
    PeerSharedAttributeSucceededNotificationItem(
      predecessorId: json['predecessorId'] as String,
      successorId: json['successorId'] as String,
      successorContent: AbstractAttribute.fromJson(json['successorContent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PeerSharedAttributeSucceededNotificationItemToJson(PeerSharedAttributeSucceededNotificationItem instance) => <String, dynamic>{
      'predecessorId': instance.predecessorId,
      'successorId': instance.successorId,
      'successorContent': instance.successorContent.toJson(),
    };

OwnSharedAttributeDeletedByOwnerNotificationItem _$OwnSharedAttributeDeletedByOwnerNotificationItemFromJson(Map<String, dynamic> json) =>
    OwnSharedAttributeDeletedByOwnerNotificationItem(
      attributeId: json['attributeId'] as String,
    );

Map<String, dynamic> _$OwnSharedAttributeDeletedByOwnerNotificationItemToJson(OwnSharedAttributeDeletedByOwnerNotificationItem instance) =>
    <String, dynamic>{
      'attributeId': instance.attributeId,
    };

PeerSharedAttributeDeletedByPeerNotificationItem _$PeerSharedAttributeDeletedByPeerNotificationItemFromJson(Map<String, dynamic> json) =>
    PeerSharedAttributeDeletedByPeerNotificationItem(
      attributeId: json['attributeId'] as String,
    );

Map<String, dynamic> _$PeerSharedAttributeDeletedByPeerNotificationItemToJson(PeerSharedAttributeDeletedByPeerNotificationItem instance) =>
    <String, dynamic>{
      'attributeId': instance.attributeId,
    };

ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItem _$ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItemFromJson(
        Map<String, dynamic> json) =>
    ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItem(
      attributeId: json['attributeId'] as String,
    );

Map<String, dynamic> _$ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItemToJson(
        ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItem instance) =>
    <String, dynamic>{
      'attributeId': instance.attributeId,
    };
